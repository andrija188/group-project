extends CharacterBody2D

@onready var player = $"../player for now"
var speed: float = 100.0

var follow: = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player for now":
		follow = true

func _physics_process(delta: float) -> void:
	if follow:
		var direction = (player.global_position-global_position).normalized()
		velocity = lerp(velocity, direction * speed, 60*delta)
	move_and_slide()
