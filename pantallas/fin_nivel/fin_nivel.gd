extends CanvasLayer

@onready var fin_nivel_panel: Panel = $FinNivelPanel
@onready var estrellas_contenedor: HBoxContainer = $FinNivelPanel/Panel/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/EstrellasContenedor
@onready var tiempo_label: Label = $FinNivelPanel/Panel/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer3/TiempoLabel
@onready var monedas_label: Label = $FinNivelPanel/Panel/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer3/MonedasLabel
@onready var muertes_label: Label = $FinNivelPanel/Panel/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer3/MuertesLabel
@onready var continuar_boton: Button = $FinNivelPanel/Panel/MarginContainer/VBoxContainer/HBoxContainer2/ContinuarBoton

var shader_blanco_code := """
	shader_type canvas_item;

	void fragment() {
		vec4 tex_color = texture(TEXTURE, UV);
		COLOR = vec4(1.0, 1.0, 1.0, tex_color.a);
	}
"""

func mostrar_pantalla_fin_nivel(monedas_recolectadas: int, monedas_totales: int, muertes: int, estrellas_conseguidas: int, tiempo_total: float):
	monedas_label.text = "MONEDAS: " + str(monedas_recolectadas).pad_zeros(2) + "/" + str(monedas_totales).pad_zeros(2)
	muertes_label.text = "MUERTES: " + str(muertes).pad_zeros(2)
	
	var minutos = int(tiempo_total) / 60
	var segundos = int(tiempo_total) % 60
	var milisegundos = int((tiempo_total - int(tiempo_total)) * 100)
	tiempo_label.text =  "TIEMPO: %02d:%02d.%02d" % [minutos, segundos, milisegundos]
	
	estrellas_contenedor.pintar_estrellas(estrellas_conseguidas)
	get_tree().paused = true;
	fin_nivel_panel.show()

func _on_continuar_boton_pressed() -> void:
	get_tree().paused = false;
	get_tree().change_scene_to_file(GLOBAL.PANTALLAS["MENU_NIVELES"])
