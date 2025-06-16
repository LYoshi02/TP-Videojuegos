extends Node2D

@onready var personaje: CharacterBody2D = %Personaje
@onready var camera_2d: Camera2D = $NodosEscena/Personaje/Camera2D

func _ready() -> void:
	ReproductorMusica.reproducir_musica(GLOBAL.MUSICAS["NIVEL_1"])
	
	# Ajustar Camera2D
	camera_2d.position_smoothing_enabled = false
	camera_2d.global_position = personaje.global_position
	await get_tree().create_timer(0.2).timeout
	camera_2d.position_smoothing_enabled = true
