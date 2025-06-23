extends Node

const PANTALLAS = {
	"MENU_PRINCIPAL": "res://pantallas/menu_principal/menu_principal.tscn",
	"MENU_CONFIGURACION": "res://pantallas/menu_configuracion/menu_configuracion.tscn",
	"MENU_NIVELES": "res://pantallas/menu_niveles/menu_niveles.tscn",
	"NIVEL_1": "res://pantallas/niveles/nivel_selva/nivel_selva.tscn",
	"NIVEL_2": "res://pantallas/niveles/nivel_2/nivel_2.tscn"
}

const PERSONAJE = {
	"NOMBRE_ELEMENTO": "Personaje"
}

const GRUPOS = {
	"ROMPIBLE": "rompible"
}

const MUSICAS = {
	"MENU_PRINCIPAL": preload("res://assets/audio/musica/menu_principal.mp3"),
	"NIVEL_1": preload("res://assets/audio/musica/nivel_1.mp3")
}

const EFECTOS_SONIDO = {
	"ATAQUE_MACHETE_1": preload("res://assets/audio/sfx/ataque_machete_1.wav"),
	"ATAQUE_MACHETE_2": preload("res://assets/audio/sfx/ataque_machete_2.wav"),
	"ATAQUE_MACHETE_3": preload("res://assets/audio/sfx/ataque_machete_3.wav"),
	"ATAQUE_TERO": preload("res://assets/audio/sfx/ataque_tero.wav"),
	"CAIDA": preload("res://assets/audio/sfx/caida_sapucai.wav"),
	"CORTE_ENREDADERA": preload("res://assets/audio/sfx/corte_enredadera.wav"),
	"MONEDA": preload("res://assets/audio/sfx/moneda.wav"),
	"SALTO": preload("res://assets/audio/sfx/salto.wav")
}

# Lógica de Guardado
var SaveManager = preload("res://scripts/save_manager.gd").new()

func guardar_progreso():
	SaveManager.guardar_progreso()

func cargar_progreso():
	SaveManager.cargar_progreso()

func actualizar_nivel(nivel_id: int, monedas: int, estrellas: int, tiempo_total: float):
	SaveManager.actualizar_nivel(nivel_id, monedas, estrellas, tiempo_total)

func obtener_progreso_nivel(nivel_id: int) -> Dictionary:
	return SaveManager.obtener_progreso_nivel(nivel_id)

func borrar_progreso():
	SaveManager.borrar_progreso()
