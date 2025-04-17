extends CharacterBody2D


const VELOCIDAD_MOVIMIENTO = 400.0
const VELOCIDAD_SALTO = -450.0

@onready var sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Animations
	#if velocity.x > 1 || velocity.x < -1:
		#sprite_2d.play("running")
	#else:
		#sprite_2d.play("idle")
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		#sprite_2d.play("jumping")

	# Handle jump.
	if Input.is_action_just_pressed("salto") and is_on_floor():
		velocity.y = VELOCIDAD_SALTO

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direccion := Input.get_axis("izquierda", "derecha")
	if direccion:
		velocity.x = direccion * VELOCIDAD_MOVIMIENTO
	else:
		velocity.x = move_toward(velocity.x, 0, 30)

	move_and_slide()

	#var isLeft = velocity.x < 0
	#sprite_2d.flip_h = isLeft
	if Input.is_action_just_pressed('izquierda'):
		sprite_2d.flip_h = true
	if Input.is_action_just_pressed('derecha'):
		sprite_2d.flip_h = false
	
