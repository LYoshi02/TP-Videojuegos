extends Node

# Estructura diccionario:
# { "niveles": { "1": {"completado": true, "monedas": 25, "estrellas": 3, "tiempo": 10.50} } }
var progreso = obtener_estado_inicial_progreso()
var ruta_guardado = "user://progreso_jugador.save"

func obtener_estado_inicial_progreso() -> Dictionary:
	return {
		"niveles": {}
	}

func guardar_progreso():
	var archivo = FileAccess.open(ruta_guardado, FileAccess.WRITE)
	print("archivo guardar: " + str(archivo))
	if archivo:
		var json_string = JSON.stringify(progreso)
		archivo.store_string(json_string)
		archivo.close()

func cargar_progreso():
	if not FileAccess.file_exists(ruta_guardado):
		return  # Si no hay archivo, se deja el progreso inicial vacío

	var archivo = FileAccess.open(ruta_guardado, FileAccess.READ)
	if archivo:
		var json_string = archivo.get_as_text()
		var result = JSON.parse_string(json_string)
		if result is Dictionary:
			progreso = result
		archivo.close()

func actualizar_nivel(nivel_id: int, monedas_recolectadas: int, estrellas: int, tiempo_total: float):
	if not progreso["niveles"].has(str(nivel_id)):
		progreso["niveles"][str(nivel_id)] = {}
	
	progreso["niveles"][str(nivel_id)]["completado"] = true
	if progreso["niveles"][str(nivel_id)].has("monedas"):
		if monedas_recolectadas > progreso["niveles"][str(nivel_id)]["monedas"]:
			progreso["niveles"][str(nivel_id)]["monedas"] = monedas_recolectadas
	else:
		progreso["niveles"][str(nivel_id)]["monedas"] = monedas_recolectadas
		
	if progreso["niveles"][str(nivel_id)].has("estrellas"):
		if estrellas > progreso["niveles"][str(nivel_id)]["estrellas"]:
			progreso["niveles"][str(nivel_id)]["estrellas"] = estrellas
	else:
		progreso["niveles"][str(nivel_id)]["estrellas"] = estrellas
	
	if progreso["niveles"][str(nivel_id)].has("tiempo"):
		if tiempo_total < progreso["niveles"][str(nivel_id)]["tiempo"]:
			progreso["niveles"][str(nivel_id)]["tiempo"] = tiempo_total
	else:
		progreso["niveles"][str(nivel_id)]["tiempo"] = tiempo_total
	
	guardar_progreso()

func obtener_progreso_nivel(nivel_id: int):
	if progreso["niveles"].has(str(nivel_id)):
		return progreso["niveles"][str(nivel_id)]
	else:
		return { "completado": false, "monedas": 0, "estrellas": 0, "tiempo": 0.0 }

func borrar_progreso():
	if FileAccess.file_exists(ruta_guardado):
		DirAccess.remove_absolute(ruta_guardado)
		print("Progreso borrado.")
	else:
		print("No había progreso guardado.")

	progreso.clear()
	progreso = obtener_estado_inicial_progreso()
