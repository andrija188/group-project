extends CharacterBody2D

var player: Node2D
var speed: float = 100.0
var hp = 5

var follow = true

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		follow = true

func _physics_process(delta: float) -> void:
	if follow:
		var direction = (player.global_position-global_position).normalized()
		velocity = lerp(velocity, direction * speed, 60*delta)
	move_and_slide()
	
	if hp == 0:
		queue_free()

func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet"):
		hp = hp-1
