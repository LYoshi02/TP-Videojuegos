extends CharacterBody2D


const VELOCIDAD_MOVIMIENTO = 225.0
const VELOCIDAD_SALTO = -425.0

@onready var game_manager: Node = %GameManager

@onready var sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var area_ataque: Area2D = $AreaAtaque
@onready var timer_inmunidad: Timer = $TimerInmunidad
@onready var timer_parpadeo: Timer = $TimerParpadeo

var atacando = false
var saltando = false
var es_inmune: bool = false
var direccion_movimiento: String = "derecha"

func saltar():
	velocity.y = VELOCIDAD_SALTO

func saltar_al_costado(x):
	velocity.y = VELOCIDAD_SALTO
	velocity.x = x

func saltar_verticalmente(y):
	velocity.y = y

func atacar():	
	if not atacando:
		atacando = true
	
	var objetos_atacados = area_ataque.get_overlapping_areas()
	for objeto in objetos_atacados:
		var objeto_padre = objeto.get_parent()
		if objeto_padre.is_in_group(GLOBAL.GRUPOS["ROMPIBLE"]):
			objeto_padre.romper()

func actualizar_posicion_area_ataque():
	match direccion_movimiento:
		"derecha":
			area_ataque.position = Vector2(15, 0)
		"izquierda":
			area_ataque.position = Vector2(-15, 0)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ataque"):
		atacar()

func _physics_process(delta: float) -> void:
	# Animations
	if is_on_floor():
		saltando = false
		if atacando:
			sprite_2d.play("atacar")
		elif velocity.x > 1 || velocity.x < -1:
			sprite_2d.play("correr")
		else:
			sprite_2d.play("idle")
	else:
		velocity += get_gravity() * delta
		if atacando:
			sprite_2d.play("atacar")
		elif not saltando:
			saltando = true
			sprite_2d.play("saltar")
		elif saltando and velocity.y > 0:
			sprite_2d.play("caer")

	# Handle jump.
	if Input.is_action_just_pressed("salto") and is_on_floor():
		ReproductorMusica.reproducir_efecto_de_sonido(GLOBAL.EFECTOS_SONIDO["SALTO"])
		velocity.y = VELOCIDAD_SALTO

	# Get the input direction and handle the movement/deceleration.
	var direccion := Input.get_axis("izquierda", "derecha")
	if atacando and is_on_floor():
		velocity.x = 0
	elif direccion:
		velocity.x = direccion * VELOCIDAD_MOVIMIENTO
	else:
		velocity.x = move_toward(velocity.x, 0, 30)

	move_and_slide()
	actualizar_posicion_area_ataque()

	if Input.is_action_pressed('izquierda'):
		sprite_2d.flip_h = true
		direccion_movimiento = "izquierda"
	if Input.is_action_pressed('derecha'):
		sprite_2d.flip_h = false
		direccion_movimiento = "derecha"

func daniar_con_impulso(posicion_impacto: Vector2):
	var x_delta = position.x - posicion_impacto.x
	var y_delta = position.y - posicion_impacto.y
	var fuerza_salto = 0
	var es_ultima_vida = game_manager.es_ultima_vida()

	if not es_ultima_vida and not es_inmune:
		# Determinar si el impacto fue más horizontal o vertical
		if abs(x_delta) > abs(y_delta):
			# Impacto lateral → saltar hacia el mismo lado del impacto
			if x_delta > 0:
				fuerza_salto = 500  # impacto desde la derecha → saltar a la derecha
			else:
				fuerza_salto = -500 # impacto desde la izquierda → saltar a la izquierda
		
			saltar_al_costado(fuerza_salto)
		else:
			# Impacto vertical → saltar en dirección del impacto
			if y_delta > 0:
				fuerza_salto = 500  # impacto desde abajo → saltar hacia abajo
			else:
				fuerza_salto = -500 # impacto desde arriba → saltar hacia arriba
			
			saltar_verticalmente(fuerza_salto)

	daniar_personaje()

func daniar_personaje():
	var era_inmune = es_inmune
	if not era_inmune:
		es_inmune = true
		timer_inmunidad.start()
		timer_parpadeo.start()
		print("Decrease health")
		game_manager.reducir_vida()

func reaparecer():
	var es_ultima_vida = game_manager.es_ultima_vida()
	daniar_personaje()
	if not es_ultima_vida:
		game_manager.reaparecer_jugador(self)

func _on_animated_sprite_2d_animation_finished() -> void:
	if sprite_2d.animation == "atacar":
		atacando = false

func _on_timer_inmunidad_timeout() -> void:
	es_inmune = false
	timer_parpadeo.stop()
	sprite_2d.visible = true
	sprite_2d.modulate.a = 1

func _on_timer_parpadeo_timeout() -> void:
	sprite_2d.visible = !sprite_2d.visible
	sprite_2d.modulate.a = 0.8
