@tool
extends Resource
class_name InputIconScheme
# We have a copy of the keys as an array for two reasons:
# 1. We cannot iterate over the [param @GlobalScope.Key] enumerator, just reference it.
# 2. In order to NOT add the 193 keyboards keys manualy, we can populate them in code.
static var keys: Array[int] = [
	KEY_NONE,
	KEY_SPECIAL,
	KEY_ESCAPE,
	KEY_TAB,
	KEY_BACKTAB,
	KEY_BACKSPACE,
	KEY_ENTER,
	KEY_KP_ENTER,
	KEY_INSERT,
	KEY_DELETE,
	KEY_PAUSE,
	KEY_PRINT,
	KEY_SYSREQ,
	KEY_CLEAR,
	KEY_HOME,
	KEY_END,
	KEY_LEFT,
	KEY_UP,
	KEY_RIGHT,
	KEY_DOWN,
	KEY_PAGEUP,
	KEY_PAGEDOWN,
	KEY_SHIFT,
	KEY_CTRL,
	KEY_META,
	KEY_ALT,
	KEY_CAPSLOCK,
	KEY_NUMLOCK,
	KEY_SCROLLLOCK,
	KEY_F1,
	KEY_F2,
	KEY_F3,
	KEY_F4,
	KEY_F5,
	KEY_F6,
	KEY_F7,
	KEY_F8,
	KEY_F9,
	KEY_F10,
	KEY_F11,
	KEY_F12,
	KEY_F13,
	KEY_F14,
	KEY_F15,
	KEY_F16,
	KEY_F17,
	KEY_F18,
	KEY_F19,
	KEY_F20,
	KEY_F21,
	KEY_F22,
	KEY_F23,
	KEY_F24,
	KEY_F25,
	KEY_F26,
	KEY_F27,
	KEY_F28,
	KEY_F29,
	KEY_F30,
	KEY_F31,
	KEY_F32,
	KEY_F33,
	KEY_F34,
	KEY_F35,
	KEY_KP_MULTIPLY,
	KEY_KP_DIVIDE,
	KEY_KP_SUBTRACT,
	KEY_KP_PERIOD,
	KEY_KP_ADD,
	KEY_KP_0,
	KEY_KP_1,
	KEY_KP_2,
	KEY_KP_3,
	KEY_KP_4,
	KEY_KP_5,
	KEY_KP_6,
	KEY_KP_7,
	KEY_KP_8,
	KEY_KP_9,
	KEY_MENU,
	KEY_HYPER,
	KEY_HELP,
	KEY_BACK,
	KEY_FORWARD,
	KEY_STOP,
	KEY_REFRESH,
	KEY_VOLUMEDOWN,
	KEY_VOLUMEMUTE,
	KEY_VOLUMEUP,
	KEY_MEDIAPLAY,
	KEY_MEDIASTOP,
	KEY_MEDIAPREVIOUS,
	KEY_MEDIANEXT,
	KEY_MEDIARECORD,
	KEY_HOMEPAGE,
	KEY_FAVORITES,
	KEY_SEARCH,
	KEY_STANDBY,
	KEY_OPENURL,
	KEY_LAUNCHMAIL,
	KEY_LAUNCHMEDIA,
	KEY_LAUNCH0,
	KEY_LAUNCH1,
	KEY_LAUNCH2,
	KEY_LAUNCH3,
	KEY_LAUNCH4,
	KEY_LAUNCH5,
	KEY_LAUNCH6,
	KEY_LAUNCH7,
	KEY_LAUNCH8,
	KEY_LAUNCH9,
	KEY_LAUNCHA,
	KEY_LAUNCHB,
	KEY_LAUNCHC,
	KEY_LAUNCHD,
	KEY_LAUNCHE,
	KEY_LAUNCHF,
	KEY_GLOBE,
	KEY_KEYBOARD,
	KEY_JIS_EISU,
	KEY_JIS_KANA,
	KEY_UNKNOWN,
	KEY_SPACE,
	KEY_EXCLAM,
	KEY_QUOTEDBL,
	KEY_NUMBERSIGN,
	KEY_DOLLAR,
	KEY_PERCENT,
	KEY_AMPERSAND,
	KEY_APOSTROPHE,
	KEY_PARENLEFT,
	KEY_PARENRIGHT,
	KEY_ASTERISK,
	KEY_PLUS,
	KEY_COMMA,
	KEY_MINUS,
	KEY_PERIOD,
	KEY_SLASH,
	KEY_0,
	KEY_1,
	KEY_2,
	KEY_3,
	KEY_4,
	KEY_5,
	KEY_6,
	KEY_7,
	KEY_8,
	KEY_9,
	KEY_COLON,
	KEY_SEMICOLON,
	KEY_LESS,
	KEY_EQUAL,
	KEY_GREATER,
	KEY_QUESTION,
	KEY_AT,
	KEY_A,
	KEY_B,
	KEY_C,
	KEY_D,
	KEY_E,
	KEY_F,
	KEY_G,
	KEY_H,
	KEY_I,
	KEY_J,
	KEY_K,
	KEY_L,
	KEY_M,
	KEY_N,
	KEY_O,
	KEY_P,
	KEY_Q,
	KEY_R,
	KEY_S,
	KEY_T,
	KEY_U,
	KEY_V,
	KEY_W,
	KEY_X,
	KEY_Y,
	KEY_Z,
	KEY_BRACKETLEFT,
	KEY_BACKSLASH,
	KEY_BRACKETRIGHT,
	KEY_ASCIICIRCUM,
	KEY_UNDERSCORE,
	KEY_QUOTELEFT,
	KEY_BRACELEFT,
	KEY_BAR,
	KEY_BRACERIGHT,
	KEY_ASCIITILDE,
	KEY_YEN,
	KEY_SECTION
]
static var mouse_buttons: Array[int] = [
	MOUSE_BUTTON_NONE,
	MOUSE_BUTTON_LEFT,
	MOUSE_BUTTON_RIGHT,
	MOUSE_BUTTON_MIDDLE,
	MOUSE_BUTTON_WHEEL_UP,
	MOUSE_BUTTON_WHEEL_DOWN,
	MOUSE_BUTTON_WHEEL_LEFT,
	MOUSE_BUTTON_WHEEL_RIGHT,
	MOUSE_BUTTON_XBUTTON1,
	MOUSE_BUTTON_XBUTTON2
]
static var joy_buttons: Array[int] = [
	JOY_BUTTON_INVALID,
	JOY_BUTTON_A,
	JOY_BUTTON_B,
	JOY_BUTTON_X,
	JOY_BUTTON_Y,
	JOY_BUTTON_BACK,
	JOY_BUTTON_GUIDE,
	JOY_BUTTON_START,
	JOY_BUTTON_LEFT_STICK,
	JOY_BUTTON_RIGHT_STICK,
	JOY_BUTTON_LEFT_SHOULDER,
	JOY_BUTTON_RIGHT_SHOULDER,
	JOY_BUTTON_DPAD_UP,
	JOY_BUTTON_DPAD_DOWN,
	JOY_BUTTON_DPAD_LEFT,
	JOY_BUTTON_DPAD_RIGHT,
	JOY_BUTTON_MISC1,
	JOY_BUTTON_PADDLE1,
	JOY_BUTTON_PADDLE2,
	JOY_BUTTON_PADDLE3,
	JOY_BUTTON_PADDLE4,
	JOY_BUTTON_TOUCHPAD,
	JOY_BUTTON_SDL_MAX,
	JOY_BUTTON_MAX
]

