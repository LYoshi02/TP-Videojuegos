extends CanvasLayer

@export var corazones: Array[Node]

@onready var moneda_label: Label = $MonedasPanel/HBoxContainer/MonedaLabel
@onready var pausa_panel: Panel = $PausaPanel

func actualizar_label_monedas(monedas_recolectadas: int, _monedas_totales: int) -> void:
	moneda_label.text = str(monedas_recolectadas).pad_zeros(2)

func actualizar_vidas(vidas_restantes: int) -> void:
	for nro_corazon in corazones.size():
		if nro_corazon < vidas_restantes:
			#corazones[nro_corazon].show()
			corazones[nro_corazon].modulate = Color(1, 1, 1, 1)
		else:
			#corazones[nro_corazon].hide()
			corazones[nro_corazon].modulate = Color(1, 1, 1, 0)

func _on_boton_pausa_pressed() -> void:
	pausa_panel.pausar_juego()
