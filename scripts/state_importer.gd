extends Node

func _ready() -> void:
	generate_states()

func generate_states() -> void:
	print("STARTING TO GENERATE STATES")

	var state_folder := DirAccess.open("res://Global-Command-2.0/map/map_data/states/")
	state_folder.list_dir_begin()
	var file_name = state_folder.get_next()

	while file_name != "":
		if file_name.ends_with(".txt"):
			var state_file := FileAccess.open("res://Global-Command-2.0/map/map_data/states/" + file_name, FileAccess.READ)
			var file_content := state_file.get_as_text().strip_edges()
			state_file.close()

			# Extract state ID
			var from = file_content.find("id=") + "id=".length()
			var to = file_content.find("\n", from)
			var state_id = int(file_content.substr(from, to - from).strip_edges())

			# Extract state name
			from = file_content.find("name=") + "name=".length()
			to = file_content.find("\n", from)
			var state_name = str(file_content.substr(from, to - from).replace("\"", "").strip_edges())

			# Extract provinces
			from = file_content.find("provinces=") + "provinces=".length()
			to = file_content.find("}", from)
			var provinces_raw = file_content.substr(from, to - from).strip_edges()
			var provinces = provinces_raw.split(" ")

			print("STATE_%d" % state_id)
			print(state_name)
			print(provinces)

		file_name = state_folder.get_next()
