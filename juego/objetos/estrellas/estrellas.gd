extends HBoxContainer

@onready var estrella_1: TextureRect = $MarginContainer/Estrella1
@onready var estrella_2: TextureRect = $MarginContainer2/Estrella2
@onready var estrella_3: TextureRect = $MarginContainer3/Estrella3

var shader_blanco_code := """
	shader_type canvas_item;

	void fragment() {
		vec4 tex_color = texture(TEXTURE, UV);
		COLOR = vec4(1.0, 1.0, 1.0, tex_color.a);
	}
"""

func pintar_estrellas(estrellas_conseguidas: int):
	var shader_blanco := Shader.new()
	shader_blanco.code = shader_blanco_code
	var shader_material := ShaderMaterial.new()
	shader_material.shader = shader_blanco
	
	if estrellas_conseguidas == 0:
		estrella_1.material = shader_material
		estrella_2.material = shader_material
		estrella_3.material = shader_material
	if estrellas_conseguidas == 1:
		estrella_2.material = shader_material
		estrella_3.material = shader_material
	if estrellas_conseguidas == 2:
		estrella_3.material = shader_material
