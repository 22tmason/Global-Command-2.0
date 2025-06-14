extends Node
class_name Province

var id:int
var color:Color
var type:String

var province_owner:Country  # country tag or a reference to the country node
var province_controller:Country  # optional logic/controller reference
