extends Area2D

@export var id_progreso: int

@onready var game_manager: Node = %GameManager
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	animated_sprite_2d.modulate = Color(0.5, 0.5, 0.5)

func _on_body_entered(body: Node2D) -> void:
	if body.name == GLOBAL.PERSONAJE["NOMBRE_ELEMENTO"]:
		game_manager.actualizar_checkpoint(self, id_progreso)
		animated_sprite_2d.modulate = Color(1, 1, 1)
		animated_sprite_2d.play("bandera_flameando")
