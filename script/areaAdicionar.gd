extends Area3D

#Butão do Control, onde fica o joystick, ligado na main
@onready var drop_caixas: Button = $"../Control/CanvasLayer/Botoes/dropCaixas"

func _on_area_entered(_area: Area3D) -> void:
	drop_caixas.disabled = false

func _on_area_exited(_area: Area3D) -> void:
	drop_caixas.disabled = true
