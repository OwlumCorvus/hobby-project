extends CharacterBody2D
@export var speed: int = 300
var target_position: Vector2 = Vector2.ZERO
var is_moving: bool = false

func _ready() -> void:
	target_position = global_position

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton or event is InputEventScreenTouch:
		if event.pressed:
			print("click detected at:", get_global_mouse_position())
			target_position = get_global_mouse_position()
			is_moving = true

func _physics_process(_delta: float) -> void:
	if is_moving:
		var direction = global_position.direction_to(target_position)
		velocity = direction * speed
		if global_position.distance_to(target_position) < 5:
			velocity = Vector2.ZERO
			is_moving = false
		move_and_slide()
