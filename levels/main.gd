extends Node3D

@export var province_map: Texture2D

func _on_player_province_selected(coordinates: Vector2) -> void:
	# Get the pixel color at the clicked coordinates (scaled to match map resolution)
	var province_color = province_map.get_image().get_pixel(coordinates.x * 10, coordinates.y * 10)

	# Look up the matching Province object using the color
	var selected_province = $Provinces.color_to_province.get(province_color)

	# Output the province info (make sure Province has a .name or .id etc.)
	print("Selected province:", selected_province)
