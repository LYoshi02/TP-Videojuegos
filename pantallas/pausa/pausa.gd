extends Panel

@onready var panel_configuracion: Panel = $PanelConfiguracion

func _process(_delta: float) -> void:
	var esc_pressed: bool = Input.is_action_just_pressed("pausa")
	if esc_pressed == true:
		if get_tree().paused:
			get_tree().paused = false;
			hide()
			panel_configuracion.hide()
		else:
			pausar_juego()

func _on_continuar_boton_pressed() -> void:
	get_tree().paused = false;
	hide()

func _on_niveles_boton_pressed() -> void:
	get_tree().paused = false;
	Engine.time_scale = 1
	get_tree().change_scene_to_file(GLOBAL.PANTALLAS["MENU_NIVELES"])

func _on_configuracion_boton_pressed() -> void:
	panel_configuracion.show()

func _on_salir_boton_pressed() -> void:
	get_tree().paused = false;
	Engine.time_scale = 1
	get_tree().change_scene_to_file(GLOBAL.PANTALLAS["MENU_PRINCIPAL"])

func pausar_juego() -> void:
	get_tree().paused = true;
	show()
