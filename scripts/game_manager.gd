extends Node

@onready var monedas: Node = %Monedas
@onready var hud: CanvasLayer = %HUD

var monedas_totales: int = 0
var monedas_recolectadas: int = 0

func _ready() -> void:
	monedas_recolectadas = 0
	if monedas != null:
		monedas_totales = monedas.get_child_count()

func recolectar_moneda():
	monedas_recolectadas += 1
	hud.actualizar_label_monedas(monedas_recolectadas, monedas_totales)

func _on_hud_ready() -> void:
	hud.actualizar_label_monedas(monedas_recolectadas, monedas_totales)
