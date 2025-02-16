extends ScrollContainer

@export_category("Chamar scene")
@export var variacoesScene: PackedScene #Chama a tela variacoes

#Area de toque para rolar na horizontal
@onready var touch_scroll_fun: TouchScreenButton = $"../TouchScrollFun"

#Limites do scroll na horizontal
const LIMITMAXSCROLL:int = 1148
const LIMITMINSCROLL:int = 0

var validacaoToque:bool = false
var relative:int = 0

func _process(_delta) -> void:
	if touch_scroll_fun.is_pressed() and validacaoToque == false:
		set_h_scroll(relative)  
		if relative >= LIMITMAXSCROLL:
			validacaoToque = false
			relative = LIMITMAXSCROLL
		if relative <= LIMITMINSCROLL:
			validacaoToque = false
			relative = LIMITMINSCROLL

func _input(event):
	if event is InputEventScreenDrag:
		relative -= event.relative.x 

func _on_touch_area_released() -> void:
	validacaoToque = false

func _on_item_list_item_activated(index: int) -> void:
	Global.contCaixa = str(index)
	get_tree().change_scene_to_packed(variacoesScene)
