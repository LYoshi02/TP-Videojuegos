extends RigidBody2D

@onready var game_manager: Node = %GameManager


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == GLOBAL.PERSONAJE["NOMBRE_ELEMENTO"]:
		var y_delta = position.y - body.position.y
		if y_delta > 30:
			print("Kill enemy")
			queue_free()
			body.saltar()
		else:
			var x_delta = body.position.x - position.x
			if not game_manager.es_ultima_vida():
				if x_delta > 0:
					body.saltar_al_costado(500)
				else:
					body.saltar_al_costado(-500)
			print("Decrease health")		
			game_manager.reducir_vida()
