extends Node2D

@onready var fondo_verde: ParallaxLayer = $ParallaxBackground/FondoVerde
@onready var arboles_verde_claro: ParallaxLayer = $ParallaxBackground/ArbolesVerdeClaro
@onready var arboles_verde: ParallaxLayer = $ParallaxBackground/ArbolesVerde
@onready var arboles_verde_2: ParallaxLayer = $ParallaxBackground/ArbolesVerde2
@onready var arboles_verde_3: ParallaxLayer = $ParallaxBackground/ArbolesVerde3


func _ready():
	set_background_mirroring()

func _enter_tree():
	get_viewport().connect("size_changed", Callable(self, "_on_viewport_resized"))

func _on_viewport_resized():
	print("Viewport resized")
	set_background_mirroring()

func set_background_mirroring():
	var viewport_size = get_viewport().get_visible_rect().size
	print("Viewport size: " + str(viewport_size))
	fondo_verde.motion_mirroring.x = viewport_size.x
	arboles_verde_claro.motion_mirroring.x = viewport_size.x
	arboles_verde.motion_mirroring.x = viewport_size.x
	arboles_verde_2.motion_mirroring.x = viewport_size.x
	arboles_verde_3.motion_mirroring.x = viewport_size.x
