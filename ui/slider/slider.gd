extends HSlider

@export var nombre_bus: String

var indice_bus: int

func _ready() -> void:
	indice_bus = AudioServer.get_bus_index(nombre_bus)
	value_changed.connect(_on_value_changed)
	
	value = db_to_linear(AudioServer.get_bus_volume_db(indice_bus))

func _on_value_changed(valor: float):
	AudioServer.set_bus_volume_db(indice_bus, linear_to_db(valor))
