extends CharacterBody2D

@onready var player = get_tree().get_first_node_in_group("player")
var speed: float = 1000.0
var follow = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		follow = true
		print("TOUCHED:", body.name)

func _physics_process(delta):
	if follow and player:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
	move_and_slide()
