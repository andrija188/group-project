extends CharacterBody2D

var player: Node2D = null
var speed: float = 200.0

func _physics_process(delta):
	if not player:
		player = get_tree().get_first_node_in_group("player")

	if player:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO
		
	move_and_slide()
