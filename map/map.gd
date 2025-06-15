extends StaticBody3D

@onready var province_color_to_lookup : Dictionary

func _ready() -> void:
	create_lookup_texture()


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
	lookup_image.save_png("res://lut.png")
