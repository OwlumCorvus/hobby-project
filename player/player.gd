extends CharacterBody2D

var speed: float = 250.0
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D

func _ready() -> void:
	nav_agent.path_desired_distance = 4.0
	nav_agent.target_desired_distance = 4.0

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			nav_agent.target_position = get_global_mouse_position()

func _physics_process(_delta: float) -> void:
	if nav_agent.is_navigation_finished():
		return
	var next_pos = nav_agent.get_next_path_position()
	print("player", global_position, "next", next_pos)
	velocity = global_position.direction_to(next_pos) * speed
	
	move_and_slide()
