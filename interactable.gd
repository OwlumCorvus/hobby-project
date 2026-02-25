extends StaticBody2D
class_name Interactable

@export var object_name: String = "Generic Object"

signal interacted(destination_pos)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	input_pickable = true

func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			interacted.emit(global_position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
