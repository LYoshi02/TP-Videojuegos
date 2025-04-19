extends Control

func _on_borrar_datos_boton_pressed() -> void:
	GLOBAL.borrar_progreso()

func _on_volver_boton_pressed() -> void:
	get_tree().change_scene_to_file(GLOBAL.PANTALLAS["MENU_PRINCIPAL"])
