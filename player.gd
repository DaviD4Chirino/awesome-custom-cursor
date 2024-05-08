extends CharacterBody2D
@export var speed: float = 50
# @export var acceleration
func _physics_process(_delta):
	var direction = Input.get_vector(&"left", &"right", &"up", &"down")
	velocity = direction * speed
	move_and_slide()