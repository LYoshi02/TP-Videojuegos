extends Node2D

func _ready() -> void:
	add_to_group(GLOBAL.GRUPOS["ROMPIBLE"])

func romper() -> void:
	await get_tree().create_timer(0.25).timeout
	queue_free()
