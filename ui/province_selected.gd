extends CanvasLayer

@onready var province_id = $PanelContainer/GridContainer/LabelProvinceID
@onready var province_color = $PanelContainer/GridContainer/ColorPickerProvinceColor
@onready var province_type = $PanelContainer/GridContainer/LabelProvinceType
@onready var province_owner = $PanelContainer/GridContainer/LabelOwner
@onready var province_controller = $PanelContainer/GridContainer/LabelController


func update_labels(province: Province):
	province_id.text = str(province.id)
	province_color.color = province.color
	province_type.text = province.type

	if province.type != "land":
		province_owner.text = ""
		province_controller.text = ""
	else:
		province_owner.text = province.province_owner.country_name
		province_controller.text = province.province_controller.country_name
