extends Node

signal reparent_provinces

func _ready() -> void:
	generate_states()
	assign_owners()

func generate_states() -> void:
	print("STARTING TO GENERATE STATES")

	var state_folder = DirAccess.open("res://Global-Command-2.0/map/map_data/states/")
	state_folder.list_dir_begin()
	var file_name = state_folder.get_next()

	while file_name != "":
		var state_file = FileAccess.open("res://Global-Command-2.0/map/map_data/states/" + file_name, FileAccess.READ)
		var file_content = state_file.get_as_text().strip_edges()
		state_file.close()

		# ID
		var from = file_content.find("id=") + 3
		var to = file_content.find("name=") - from
		var id = int(file_content.substr(from, to))

		# Name
		from = file_content.find("name=") + 5
		to = file_content.find("provinces=") - from
		var state_name = str(file_content.substr(from, to)).replace("\"", "")

		# Provinces
		from = file_content.find("provinces={") + 11
		to = file_content.find("}") - from
		var provinces = file_content.substr(from, to).strip_edges().split(" ")

		# Create and assign new State instance
		var state: State = State.new()
		state.name = str(id)
		state.id = id
		state.state_name = state_name
		state.provinces = provinces
		add_child(state)
		reparent_provinces.emit(state)

		file_name = state_folder.get_next()
	state_folder.list_dir_end()
	print("FINISHED GENERATING STATES")

func assign_owners() -> void:
	get_node("270").set_state_owner("FRA")
	get_node("270").set_state_controller("FRA")

	get_node("221").set_state_owner("DEU")
	get_node("221").set_state_controller("DEU")

	get_node("301").set_state_owner("ITA")
	get_node("301").set_state_controller("ITA")
	
	get_node("306").set_state_owner("ITA")
	get_node("306").set_state_controller("ITA")
	
	get_node("341").set_state_owner("ESP")
	get_node("341").set_state_controller("ESP")
	get_node("328").set_state_owner("ESP")
	get_node("328").set_state_controller("ESP")

	get_node("166").set_state_owner("GBR")
	get_node("166").set_state_controller("GBR")

	get_node("224").set_state_owner("POL")
	get_node("224").set_state_controller("POL")

	
