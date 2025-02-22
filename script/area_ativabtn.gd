extends Node3D

#Butão do Control, onde fica o joystick, ligado na main
@onready var drop_caixas: TouchScreenButton = $"../Control/CanvasLayer/Botoes/dropCaixas"


func _on_area_excluir_body_entered(_body: Node3D) -> void:
	drop_caixas.visible = true
	Global.excluirCaixa = true

func _on_area_excluir_body_exited(_body: Node3D) -> void:
	drop_caixas.visible = false
	Global.excluirCaixa = false

func _on_area_drop_body_entered(_body: Node3D) -> void:
	drop_caixas.visible = true
	Global.dropCaixa = true

func _on_area_drop_body_exited(_body: Node3D) -> void:
	drop_caixas.visible = false
	Global.dropCaixa = false
