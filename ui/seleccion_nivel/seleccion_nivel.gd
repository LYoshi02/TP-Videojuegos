extends Node

@export var total_monedas: int
@export var id_nivel: int
@export var id_nivel_anterior: int

@onready var nivel_boton: Button = $NivelBoton
@onready var completado_label: Label = $CompletadoLabel
@onready var monedas_label: Label = $MonedasLabel

func _ready():
	var progreso = GLOBAL.obtener_progreso_nivel(id_nivel)
	completado_label.text = "Completado: " + str(progreso.completado)
	monedas_label.text = "Monedas: " + str(int(progreso.monedas)).pad_zeros(2) + "/" + str(int(total_monedas)).pad_zeros(2)
	nivel_boton.text = str(id_nivel)

	if id_nivel_anterior > 0:
		var progreso_nivel_anterior = GLOBAL.obtener_progreso_nivel(id_nivel_anterior)
		if not progreso_nivel_anterior.completado:
			nivel_boton.disabled = true

func _on_nivel_boton_pressed() -> void:
	var pantalla_nivel = "NIVEL_" + str(id_nivel)
	get_tree().change_scene_to_file(GLOBAL.PANTALLAS[pantalla_nivel])
