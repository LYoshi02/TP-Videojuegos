extends Node

@onready var pausa_panel: Panel = %PausaPanel

func _process(_delta):
	var esc_pressed = Input.is_action_just_pressed("pausa")
	if esc_pressed == true:
		if get_tree().paused:
			get_tree().paused = false;
			pausa_panel.hide()
		else:
			get_tree().paused = true;
			pausa_panel.show()

func _on_continuar_boton_pressed() -> void:
	get_tree().paused = false;
	pausa_panel.hide()

func _on_niveles_boton_pressed() -> void:
	get_tree().paused = false;
	get_tree().change_scene_to_file(GLOBAL.PANTALLAS["MENU_NIVELES"])

func _on_menu_principal_boton_pressed() -> void:
	get_tree().paused = false;
	get_tree().change_scene_to_file(GLOBAL.PANTALLAS["MENU_PRINCIPAL"])

func _on_salir_boton_pressed() -> void:
	get_tree().paused = false;
	get_tree().quit()
