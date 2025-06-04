extends Area2D

@onready var jugador: CharacterBody2D = %Personaje

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	if body.name == GLOBAL.PERSONAJE["NOMBRE_ELEMENTO"]:
		Engine.time_scale = 0.5
		timer.start()

func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	jugador.reaparecer()
