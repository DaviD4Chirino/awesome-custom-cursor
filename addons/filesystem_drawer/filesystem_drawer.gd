@tool
extends EditorPlugin
## Converts the FileSystem dock to a FileSystem Drawer at the bottom of the editor.
##
## TODO: Add a preferences menu and add custom keybinding support


enum DrawerMode {NORMAL, BOTTOM}

const DEFAULT_SHORTCUT: InputEventKey = preload("res://addons/filesystem_drawer/default_shortcut.tres")
const MOVE_TOOLMENU_ITEM: String = "Move FileSystem to bottom"
const RESET_TOOLMENU_ITEM: String = "Reset FileSystem location"
const CONFIG_FILENAME: String = "/filesystem_drawer.cfg"

var CONFIG_FILEPATH: String
var _config := ConfigFile.new()
var _filesystem: FileSystemDock
var _drawer_mode: DrawerMode = DrawerMode.BOTTOM
var _open: bool = false


func _enter_tree() -> void:
	set_process(false)
	set_process_input(false)
	CONFIG_FILEPATH = get_editor_interface().get_editor_paths().get_config_dir() + CONFIG_FILENAME
	_filesystem = get_editor_interface().get_file_system_dock()
	# TODO: Get rid of this somehow?
	await get_tree().create_timer(0.1).timeout
	
	_load_config()
	_setup_tool_menus()
	if _drawer_mode == DrawerMode.BOTTOM:
		_move_filesystem_dock()
	set_process(true)
	set_process_input(true)


func _process(_delta: float) -> void:
	if not _drawer_mode == DrawerMode.BOTTOM:
		return
	
	# Adjust the size of the file system based on how far up
	# the drawer has been pulled
	var size: Vector2 = _filesystem.get_parent().size
	_filesystem.get_child(3).get_child(0).size.y = size.y - 60
	_filesystem.get_child(3).get_child(1).size.y = size.y - 60


func _input(event: InputEvent) -> void:
	if not _drawer_mode == DrawerMode.BOTTOM:
		return
		
	if not DEFAULT_SHORTCUT.is_match(event) or not event.is_released() or event.is_echo():
		return
	
	_open = not _open
	if _open:
		make_bottom_panel_item_visible(_filesystem)
	else:
		hide_bottom_panel()


func _exit_tree() -> void:
	if _drawer_mode == DrawerMode.BOTTOM:
		_drawer_mode = DrawerMode.NORMAL
		_move_filesystem_dock()
	
	remove_tool_menu_item(MOVE_TOOLMENU_ITEM)
	remove_tool_menu_item(RESET_TOOLMENU_ITEM)


func _save_config() -> void:
	_config.set_value("FileSystem Drawer", "drawer_mode", _drawer_mode)
	_config.save(CONFIG_FILEPATH)


func _load_config() -> void:
	if FileAccess.file_exists(CONFIG_FILEPATH):
		_config.load(CONFIG_FILEPATH)
		_drawer_mode = _config.get_value("FileSystem Drawer", "drawer_mode", true)
	else:
		_save_config()


func _setup_tool_menus() -> void:
	match _drawer_mode:
		DrawerMode.NORMAL:
			add_tool_menu_item(MOVE_TOOLMENU_ITEM, _on_toolmenu_item_clicked)
			remove_tool_menu_item(RESET_TOOLMENU_ITEM)
		DrawerMode.BOTTOM:
			add_tool_menu_item(RESET_TOOLMENU_ITEM, _on_toolmenu_item_clicked)
			remove_tool_menu_item(MOVE_TOOLMENU_ITEM)


func _move_filesystem_dock() -> void:
	match _drawer_mode:
		DrawerMode.NORMAL:
			remove_control_from_bottom_panel(_filesystem)
			add_control_to_dock(EditorPlugin.DOCK_SLOT_LEFT_BR, _filesystem)
		DrawerMode.BOTTOM:
			remove_control_from_docks(_filesystem)
			add_control_to_bottom_panel(_filesystem, "FileSystem")


func _on_toolmenu_item_clicked() -> void:
	_drawer_mode = abs(_drawer_mode - 1) # Toggles between the 2 enums
	_setup_tool_menus()
	_move_filesystem_dock()
	_save_config()
