extends CharacterBody2D


const VELOCIDAD_MOVIMIENTO = 400.0
const VELOCIDAD_SALTO = -600.0

@onready var sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var saltando = false

func saltar():
	velocity.y = VELOCIDAD_SALTO

func saltar_al_costado(x):
	velocity.y = VELOCIDAD_SALTO
	velocity.x = x

func _physics_process(delta: float) -> void:
	# Animations
	if is_on_floor():
		saltando = false
		if velocity.x > 1 || velocity.x < -1:
			sprite_2d.play("correr")
		else:
			sprite_2d.play("idle")
	else:
		velocity += get_gravity() * delta
		if not saltando:
			saltando = true
			sprite_2d.play("saltar")
		elif saltando and velocity.y > 0:
			sprite_2d.play("caer")

	# Handle jump.
	if Input.is_action_just_pressed("salto") and is_on_floor():
		velocity.y = VELOCIDAD_SALTO

	# Get the input direction and handle the movement/deceleration.
	var direccion := Input.get_axis("izquierda", "derecha")
	if direccion:
		velocity.x = direccion * VELOCIDAD_MOVIMIENTO
	else:
		velocity.x = move_toward(velocity.x, 0, 30)

	move_and_slide()

	if Input.is_action_just_pressed('izquierda'):
		sprite_2d.flip_h = true
	if Input.is_action_just_pressed('derecha'):
		sprite_2d.flip_h = false
	
