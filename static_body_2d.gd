extends StaticBody2D

var is_chopped: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func interact() -> void:
	if is_chopped:
		return
	become_stump()

func become_stump() -> void:
	is_chopped = true
	GameManager.add_wood(1)
	$Sprite2D.modulate = Color(0.5,0.3,0.1)
	

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventScreenTouch or event is InputEventMouseButton:
		if event.pressed:
			interact()
