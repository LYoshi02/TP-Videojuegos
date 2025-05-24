extends Node2D

func _ready() -> void:
	ReproductorMusica.reproducir_musica(GLOBAL.MUSICAS["NIVEL_1"])
