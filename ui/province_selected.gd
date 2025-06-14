extends CanvasLayer

@onready var province_id = $PanelContainer/GridContainer/LabelProvinceID
@onready var province_color = $PanelContainer/GridContainer/ColorPickerProvinceColor
@onready var province_type = $PanelContainer/GridContainer/LabelProvinceType

func update_label(province: Province) -> void:
	province_id.text = str(province.id)
	province_color.color = province.color
	province_type.text = province.type