static var joy_axis_buttons: Array[Dictionary] = [
	{"axis": JOY_AXIS_LEFT_X, "axis_value": - 1},
	{"axis": JOY_AXIS_LEFT_X, "axis_value": + 1},
	{"axis": JOY_AXIS_INVALID, "axis_value": 0},
	{"axis": JOY_AXIS_LEFT_Y, "axis_value": - 1},
	{"axis": JOY_AXIS_LEFT_Y, "axis_value": + 1},
	{"axis": JOY_AXIS_RIGHT_X, "axis_value": - 1},
	{"axis": JOY_AXIS_RIGHT_X, "axis_value": + 1},
	{"axis": JOY_AXIS_RIGHT_Y, "axis_value": - 1},
	{"axis": JOY_AXIS_RIGHT_Y, "axis_value": + 1},
	{"axis": JOY_AXIS_TRIGGER_LEFT, "axis_value": 1},
	{"axis": JOY_AXIS_TRIGGER_RIGHT, "axis_value": 1},
]

static var mouse_motion_directions: Array[Dictionary] = [
	{"axis": Vector2.AXIS_X, "axis_value": -1},
	{"axis": Vector2.AXIS_X, "axis_value": 1},
	{"axis": Vector2.AXIS_Y, "axis_value": -1},
	{"axis": Vector2.AXIS_Y, "axis_value": 1},
]

