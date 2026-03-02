extends StaticBody2D
class_name Interactable

signal dropped_items(item)

@export var obj_data: ObjectResource = preload("res://WorldObjects/Objects/pine_tree.tres")
@onready var object_progress_bar: TextureProgressBar = $ObjectProgressBar
@onready var action_timer: Timer = $ActionTimer
@onready var depleted_timer: Timer = $DepletedTimer
@onready var object_label: Label = $ObjectLabel
@onready var object_sprite: Sprite2D = $Sprite2D
var is_near: bool = false
var capacity = obj_data.obj_capacity

func _ready() -> void:
	depleted_timer.wait_time = obj_data.obj_wait_time_depleted
	action_timer.wait_time = obj_data.obj_wait_time_action
	object_sprite.texture = obj_data.obj_sprites[0]
	object_label.text = obj_data.obj_name
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
			if action_timer.is_stopped() and capacity > 0:
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


func _on_action_timer_timeout() -> void:
	if capacity <= 0:
		action_timer.stop()
		object_progress_bar.visible = false
		depleted_timer.start()
		# swap sprites
	var item_drop: Array = []
	item_drop.append(obj_data.obj_items[0])
	# random bonus chance
	capacity -= 1
	for items in item_drop:
		dropped_items.emit(items)


func _on_depleted_timer_timeout() -> void:
	depleted_timer.stop()
	capacity = obj_data.obj_capacity
	# swap sprites
