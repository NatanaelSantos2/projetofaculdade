extends ScrollContainer

@export_category("Chamar Scene")
@export var mainScene: String = "res://main.tscn"

#Area de toque para rolar na vertical
@onready var touch_scroll_var: TouchScreenButton = $"../TouchScrollVar"

#Limites do scroll na vertical
const LIMITMAXSCROLL:int = 1148
const LIMITMINSCROLL:int = 0

var validacaoToque:bool = false
var relative:int = 0
	
func _process(_delta) -> void:
	if touch_scroll_var.is_pressed() and validacaoToque == false:
		set_v_scroll(relative)
		if relative >= LIMITMAXSCROLL:
			validacaoToque = false
			relative = LIMITMAXSCROLL
		if relative <= LIMITMINSCROLL:
			validacaoToque = false
			relative = LIMITMINSCROLL

func _input(event):
	if event is InputEventScreenDrag:
		relative -= event.relative.y 

func _on_touch_scroll_var_released() -> void:
	validacaoToque = false

func _on_list_var_item_activated(index: int) -> void:
	Global.variacoes = index
	print("Variacoes ",index)
	get_tree().change_scene_to_file(mainScene)