## [b]DESTRUCTIVE[/b] it will fill arrays below with empty [class KeyIcons]
@export var generate_presets: bool = false:
	set = set_generate_preset

@export var keyboard: Array[KeyIcon] = []
@export var mouse: Array[KeyIcon] = []

## @tutorial(Guidance):  https://docs.godotengine.org/en/stable/classes/class_%40globalscope.html#enum-globalscope-joybutton
@export var joy: Array[KeyIcon] = []

@export var joy_axis: Array[KeyIcon] = []

@export var mouse_motions: Array[KeyIcon] = []

# i wish i had a button
func set_generate_preset(value: bool) -> void:
	generate_presets = value
	if not Engine.is_editor_hint():
		return

	if generate_presets:
		keyboard = populate_key_icons(keys, KeyIcon.InputTypes.KEYBOARD)
		mouse = populate_key_icons(mouse_buttons, KeyIcon.InputTypes.MOUSE)
		joy = populate_key_icons(joy_buttons, KeyIcon.InputTypes.JOY_BUTTON)
		joy_axis = populate_key_icons_for_axis(joy_axis_buttons, KeyIcon.InputTypes.JOY_AXIS)
		mouse_motions = populate_key_icons_for_axis(mouse_motion_directions, KeyIcon.InputTypes.JOY_AXIS)
	generate_presets = false

func populate_key_icons(array: Array, type: KeyIcon.InputTypes) -> Array[KeyIcon]:
	var arr: Array[KeyIcon] = []
	for code in array:
		var key_icon: KeyIcon = KeyIcon.new()
		key_icon.input_type = type
		key_icon.keycode = code
		arr.append(key_icon)
	return arr

func populate_key_icons_for_axis(array: Array, type: KeyIcon.InputTypes) -> Array[KeyIcon]:
	var arr: Array[KeyIcon] = []
	for pair in array:
		var key_icon: KeyIcon = KeyIcon.new()
		key_icon.input_type = type
		key_icon.keycode = pair.axis
		key_icon.axis_value = pair.axis_value
		arr.append(key_icon)
	return arr

## We gram the KeyIcon Resource by its keycode and type
func get_key_icon(keycode: int, type: KeyIcon.InputTypes) -> KeyIcon:
	match type:
		KeyIcon.InputTypes.KEYBOARD:
			return get_key_icon_by_keycode(keycode, keyboard)
		KeyIcon.InputTypes.MOUSE:
			return get_key_icon_by_keycode(keycode, mouse)
		KeyIcon.InputTypes.JOY_BUTTON:
			return get_key_icon_by_keycode(keycode, joy)
	# for key_icon in keyboard:
	# 	if key_icon.keycode == keycode:
	# 		return key_icon
	return null

func get_key_icon_by_axis(axis: int, axis_value: float):
	for key_icon in joy_axis:
		if key_icon.keycode == axis and is_equal_approx(key_icon.axis_value, signf(axis_value)):
			return key_icon
	return null

func get_key_icon_by_relative_motion(relative: Vector2i):
	var axis_index := -1

	if abs(relative.x) > abs(relative.y):
		axis_index = Vector2.AXIS_X
	else:
		axis_index = Vector2.AXIS_Y

	for key_icon in mouse_motions:
		if key_icon.keycode == axis_index and is_equal_approx(key_icon.axis_value, signf(relative[axis_index])):
			return key_icon
	return null

## We grab the KeyIcon Resource by its keycode in an array, its more of a helper function
func get_key_icon_by_keycode(keycode: int, array: Array[KeyIcon]) -> KeyIcon:
	for key_icon in array:
		if key_icon.keycode == keycode:
			return key_icon
	return null
