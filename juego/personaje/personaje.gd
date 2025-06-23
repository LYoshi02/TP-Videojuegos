extends CharacterBody2D

const VELOCIDAD_MOVIMIENTO: float = 225.0
const VELOCIDAD_SALTO: float = -450.0
const VELOCIDAD_SALTO_CORTO: float = -250
const DURACION_BUFFER_SALTO: float = 0.15
const DURACION_COYOTE: float = 0.15

@onready var game_manager: Node = %GameManager
@onready var sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var area_ataque: Area2D = $AreaAtaque
@onready var timer_inmunidad: Timer = $TimerInmunidad
@onready var timer_parpadeo: Timer = $TimerParpadeo

var atacando: bool = false
var saltando: bool = false
var salto_corto_activo: bool = false
var es_inmune: bool = false
var direccion_movimiento: String = "derecha"
var timer_buffer_salto: float = 0
var timer_coyote: float = 0
var efectos_corte: Array[Resource] = [GLOBAL.EFECTOS_SONIDO["ATAQUE_MACHETE_1"], GLOBAL.EFECTOS_SONIDO["ATAQUE_MACHETE_2"], 
		GLOBAL.EFECTOS_SONIDO["ATAQUE_MACHETE_3"]]
var nro_sfx_corte: int = 0
var animaciones_ataque: Array[String] = ["atacar", "atacar2", "atacar3"]
var nro_animacion_ataque: int = 0

func saltar() -> void:
	ReproductorMusica.reproducir_efecto_de_sonido(GLOBAL.EFECTOS_SONIDO["SALTO"], 20)
	velocity.y = VELOCIDAD_SALTO

func saltar_al_costado(x) -> void:
	velocity.y = VELOCIDAD_SALTO
	velocity.x = x

func saltar_verticalmente(y) -> void:
	velocity.y = y

func atacar() -> void:
	if not atacando:
		atacando = true
		reproducir_efecto_sonido_ataque()
	
	var objetos_atacados: Array[Area2D] = area_ataque.get_overlapping_areas()
	var objeto_roto: bool = false
	for objeto in objetos_atacados:
		var objeto_padre: Node = objeto.get_parent()
		if objeto_padre.is_in_group(GLOBAL.GRUPOS["ROMPIBLE"]):
			objeto_padre.romper()
			objeto_roto = true
	
	if objeto_roto:
		ReproductorMusica.reproducir_efecto_de_sonido(GLOBAL.EFECTOS_SONIDO["CORTE_ENREDADERA"], 5)

func reproducir_efecto_sonido_ataque() -> void:
	ReproductorMusica.reproducir_efecto_de_sonido(efectos_corte[nro_sfx_corte], 5)
	if nro_sfx_corte < efectos_corte.size() - 1:
		nro_sfx_corte += 1
	else:
		nro_sfx_corte = 0

func actualizar_posicion_area_ataque() -> void:
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
			reproducir_animacion_ataque()
		elif velocity.x > 1 || velocity.x < -1:
			sprite_2d.play("correr")
		else:
			sprite_2d.play("idle")
	else:
		velocity += get_gravity() * delta
		if atacando:
			reproducir_animacion_ataque()
		elif not saltando:
			saltando = true
			sprite_2d.play("saltar")
		elif saltando and velocity.y > 0:
			sprite_2d.play("caer")

	# Handle jump.
	if Input.is_action_just_pressed("salto"):
		timer_buffer_salto = DURACION_BUFFER_SALTO

	if timer_buffer_salto > 0.0:
		timer_buffer_salto -= delta
	
	if is_on_floor():
		timer_coyote = DURACION_COYOTE
		salto_corto_activo = false
	else:
		timer_coyote -= delta
	
	if timer_coyote > 0 and timer_buffer_salto > 0:
		saltar()
		timer_buffer_salto = 0
		timer_coyote = 0
	
	if Input.is_action_just_released("salto") and velocity.y < VELOCIDAD_SALTO_CORTO and not salto_corto_activo:
		salto_corto_activo = true
		velocity.y = VELOCIDAD_SALTO_CORTO
	
	# Get the input direction and handle the movement/deceleration.
	var direccion: float = Input.get_axis("izquierda", "derecha")
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

func daniar_con_impulso(posicion_impacto: Vector2) -> void:
	var x_delta: float = position.x - posicion_impacto.x
	var y_delta: float = position.y - posicion_impacto.y
	var fuerza_salto: int = 0
	var es_ultima_vida: bool = game_manager.es_ultima_vida()

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

func daniar_personaje() -> void:
	var era_inmune: bool = es_inmune
	if not era_inmune:
		es_inmune = true
		timer_inmunidad.start()
		timer_parpadeo.start()
		print("Decrease health")
		game_manager.reducir_vida()

func reaparecer() -> void:
	var es_ultima_vida: bool = game_manager.es_ultima_vida()
	daniar_personaje()
	if not es_ultima_vida:
		game_manager.reaparecer_jugador(self)

func reproducir_animacion_ataque() -> void:
	sprite_2d.play(animaciones_ataque[nro_animacion_ataque])

func _on_animated_sprite_2d_animation_finished() -> void:
	if sprite_2d.animation.containsn("atacar"):
		atacando = false
		if nro_animacion_ataque < animaciones_ataque.size() - 1:
			nro_animacion_ataque += 1
		else:
			nro_animacion_ataque = 0

func _on_timer_inmunidad_timeout() -> void:
	es_inmune = false
	timer_parpadeo.stop()
	sprite_2d.visible = true
	sprite_2d.modulate.a = 1

func _on_timer_parpadeo_timeout() -> void:
	sprite_2d.visible = !sprite_2d.visible
	sprite_2d.modulate.a = 0.8
