extends Node

@export var id_nivel: int

@onready var personaje: CharacterBody2D = %Personaje
@onready var monedas: Node = %Monedas
@onready var hud: CanvasLayer = %HUD

var vidas = 3

var monedas_totales: int = 0
var monedas_recolectadas: int = 0

var posicion_inicial: Vector2
var ultimo_checkpoint: Node = null
var ultimo_id_progreso_checkpoint: int

func _ready() -> void:
	monedas_recolectadas = 0
	if monedas != null:
		monedas_totales = monedas.get_child_count()
	if personaje != null:
		posicion_inicial = personaje.position

func _on_hud_ready() -> void:
	hud.actualizar_label_monedas(monedas_recolectadas, monedas_totales)

func recolectar_moneda():
	monedas_recolectadas += 1
	hud.actualizar_label_monedas(monedas_recolectadas, monedas_totales)

func es_ultima_vida():
	return vidas == 1

func reducir_vida():
	vidas -= 1
	print("Vidas: ", vidas)
	hud.actualizar_vidas(vidas)
	
	if vidas <= 0:
		reaparecer_jugador(personaje)
		vidas = 3
		hud.actualizar_vidas(vidas)

func actualizar_checkpoint(checkpoint: Node, id_progreso: int):
	if id_progreso > ultimo_id_progreso_checkpoint:
		ultimo_id_progreso_checkpoint = id_progreso
		ultimo_checkpoint = checkpoint
		print("Nuevo checkpoint registrado: ", ultimo_id_progreso_checkpoint)

func reaparecer_jugador(jugador: Node2D):
	if ultimo_checkpoint:
		print("Reapareciendo en el último checkpoint.")
		jugador.global_position = ultimo_checkpoint.global_position
	else:
		print("No hay checkpoint registrado. Reapareciendo en el inicio.")
		jugador.global_position = posicion_inicial

func finalizar_nivel():
	GLOBAL.actualizar_nivel(id_nivel, monedas_recolectadas)
	get_tree().call_deferred("change_scene_to_file", GLOBAL.PANTALLAS["MENU_PRINCIPAL"])
