extends TouchScreenButton

#A tela principal tambem faz uso desse codigo para voltar para fundamentos

@export_category("CaminhoScene")
@export var fundamentosFile:String = "res://scenes/UI/fundamentos.tscn"

func _process(_delta: float) -> void:
	if Input.is_action_pressed("voltarVar"):
		get_tree().change_scene_to_file(fundamentosFile)
