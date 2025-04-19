extends Node

@onready var volver_boton: Button = $VolverBoton

func _on_volver_boton_pressed() -> void:
	get_tree().change_scene_to_file(GLOBAL.PANTALLAS["MENU_PRINCIPAL"])
