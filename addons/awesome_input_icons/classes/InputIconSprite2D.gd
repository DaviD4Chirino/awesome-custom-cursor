## This is a sprite2d that takes an action name and automatically loads the proper icon
extends Sprite2D
class_name InputIconSprite2D

## The name of the action in your InputMap, it has to be an existing action
@export var action_name: StringName = &"":
	set(value):
		action_name = value
		_update()

## The Index of the event, if you have more than one event in the same action.
## You can use negative numbers but not a number bigger than the number of events
@export var event_index: int = 0:
	set(value):
		event_index = value
		_update()

func _update():
	texture = InputIcon.get_icon(
		action_name, event_index
		)
 