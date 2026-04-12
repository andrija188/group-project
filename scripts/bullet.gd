extends Area2D

@export var speed := 800.0
var direction := Vector2.ZERO

func _process(delta):
	position += direction * speed * delta


func _on_area_entered(area: Area2D) -> void:
	queue_free()
