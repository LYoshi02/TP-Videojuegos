extends Node

@export var id_nivel: int
@export var id_nivel_anterior: int

@onready var nivel_boton: Button = $NivelBoton
@onready var estrellas_contenedor: HBoxContainer = $EstrellasContenedor

func _ready():
	var progreso = GLOBAL.obtener_progreso_nivel(id_nivel)
	nivel_boton.text = str(id_nivel)
	estrellas_contenedor.pintar_estrellas(int(progreso.estrellas))

	if id_nivel_anterior > 0:
		var progreso_nivel_anterior = GLOBAL.obtener_progreso_nivel(id_nivel_anterior)
		if not progreso_nivel_anterior.completado:
			nivel_boton.disabled = true
			# estrellas_contenedor.hide()

func _on_nivel_boton_pressed() -> void:
	var pantalla_nivel = "NIVEL_" + str(id_nivel)
	get_tree().change_scene_to_file(GLOBAL.PANTALLAS[pantalla_nivel])
