extends Node3D

@export var parent_node: Node3D

#func has_child() -> bool:
	#return parent_node.get_child_count() > 0

#func _process(_delta: float) -> void:
	#if has_child() != true:
		#print(has_child())

	
func _ready() -> void:
	print(Global.contCaixa)
