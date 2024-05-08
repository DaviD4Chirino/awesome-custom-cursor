@tool
extends Button
## Base code by Nathan Hoad (https://github.com/nathanhoad)
## at https://github.com/nathanhoad/godot_dialogue_manager
## This rendition was also based on BenjaTK (https://github.com/BenjaTK/Gaea)

## The github repo like so:
## https://api.github.com/repos/{{USER_NAME}}/{{REPO_NAME}}/releases
@export var RELEASES_URL: String = "https://api.github.com/repos/"
## The addon path, usually [b]plugin.cfg[/b]
@export var LOCAL_CONFIG_PATH: String = ""
## The name of the addon, usually the name of the folder 
@export var addon_name: String = ""
## The title, With spaces and all that
@export var addon_title: String = ""

@export_category("Nodes")
@export var http_request: HTTPRequest
@export var download_dialog: AcceptDialog
@export var update_failed_dialog: AcceptDialog
@export var download_update_panel: Control

var editor_plugin: EditorPlugin

func _ready() -> void:
	_connect_signals()
	hide()
	_check_for_update()

func _check_for_update() -> void:
	http_request.request(RELEASES_URL)

func _on_http_request_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	if result != HTTPRequest.RESULT_SUCCESS:
		return

	var current_version: String = _get_version()
	if current_version == null:
		push_error("Cannot find the current version of %s..." % addon_title)
		return

	var response = JSON.parse_string(body.get_string_from_utf8())
	if not (response is Array):
		return

	# GitHub releases are in order of creation, not order of version

	var versions = (response as Array).filter(
		func(release):
			var version: String=release.tag_name

			return _version_to_number(version) > _version_to_number(current_version))
	if versions.size() > 0:
		download_update_panel.next_version_release = versions[0]
		download_update_panel.addon_name = addon_name
		text = "%s v%s available" % [addon_title, versions[0].tag_name]
		show()

func _on_pressed() -> void:
	download_dialog.popup_centered()

func _on_download_update_updated(new_version: String):
	download_dialog.hide()

	editor_plugin.get_editor_interface().get_resource_filesystem().scan()

	print_rich("\n[b]Updated %s to v%s\n" % [addon_title, new_version])
	editor_plugin.get_editor_interface().call_deferred("set_plugin_enabled", addon_name, true)
	editor_plugin.get_editor_interface().set_plugin_enabled(addon_name, false)

func _on_download_update_failed():
	download_dialog.hide()
	update_failed_dialog.popup_centered()
	pass # Replace with function body.

func _get_version() -> String:
	var config: ConfigFile = ConfigFile.new()

	config.load(LOCAL_CONFIG_PATH)
	return config.get_value("plugin", "version")

## Follow semantic versioning OR DIE (https://semver.org)
func _version_to_number(version: String) -> int:
	var bits = version.split(".")
	return bits[0].to_int() * 1000000 + bits[1].to_int() * 1000 + bits[2].to_int()

func _connect_signals():
	pressed.connect(_on_pressed)
	http_request.request_completed.connect(_on_http_request_request_completed)
	download_update_panel.failed.connect(_on_download_update_failed)
	download_update_panel.updated.connect(_on_download_update_updated)
