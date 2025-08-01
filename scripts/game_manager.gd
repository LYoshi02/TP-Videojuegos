extends Node

@export var id_nivel: int

@onready var personaje: CharacterBody2D = %Personaje
@onready var monedas: Node = %Monedas
@onready var hud: CanvasLayer = %HUD
@onready var fin_nivel: CanvasLayer = %FinNivel

var muertes: int = 0
var vidas: int = 3

var monedas_totales: int = 0
var monedas_recolectadas: int = 0

var posicion_inicial: Vector2
var ultimo_checkpoint: Node = null
var ultimo_id_progreso_checkpoint: int

# Tiempo de inicio del nivel en segundos
var tiempo_inicio: float

func _ready() -> void:
	monedas_recolectadas = 0
	if monedas != null:
		monedas_totales = contar_monedas(monedas)
		print("Monedas totales: " + str(monedas_totales))
	if personaje != null:
		posicion_inicial = personaje.global_position
		
	tiempo_inicio = Time.get_ticks_msec() / 1000.0

func _on_hud_ready() -> void:
	hud.actualizar_label_monedas(monedas_recolectadas, monedas_totales)

func recolectar_moneda() -> void:
	monedas_recolectadas += 1
	hud.actualizar_label_monedas(monedas_recolectadas, monedas_totales)

func es_ultima_vida() -> bool:
	return vidas == 1

func reducir_vida() -> void:
	vidas -= 1
	print("Vidas: ", vidas)
	hud.actualizar_vidas(vidas)
	
	if vidas <= 0:
		reaparecer_jugador(personaje)
		muertes += 1
		vidas = 3
		hud.actualizar_vidas(vidas)

func actualizar_checkpoint(checkpoint: Node, id_progreso: int) -> void:
	if id_progreso > ultimo_id_progreso_checkpoint:
		ultimo_id_progreso_checkpoint = id_progreso
		ultimo_checkpoint = checkpoint
		print("Nuevo checkpoint registrado: ", ultimo_id_progreso_checkpoint)

func reaparecer_jugador(jugador: Node2D) -> void:
	if ultimo_checkpoint:
		print("Reapareciendo en el último checkpoint.")
		jugador.global_position = ultimo_checkpoint.global_position
	else:
		print("No hay checkpoint registrado. Reapareciendo en el inicio.")
		jugador.global_position = posicion_inicial

func calcular_estrellas_conseguidas() -> int:
	var estrellas: int = 1
	if monedas_recolectadas == monedas_totales:
		estrellas += 1
	if muertes == 0:
		estrellas += 1
	return estrellas

func finalizar_nivel() -> void:
	var estrellas_conseguidas: int = calcular_estrellas_conseguidas()
	var tiempo_fin: float = Time.get_ticks_msec() / 1000.0
	var tiempo_total: float = tiempo_fin - tiempo_inicio
	print("Tiempo total:", tiempo_total, "segundos")

	GLOBAL.actualizar_nivel(id_nivel, monedas_recolectadas, estrellas_conseguidas, tiempo_total)
	fin_nivel.mostrar_pantalla_fin_nivel(monedas_recolectadas, monedas_totales, muertes, estrellas_conseguidas, tiempo_total)

func contar_monedas(nodo: Node) -> int:
	var contador: int = 0
	for hijo in nodo.get_children():
		if hijo.name.containsn("moneda"):
			contador += 1
		contador += contar_monedas(hijo)
	return contador
