extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.wood_changed.connect(_on_wood_changed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_wood_changed(new_amount):
	text = "Wood: " + str(new_amount)
