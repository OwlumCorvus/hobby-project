extends CharacterBody2D

enum State {IDLE, MOVING, INTERACTING}
var current_state = State.IDLE
var target_interactable = null

@export var speed: float = 200.0
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var interaction_bar = $InteractionBar

func _physics_process(_delta: float) -> void:
	match current_state:
		State.MOVING:
			_process_movement()
		State.INTERACTING:
			_process_interaction()

func _process_movement():
	print("distance: " + str(nav_agent.distance_to_target()))
	if nav_agent.is_navigation_finished():
		print("Nav Complete!")
		if target_interactable:
			current_state = State.INTERACTING
		else:
			current_state = State.IDLE
		return
		
	var next_path_pos = nav_agent.get_next_path_position()
	var new_velocity = global_position.direction_to(next_path_pos) * speed
	
	velocity = new_velocity
	move_and_slide()
	
#func _unhandled_input(event: InputEvent) -> void:
	#if event is InputEventMouseButton:
		#if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			#move_to_pos(get_global_mouse_position())

func move_to_pos(target: Vector2):
	print("Moving to: " + str(target))
	target_interactable = null
	nav_agent.target_position = target
	current_state = State.MOVING

func _process_interaction():
	
	velocity = Vector2.ZERO
	print("visible")
	interaction_bar.visible = true
	interaction_bar.value = 0
		
	var tween = create_tween()
	tween.tween_property(interaction_bar, "value", 100, 2.0)
		
	await get_tree().create_timer(2.0).timeout
	
	print("done")
	interaction_bar.visible = false
	target_interactable = null
	current_state = State.IDLE

func interact_with_object(object: Interactable):
	print("Moving to: " + object.object_name)
	target_interactable = object
	nav_agent.target_position = object.global_position
	current_state = State.MOVING
