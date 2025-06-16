extends Control

@onready var check_box_full_screen: CheckBox = $Panel/Panel/ContenedorBotones/HBoxContainer/CheckBoxFullScreen

func _ready() -> void:
	var current_window_mode = DisplayServer.window_get_mode()
	if current_window_mode == DisplayServer.WINDOW_MODE_FULLSCREEN:
		check_box_full_screen.button_pressed = true

func _on_borrar_datos_boton_pressed() -> void:
	GLOBAL.borrar_progreso()

func _on_volver_boton_pressed() -> void:
	get_tree().change_scene_to_file(GLOBAL.PANTALLAS["MENU_PRINCIPAL"])

func _on_check_box_full_screen_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
