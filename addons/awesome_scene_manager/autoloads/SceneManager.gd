extends CanvasLayer
# The general order of events is:
#	* start_transition is called
#	* resource begins and finish to load
#	* scene is changed (only when start_transition ends)
#	* end_transition is called
#	* SceneManager hides

## You need to have 2 animations, starting and ending. 
## They are separated by adding "_in" or "_out" as their suffix
## The transitions are your animations names so FADE becomes "fade_in" and or "fade_out"
enum Transitions {
	NONE,
	FADE
}
@export var default_transition_type: Transitions = Transitions.FADE

@export_group("Nodes")
@export var anim: AnimationPlayer

## The resource path
var scene_to_load: String = ""
var loading_resource: bool = false
var progress: Array = []
#Signals

signal transitioning_in
signal transitioning_out
signal scene_changed
## Emitted every frame the resource is being loaded
signal loading_scene(
	## An array with a float from 0 to 1
	progress: float
	)
## Emitted when the loading has ended
signal scene_loaded

func _ready():
	hide()

func _process(_delta: float):
	if not loading_resource:
		return
	var thread_status = ResourceLoader.load_threaded_get_status(scene_to_load, progress)

	match thread_status:
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			loading_scene.emit(progress[0])

		ResourceLoader.THREAD_LOAD_LOADED:
			scene_loaded.emit()
			loading_resource = false

		ResourceLoader.THREAD_LOAD_INVALID_RESOURCE:
			push_error("Resource %s invalid" % scene_to_load)
			loading_resource = false

		ResourceLoader.THREAD_LOAD_FAILED:
			push_error("Failed to load the resource %s" % scene_to_load)
			loading_resource = false

func change_scene(
	## The path to the scene you want to transition into
	scene_path: String,
	## The initial transition type
	trans_in: Transitions=Transitions.NONE,
	## The ending transition type, if set to -1 will be the the ending of the fade_in transition, otherwise use the Transitions 
	trans_out: int=- 1,
) -> void:

	if anim.is_playing():
		push_warning("Animation is already playing")
		return

	show()
	# if trans_out is -1 it means is the ending of trans_in,
	# so we give it the same type
	var out_transition: Transitions = trans_in if (
		trans_out == - 1) else (
			Transitions.values()[trans_out]
		)

	scene_to_load = scene_path

	# if we do not want a transition we do no wait for it
	if trans_in != Transitions.NONE:
		await start_transition(trans_in)

	# we start to load the scene
	ResourceLoader.load_threaded_request(scene_to_load)
	loading_resource = true

	# we change the scene after it loads
	await scene_loaded
	get_tree().change_scene_to_packed(
		ResourceLoader.load_threaded_get(
			scene_to_load
		)
	)
	scene_changed.emit()

	if out_transition != Transitions.NONE:
		await end_transition(out_transition)

	# after the whole process is done, we return to the initial position
	hide()

## replaces the [param scene_to_swap] with the scene passed in the [param scene_path]
func swap_scenes(
	## The path to the scene you want to change into
	scene_path: String,
	scene_to_swap: Node,
	trans_in: Transitions=Transitions.NONE,
	## The ending transition type, if set to -1 will be the the ending of the trans_in transition, otherwise use the Transitions 
	trans_out: int=- 1,

):
	if anim.is_playing():
		push_warning("Animation is already playing")
		return

	show()
	# if trans_out is -1 it means is the ending of trans_in,
	# so we give it the same type
	var out_transition: Transitions = trans_in if (
		trans_out == - 1) else (
			Transitions.values()[trans_out]
		)

	scene_to_load = scene_path

	if trans_in != Transitions.NONE:
		await start_transition(trans_in)

	# we start to load the scene
	ResourceLoader.load_threaded_request(scene_to_load)
	loading_resource = true

	# we change the scene after it loads
	await scene_loaded
	
	var scene_parent: Node = scene_to_swap.get_parent()
	# We store the scene position to add the new node to that exact position
	var scene_position: int = scene_to_swap.get_index()
	var new_scene = ResourceLoader.load_threaded_get(
			scene_to_load
		).instantiate()

	scene_parent.add_child(
		new_scene
	)
	scene_parent.move_child(
		new_scene,
		scene_position
	)
	#after all is done we delete the old scene, you may add a call deferred if you want
	scene_to_swap.queue_free()

	if out_transition != Transitions.NONE:
		await end_transition(out_transition)

	hide()

#
func start_transition(transition: Transitions) -> void:
	var anim_name: String = _get_anim_name(transition) + "_in"

	if not anim.has_animation(anim_name):
		push_warning("Theres no animation: %s" % anim_name)
		anim_name = _parse_transition_name(default_transition_type) + "_in"
	anim.play(anim_name)
	transitioning_in.emit()

	await anim.animation_finished

func end_transition(transition: Transitions) -> void:
	var anim_name: String = _get_anim_name(transition) + "_out"

	if not anim.has_animation(anim_name):
		push_warning("Theres no animation: %s" % anim_name)
		anim_name = _parse_transition_name(default_transition_type) + "_out"

	anim.play(anim_name)
	transitioning_out.emit()
	await anim.animation_finished

## returns the transition anim name if it exist, or the default transition type
func _get_anim_name(transition: Transitions) -> String:
	if Transitions.values().find(transition) == - 1:
		push_warning(
			"Transition type of %s does not exist" % transition
			)
		return _parse_transition_name(default_transition_type)

	return _parse_transition_name(transition)

# Private functions

func _parse_transition_name(transition: int) -> String:
	return Transitions.keys()[transition].to_lower()
