extends Node

@onready var volver_boton: Button = $VolverBoton
@onready var nivel_1_boton: Button = $Nivel1Boton


func _on_volver_boton_pressed() -> void:
	get_tree().change_scene_to_file(GLOBAL.PANTALLAS["MENU_PRINCIPAL"])

func _on_nivel_1_boton_pressed() -> void:
	get_tree().change_scene_to_file(GLOBAL.PANTALLAS["NIVEL_1"])
