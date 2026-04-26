extends CharacterBody2D

signal died

var player: Node2D
var speed: float = 100.0
var hp = 5
var follow = true

func _ready():
	player = get_tree().get_first_node_in_group("player")
	
	# Povezivanje sa Main skriptom
	var main_node = get_tree().current_scene
	if main_node and main_node.has_method("_on_enemy_killed"):
		died.connect(main_node._on_enemy_killed)

func _physics_process(_delta):
	if follow and is_instance_valid(player):
		var direction = (player.global_position - global_position).normalized()
		velocity = velocity.lerp(direction * speed, 0.1)
		move_and_slide()
	
	if hp <= 0:
		die()

func die():
	died.emit()
	queue_free()

func _on_hurtbox_area_entered(area):
	if area.is_in_group("bullet"):
		hp -= 1

var damage_amount = 5 


func _on_hurtbox_body_entered(body):
	print("kurac")
	
	if body.is_in_group("player"):
		body.take_damage(damage_amount)
