extends StaticBody2D

@onready var game_manager: Node = %GameManager

func daniar_personaje(body: Node2D, direccion_salto: int):
	if body.name == GLOBAL.PERSONAJE["NOMBRE_ELEMENTO"]:
		if not game_manager.es_ultima_vida():
			body.saltar_al_costado(direccion_salto)
		game_manager.reducir_vida()

func _on_area_superior_body_entered(body: Node2D) -> void:
	daniar_personaje(body, 0)

func _on_area_lateral_izquierda_body_entered(body: Node2D) -> void:
	daniar_personaje(body, -500)

func _on_area_lateral_derecha_body_entered(body: Node2D) -> void:
	daniar_personaje(body, 500)
