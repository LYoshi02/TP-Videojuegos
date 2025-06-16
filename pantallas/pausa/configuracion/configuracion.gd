extends Panel

@onready var check_box_full_screen: CheckBox = $Panel/ContenedorBotones/VBoxContainer/HBoxContainer/CheckBoxFullScreen

func _ready() -> void:
	var current_window_mode = DisplayServer.window_get_mode()
	if current_window_mode == DisplayServer.WINDOW_MODE_FULLSCREEN:
		check_box_full_screen.button_pressed = true

func _on_volver_boton_pressed() -> void:
	hide()

func _on_check_box_full_screen_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
