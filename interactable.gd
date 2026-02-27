extends StaticBody2D
class_name Interactable

@onready var object_progress_bar: TextureProgressBar = $ObjectProgressBar
@onready var action_timer: Timer = $ActionTimer
@onready var depleted_timer: Timer = $DepletedTimer
@onready var object_label: Label = $ObjectLabel

var is_near: bool = false

func _ready() -> void:
	input_pickable = true
	object_progress_bar.value = 0
	

func _process(_delta: float) -> void:
	if not action_timer.is_stopped():
		object_progress_bar.value = (1 - (action_timer.wait_time - action_timer.time_left) / action_timer.wait_time) * 100
	else:
		object_progress_bar.value = 0

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	get_viewport().set_input_as_handled()
	if event is InputEventMouseButton and event.pressed:
		if is_near and event.button_index == MOUSE_BUTTON_LEFT:
			if action_timer.is_stopped():
				object_progress_bar.visible = true
				action_timer.start()
			else:
				action_timer.stop()
				object_progress_bar.visible = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		is_near = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		is_near = false
		action_timer.stop()
		object_progress_bar.visible = false
