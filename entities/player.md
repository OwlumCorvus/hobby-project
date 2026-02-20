# TODO:
* [ ] `player.tscn`: CharacterBody2D node
* [ ] `player.gd`: Script for "Tap to Move" logic.
* [ ] `sprite_sheet.png`: The 2D pixel art.
* [ ] **Logic Note:** Use `NavigationAgent2D` for the pathfinding so the player doesn't walk through walls.
* [ ] Sounds for player movement.
```GDScript
extends CharacterBody2D

@export var speed = 200
var target = Vector2.ZERO

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		target = get_global_mouse_position()

func _physics_process(delta):
	velocity = position.direction_to(target) * speed
	# Stop moving if we are close to the target
	if position.distance_to(target) > 10:
		move_and_slide()
```
