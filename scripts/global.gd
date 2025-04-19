extends Node

const PANTALLAS = {
	"MENU_PRINCIPAL": "res://pantallas/menu_principal/menu_principal.tscn",
	"MENU_CONFIGURACION": "res://pantallas/menu_configuracion/menu_configuracion.tscn",
	"MENU_NIVELES": "res://pantallas/menu_niveles/menu_niveles.tscn",
	"NIVEL_1": "res://pantallas/niveles/nivel_1/nivel_1.tscn",
	"NIVEL_2": "res://pantallas/niveles/nivel_2/nivel_2.tscn"
}

const PERSONAJE = {
	"NOMBRE_ELEMENTO": "Personaje"
}

# Lógica de Guardado
var SaveManager = preload("res://scripts/save_manager.gd").new()

func guardar_progreso():
	SaveManager.guardar_progreso()

func cargar_progreso():
	SaveManager.cargar_progreso()

func actualizar_nivel(nivel_id: int, monedas: int):
	SaveManager.actualizar_nivel(nivel_id, monedas)

func obtener_progreso_nivel(nivel_id: int) -> Dictionary:
	return SaveManager.obtener_progreso_nivel(nivel_id)

func borrar_progreso():
	SaveManager.borrar_progreso()
