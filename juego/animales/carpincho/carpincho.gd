extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_activacion: RayCast2D = $RayCastActivacion
@onready var ray_cast_derecha: RayCast2D = $RayCastDerecha
@onready var ray_cast_izquierda: RayCast2D = $RayCastIzquierda

var velocidad: int = 40
var direccion: int = 1
var activo: bool = false
var caminando: bool = false

func _process(delta: float) -> void:
	if not activo:
		if not ray_cast_activacion.is_colliding():
			activo = true
			activar_parado()
	elif caminando:
		if ray_cast_derecha.is_colliding():
			direccion = -1
			animated_sprite_2d.flip_h = true
		if ray_cast_izquierda.is_colliding():
			direccion = 1
			animated_sprite_2d.flip_h = false
		
		position.x += direccion * velocidad * delta

func activar_parado() -> void:
	animated_sprite_2d.play("parado")
	
func activar_caminar() -> void:
	animated_sprite_2d.play("caminando")

func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == "parado":
		activar_caminar()
		caminando = true
