extends Node2D

@export var radio_patruya = 50.0
@export var velocidad_patruya = 5.0
@export var velocidad_ataque = 500.0
@export var velocidad_regreso = 300.0
@export var radio_deteccion = 200.0
@export var tiempo_enfriamiento = 2.5
@export var demora_antes_de_atacar = 1.0
@export var tiempo_espera_post_regreso = 0.5

@onready var jugador: CharacterBody2D = %Personaje

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var posicion_origen
var posicion_transicion: Vector2
var angulo = 0.0
var en_ataque = false
var en_enfriamiento = false
var esperando_post_regreso = false
var temporizador_post_regreso = 0.0

enum Estado { PATRULLANDO, ESPERANDO, ATACANDO, REGRESANDO, TRANSICIONANDO_A_PATRULLA }
var estado = Estado.PATRULLANDO

var posicion_objetivo_ataque
var posicion_regreso
var temporizador_enfriamiento = 0.0
var temporizador_espera = 0.0

func _ready():
	posicion_origen = global_position

func _process(delta):
	animated_sprite_2d.flip_h = jugador.global_position.x >= global_position.x
		
	match estado:
		Estado.PATRULLANDO:
			animated_sprite_2d.play("patrullando")
			if esperando_post_regreso:
				temporizador_post_regreso += delta
				if temporizador_post_regreso >= tiempo_espera_post_regreso:
					esperando_post_regreso = false
			else:
				patrullar(delta)
			verificar_proximidad_jugador()
		Estado.ESPERANDO:
			temporizador_espera += delta
			animated_sprite_2d.play("esperando")
			if temporizador_espera >= demora_antes_de_atacar:
				temporizador_espera = 0.0
				comenzar_ataque()
		Estado.ATACANDO:
			mover_hacia(posicion_objetivo_ataque, delta, velocidad_ataque)
			animated_sprite_2d.play("atacando")
			if global_position.distance_to(posicion_objetivo_ataque) < 5.0:
				estado = Estado.REGRESANDO
		Estado.REGRESANDO:
			mover_hacia(posicion_regreso, delta, velocidad_regreso)
			animated_sprite_2d.play("regresando")
			if global_position.distance_to(posicion_regreso) < 50.0:
				# Ajustar el ángulo para retomar el círculo sin saltos
				var direccion = global_position - posicion_origen
				angulo = direccion.angle()
				posicion_transicion = posicion_origen + Vector2(cos(angulo), sin(angulo)) * radio_patruya
				estado = Estado.TRANSICIONANDO_A_PATRULLA
		Estado.TRANSICIONANDO_A_PATRULLA:
			mover_hacia(posicion_transicion, delta, velocidad_regreso)
			animated_sprite_2d.play("patrullando")
			if global_position.distance_to(posicion_transicion) < 50.0:
				global_position = posicion_transicion  # Para asegurar la precisión
				esperando_post_regreso = true
				temporizador_post_regreso = 0.0
				en_enfriamiento = true
				temporizador_enfriamiento = 0.0
				estado = Estado.PATRULLANDO
				
	if en_enfriamiento:
		temporizador_enfriamiento += delta
		if temporizador_enfriamiento >= tiempo_enfriamiento:
			en_enfriamiento = false

func patrullar(delta):
	angulo += velocidad_patruya * delta
	global_position = posicion_origen + Vector2(cos(angulo), sin(angulo)) * radio_patruya

func verificar_proximidad_jugador():
	if jugador and not en_enfriamiento:
		if global_position.distance_to(jugador.global_position) <= radio_deteccion:
			estado = Estado.ESPERANDO

func comenzar_ataque():
	posicion_objetivo_ataque = jugador.global_position
	posicion_regreso = posicion_origen
	estado = Estado.ATACANDO
	ReproductorMusica.reproducir_efecto_de_sonido(GLOBAL.EFECTOS_SONIDO["ATAQUE_TERO"], -5)
	await get_tree().create_timer(0.32).timeout
	ReproductorMusica.reproducir_efecto_de_sonido(GLOBAL.EFECTOS_SONIDO["ATAQUE_TERO"], -5)

func mover_hacia(objetivo: Vector2, delta, velocidad):
	var direccion = (objetivo - global_position).normalized()
	global_position += direccion * velocidad * delta


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == GLOBAL.PERSONAJE["NOMBRE_ELEMENTO"]:
		body.daniar_con_impulso(Vector2(position.x, position.y))
