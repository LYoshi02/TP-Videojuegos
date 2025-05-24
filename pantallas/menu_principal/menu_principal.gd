extends Control

@onready var niveles_boton: Button = $ContenedorBotones/NivelesBoton
@onready var tienda_boton: Button = $ContenedorBotones/TiendaBoton
@onready var configuracion_boton: Button = $ContenedorBotones/ConfiguracionBoton
@onready var salir_boton: Button = $ContenedorBotones/SalirBoton


func _ready() -> void:
	GLOBAL.cargar_progreso()
	ReproductorMusica.reproducir_musica(GLOBAL.MUSICAS["MENU_PRINCIPAL"])

func _on_niveles_boton_pressed() -> void:
	get_tree().change_scene_to_file(GLOBAL.PANTALLAS["MENU_NIVELES"])

func _on_configuracion_boton_pressed() -> void:
	get_tree().change_scene_to_file(GLOBAL.PANTALLAS["MENU_CONFIGURACION"])

func _on_salir_boton_pressed() -> void:
	get_tree().quit()
