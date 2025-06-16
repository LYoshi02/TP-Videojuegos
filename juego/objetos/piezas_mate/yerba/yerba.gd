extends Area2D

@onready var game_manager: Node = %GameManager
@onready var sprite_mate: Sprite2D = $Sprite2D
@onready var sprite_rayos_luz: Sprite2D = $SpriteRayosLuz

var t = 0.0

func pulsar(sprite: Sprite2D, delta: float, velocidad: float, rango_scale: float):
	t += delta * velocidad
	var factor_scale = 0.5 + sin(t) * rango_scale
	sprite.scale = Vector2(factor_scale, factor_scale)

func rotar(sprite: Sprite2D, delta: float, velocidad: float):
	sprite.rotation += velocidad * delta

func _process(delta):
	rotar(sprite_rayos_luz, delta, 0.50)
	pulsar(sprite_mate, delta, 3, 0.04)

func _on_body_entered(body: Node2D) -> void:
	if body.name == GLOBAL.PERSONAJE["NOMBRE_ELEMENTO"]:
		game_manager.finalizar_nivel()
