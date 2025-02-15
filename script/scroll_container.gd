extends ScrollContainer

@onready var touch_area: TouchScreenButton = $"../touchArea"
var area:bool = false
var relative:int = 0
@export var limitMaxScroll:int = 1148
@export var limitMinScroll:int = 0
@onready var item_list: ItemList = $ItemList


func _process(_delta) -> void:
	if touch_area.is_pressed() and area == false:
		set_h_scroll(relative)  # Alterado para rolar horizontalmente
		print(get_h_scroll())
		
		if relative >= limitMaxScroll:
			area = false
			relative = limitMaxScroll
		if relative <= limitMinScroll:
			area = false
			relative = limitMinScroll

func _input(event):
	if event is InputEventScreenDrag:
		relative -= event.relative.x 

func _on_touch_area_released() -> void:
	area = false
