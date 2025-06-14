extends Node3D

@export var province_map: Texture2D

func _on_player_province_selected(coordinates: Vector2) -> void:
	var image: Image = province_map.get_image()
	var map_width: int = image.get_width()
	var map_height: int = image.get_height()

	var world_width: float = 563.2
	var world_height: float = 211.2

	var px: int = clamp(int(coordinates.x / world_width * map_width), 0, map_width - 1)
	var py: int = clamp(int(coordinates.y / world_height * map_height), 0, map_height - 1)

	var province_color: Color = image.get_pixel(px, py)
	var selected_province: Province = $Provinces.color_to_province.get(province_color, null)

	print("Selected province:", selected_province)
	$ProvinceSelected.update_label(selected_province)


func _on_state_importer_reparent_provinces(state) -> void:
	for province in state.provinces:
		var node_to_move = $Provinces.get_node(province)
		node_to_move.reparent(state)
