extends CharacterBody2D

enum State {IDLE, MOVING, INTERACTING}
var current_state = State.IDLE
var target_interactable = null

@export var speed: float = 200.0
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D

func _physics_process(delta: float) -> void:
	match current_state:
		State.MOVING:
			_process_movement()
		State.INTERACTING:
			_process_interaction()

func _process_movement():
	if nav_agent.is_navigation_finished():
		if target_interactable:
			current_state = State.INTERACTING
		else:
			current_state = State.IDLE
		return
		
	var next_path_pos = nav_agent.get_next_path_position()
	var new_velocity = global_position.direction_to(next_path_pos) * speed
	
	velocity = new_velocity
	move_and_slide()
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			move_to_pos(get_global_mouse_position())

func move_to_pos(target: Vector2):
	target_interactable = null
	nav_agent.target_position = target
	current_state = State.MOVING

func _process_interaction():
	if target_interactable:
		await get_tree().create_timer(2.0).timeout
		target_interactable = null
		current_state = State.IDLE

func interact_with_object(object: Interactable):
	target_interactable = object
	nav_agent.target_position = object.global_position
	current_state = State.MOVING

func _on_tree_interacted(destination_pos: Variant) -> void:
	pass # Replace with function body.
