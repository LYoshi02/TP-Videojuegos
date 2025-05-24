extends Area2D

@onready var game_manager: Node = %GameManager

func _on_body_entered(body: Node2D) -> void:
	if body.name == GLOBAL.PERSONAJE["NOMBRE_ELEMENTO"]:
		game_manager.recolectar_moneda()
		ReproductorMusica.reproducir_efecto_de_sonido(GLOBAL.EFECTOS_SONIDO["MONEDA"], 20)
		queue_free()
