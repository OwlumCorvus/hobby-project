extends Node2D

@onready var player = $Player

func _ready() -> void:
	$Tree.interacted.connect(_on_tree_clicked)

func _on_tree_clicked(tree_object):
	player.interact_with_object(tree_object)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			var clicked_object = _get_clicked_object()
			if clicked_object is Interactable:
				player.interact_with_object(clicked_object)
			else:
				player.move_to_pos(get_global_mouse_position())
				
func _get_clicked_object():
	var space_state = get_world_2d().direct_space_state
	var params = PhysicsPointQueryParameters2D.new()
	params.position = get_global_mouse_position()
	params.collide_with_areas = true
	params.collide_with_bodies = true
	
	var results = space_state.intersect_point(params)
	if results.size() > 0:
		return results[0].collider
	return null
