## Global Class for all the script in the Awesome Input Icons plugin
class_name InputIcon

##NOTE: Since for now the configuration only contains the scheme, this may seem redundant, BUT, in the future you can add more things to the configuration.
static var configuration = load("res://addons/awesome_input_icons/input_icon_configuration.tres")

## This one is written like this because the get function would not cooperate
static var scheme: InputIconScheme = load("res://addons/awesome_input_icons/input_icon_configuration.tres").scheme

## The main function, give it an action in your [param InputMap] and a optional event index, it returns you a [param Texture2D] that represents the icon
static func get_icon(action: StringName, event_index: int=0) -> Texture2D:

	# To put it simply: we isolate the [class InputEvent] 
	# and call [function get_icon_by_event]

	var events: Array[InputEvent] = _get_events(action)

	if not events:
		return null

	if event_index > events.size():
		push_warning("The action does not have index of " + str(event_index))
		return null

	var event: InputEvent = events[event_index]

	return get_icon_by_event(event)

## Given an action, it returns all their event icons in an array, including the nulls
static func get_all_icons(action: StringName) -> Array[Texture2D]:
	var icons: Array[Texture2D] = []
	var events: Array[InputEvent] = _get_events(action)

	if not events:
		return []

	for i in events.size():
		icons.append(get_icon_by_event(events[i]))
	
	return icons
## [b]Tip:[/b] You can call this instead of get_icon if you only have an [class InputEvent]
static func get_icon_by_event(event: InputEvent) -> Texture2D:
	var icon: Texture2D = null

	## Since the [param key] value in the [param KeyIcon] depends on its type, we need to check the class of the event, once with the event class we can get the icon with proper type context

	match event.get_class():
		"InputEventKey":
			var keycode = event.keycode if event.keycode else event.physical_keycode
			icon = scheme.get_key_icon(keycode, KeyIcon.InputTypes.KEYBOARD).icon

		"InputEventMouseButton":
			icon = scheme.get_key_icon(event.button_index, KeyIcon.InputTypes.MOUSE).icon

		"InputEventJoypadButton":
			icon = scheme.get_key_icon(event.button_index, KeyIcon.InputTypes.JOY_BUTTON).icon

		"InputEventJoypadMotion":
			icon = scheme.get_key_icon_by_axis(event.axis, event.axis_value).icon

		"InputEventMouseMotion":
			icon = scheme.get_key_icon_by_relative_motion(event.relative).icon

		_:
			printerr("Unsupported event type: " + str(event))

	return icon

static func _get_events(action: StringName) -> Array[InputEvent]:
	var events: Array[InputEvent] = InputMap.action_get_events(action)

	if not events:
		if action:
			push_warning("No events found for action: " + action)
		else:
			push_warning("The action String is empty!")

		return []

	return events
