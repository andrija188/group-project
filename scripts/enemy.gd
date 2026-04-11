extends CharacterBody2D

@onready var player = $Player
var speed: float = 1000.0
var follow = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == player:
		follow = true

func _physics_process(delta):
	if follow:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
	move_and_slide()
