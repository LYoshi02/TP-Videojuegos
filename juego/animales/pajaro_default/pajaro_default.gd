extends Node2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == GLOBAL.PERSONAJE["NOMBRE_ELEMENTO"]:
		body.daniar_con_impulso(Vector2(position.x, position.y))
