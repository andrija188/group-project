extends CharacterBody2D

#player
const SPEED = 300.0
const RUN_SPEED = 600.0
const ACCELERATION = 1200.0
const FRICTION = 750.0

#dash
const DASH_SPEED = 1000.0
const DASH_TIME = 0.2
const DASH_COOLDOWN = 3.0

var dash_timer = 0.0
var dash_cooldown_timer = 0.0
var is_dashing = false
var dash_direction = Vector2.ZERO

#bullet
@export var bullet: PackedScene
var bullet_speed := 100
var bullet_direction := 0.0
var can_shoot = true

func _ready() -> void:
	bullet_direction = global_rotation

func shoot():
	if not can_shoot:
		return
	
	can_shoot = false

	var bullet_instance = bullet.instantiate()
	bullet_instance.global_position = global_position
	var dir = (get_global_mouse_position() - global_position).normalized()
	bullet_instance.rotation = dir.angle()
	bullet_instance.direction = dir
	get_tree().root.add_child(bullet_instance)
	
	#cooldown
	await get_tree().create_timer(0.2).timeout
	can_shoot = true

func _physics_process(delta: float) -> void:
	var input_dir = Vector2.ZERO
	
	input_dir.x = Input.get_axis("left", "right")
	input_dir.y = Input.get_axis("up", "down")
	
	if input_dir.length() > 0:
		input_dir = input_dir.normalized()
	
	# cooldown se smanjuje
	if dash_cooldown_timer > 0:
		dash_cooldown_timer -= delta
	
	# DASH (Q)
	if Input.is_action_just_pressed("dash") and dash_cooldown_timer <= 0:
		is_dashing = true
		dash_timer = DASH_TIME
		dash_cooldown_timer = DASH_COOLDOWN
		
		# zapamti smer
		if input_dir != Vector2.ZERO:
			dash_direction = input_dir
		else:
			dash_direction = Vector2.RIGHT  # ako stoji
	
	# dok dash traje
	if is_dashing:
		velocity = dash_direction * DASH_SPEED
		dash_timer -= delta
		
		if dash_timer <= 0:
			is_dashing = false
	else:
		# normalno kretanje
		var current_speed = SPEED
		if Input.is_action_pressed("run"):
			current_speed = RUN_SPEED
		
		var target_velocity = input_dir * current_speed
		
		if input_dir != Vector2.ZERO:
			velocity = velocity.move_toward(target_velocity, ACCELERATION * delta)
		else:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	if Input.is_action_pressed("shoot"):
		shoot()
	
	move_and_slide()
