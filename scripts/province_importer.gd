extends Node

# Dictionary mapping province colors to Province objects
@onready var color_to_province: Dictionary = {}

func _ready() -> void:
	generate_provinces()

func generate_provinces() -> void:
	print("STARTING TO GENERATE PROVINCES")

	# Load the entire file as text
	var province_file: String = FileAccess.open("res://Global-Command-2.0/map/map_data/provinces.txt", FileAccess.READ).get_as_text()
	var rows: Array = province_file.split("\n")

	# Loop through each line in the file
	for row in rows:
		if row.strip_edges() != "":
			# Split line into columns (ID;R;G;B;Type)
			var columns: Array = row.split(";")

			# Extract values from columns
			var province_id: int = int(columns[0])
			var province_color: Color = Color(
				float(columns[1]) / 255.0,
				float(columns[2]) / 255.0,
				float(columns[3]) / 255.0
			)
			var province_type: String = columns[4]

			# Create new Province instance
			var province: Province = Province.new()
			province.name = str(province_id)
			province.id = province_id
			province.color = province_color
			province.type = province_type
			if province_type == "land":
				province.set_province_owner("NNN")
				province.set_province_controller("NNN")

			# Optional: add to scene tree for debugging or visibility
			add_child(province)

			# Store in lookup dictionary
			color_to_province[province_color] = province
