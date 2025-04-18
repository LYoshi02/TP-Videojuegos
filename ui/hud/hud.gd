extends CanvasLayer

@export var corazones: Array[Node]

@onready var moneda_label: Label = $MonedasPanel/HBoxContainer/MonedaLabel

func actualizar_label_monedas(monedas_recolectadas: int, monedas_totales: int):
	moneda_label.text = str(monedas_recolectadas).pad_zeros(2) + "/" + str(monedas_totales).pad_zeros(2)

func actualizar_vidas(vidas_restantes: int):
	for nro_corazon in corazones.size():
		if nro_corazon < vidas_restantes:
			corazones[nro_corazon].show()
		else:
			corazones[nro_corazon].hide()
