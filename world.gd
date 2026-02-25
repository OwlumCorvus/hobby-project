extends Node2D

@onready var player = $Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Tree.interacted.connect(_on_tree_clicked)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_tree_clicked(tree_object):
	player.interact_with_object(tree_object)
