extends CanvasLayer

@export var corazones: Array[Node]

@onready var moneda_label: Label = $MonedasPanel/HBoxContainer/MonedaLabel

func actualizar_label_monedas(monedas_recolectadas: int, _monedas_totales: int):
	moneda_label.text = str(monedas_recolectadas).pad_zeros(2)

func actualizar_vidas(vidas_restantes: int):
	for nro_corazon in corazones.size():
		if nro_corazon < vidas_restantes:
			#corazones[nro_corazon].show()
			corazones[nro_corazon].modulate = Color(1, 1, 1, 1)
		else:
			#corazones[nro_corazon].hide()
			corazones[nro_corazon].modulate = Color(1, 1, 1, 0)
