extends CharacterBody2D

@export var speed: float = 200.0
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D


func _physics_process(_delta: float) -> void:
	if nav_agent.is_navigation_finished():
		return
		
	var next_path_pos = nav_agent.get_next_path_position()
	var new_velocity = global_position.direction_to(next_path_pos) * speed
	
	velocity = new_velocity
	move_and_slide()
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			nav_agent.target_position = get_global_mouse_position()
