extends Area2D

@onready var game_manager: Node = %GameManager

func _on_body_entered(body: Node2D) -> void:
	if body.name == GLOBAL.PERSONAJE["NOMBRE_ELEMENTO"]:
		game_manager.finalizar_nivel()
