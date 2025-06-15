extends StaticBody3D

@onready var province_color_to_lookup : Dictionary
@onready var map_material_2d = load("res://Global-Command-2.0/map/shaders/map2D.tres")
@onready var color_map_political:Image = Image.create(256,256,false,Image.FORMAT_RGB8)
var current_map_mode:Image


func _ready() -> void:
	create_lookup_texture()
	create_color_map()


func create_lookup_texture() -> void:
	var province_image : Image = get_parent().province_map.get_image()
	var lookup_image: Image = province_image.duplicate()
	var color_map_r : int = 0
	var color_map_g : int = 0

	for x in range(lookup_image.get_width()):
		for y in range(lookup_image.get_height()):
			var province_color: Color = province_image.get_pixel(x, y)
			
			if not province_color_to_lookup.has(province_color):
				province_color_to_lookup[province_color] = Color(color_map_r / 255.0, color_map_g / 255.0, 0.0)
				color_map_r += 1
				if color_map_r >= 255:
					color_map_r = 0
					color_map_g += 1
			
			lookup_image.set_pixel(x, y, province_color_to_lookup[province_color])
	var lookup_texture = ImageTexture.create_from_image(lookup_image)
	map_material_2d.set_shader_parameter("lookup_image", lookup_texture)

func create_color_map() -> void:
	for province_color :Color in province_color_to_lookup:
		var lookup = province_color_to_lookup[province_color]
		var x = lookup.r * 255
		var y = lookup.g * 255
		var province:Province = get_parent().get_node("Provinces").color_to_province.get(province_color)
		if province.type == "land":
			var owner_color :Color = province.province_owner.color
			var controller_color :Color = province.province_controller.color
			color_map_political.set_pixel(x, y, owner_color)
			color_map_political.set_pixel(x, y + 100, controller_color)

	var color_map_texture = ImageTexture.create_from_image(color_map_political)
	map_material_2d.set_shader_parameter("color_map_image", color_map_texture)
	current_map_mode = color_map_political
	current_map_mode.save_png("res://map_mode.png")
