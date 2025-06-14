extends Node

func _ready() -> void:
	create_countries("NNN", "No name", Color(0.5, 0.5, 0.5), "Democratic")         # Blue
	create_countries("USA", "United States", Color(0.0, 0.0, 1.0), "Democratic")         # Blue
	create_countries("FRA", "France", Color(0.0, 0.4, 1.0), "Democratic")                # Sky Blue
	create_countries("DEU", "Germany", Color(0.1, 0.1, 0.1), "Democratic")              # Dark Gray
	create_countries("ITA", "Italy", Color(0.0, 0.6, 0.0), "Democratic")                # Green
	create_countries("ESP", "Spain", Color(0.8, 0.0, 0.0), "Democratic")                # Red
	create_countries("GBR", "United Kingdom", Color(0.5, 0.0, 0.5), "Democratic")       # Purple
	create_countries("NLD", "Netherlands", Color(1.0, 0.5, 0.0), "Democratic")          # Orange
	create_countries("SWE", "Sweden", Color(1.0, 1.0, 0.0), "Democratic")               # Yellow
	create_countries("NOR", "Norway", Color(1.0, 1.0, 1.0), "Democratic")               # White
	create_countries("POL", "Poland", Color(1.0, 0.0, 0.5), "Democratic")               # Pink
	create_countries("ROU", "Romania", Color(0.4, 0.2, 0.0), "Democratic")              # Brown
	create_countries("BGR", "Bulgaria", Color(0.0, 0.5, 0.5), "Democratic")             # Teal
	create_countries("GRC", "Greece", Color(0.0, 1.0, 1.0), "Democratic")               # Cyan
	create_countries("AUT", "Austria", Color(1.0, 0.0, 1.0), "Democratic")              # Magenta
	create_countries("CZE", "Czech Republic", Color(0.6, 0.6, 0.6), "Democratic")       # Light Gray
	create_countries("HUN", "Hungary", Color(0.5, 0.0, 0.0), "Democratic")              # Maroon
	create_countries("IRL", "Ireland", Color(0.0, 0.8, 0.3), "Democratic")              # Emerald Green
	create_countries("FIN", "Finland", Color(0.6, 0.8, 1.0), "Democratic")              # Light Blue
	create_countries("PRT", "Portugal", Color(1.0, 0.7, 0.0), "Democratic")             # Golden Orange
	create_countries("CHE", "Switzerland", Color(0.8, 0.0, 0.2), "Democratic")          # Crimson Red

func create_countries(tag, country_name, color, ideology):
	var country: Country = Country.new()
	country.name = tag
	country.tag = tag
	country.country_name = country_name
	country.color = color
	country.ideology = ideology
	add_child(country)
	Globals.tag_to_country[tag] = country
