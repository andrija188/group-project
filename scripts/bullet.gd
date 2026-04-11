extends Node2D

var speed := 100
var direction := 0.0

func _ready() -> void:
	direction = global_rotation

func _process(delta: float) -> void:
	if Input.is_action_pressed("shoot"):
		var velocity = Vector2(speed, 0).rotated(direction)
		position += velocity * delta
