extends MeshInstance3D

@export_category("SlotPlayer")
#SlotPlayer serve para armazenar a caixa e tambem para verificar se tem um nó filho
@export var SlotPlayer: Node3D #So define na main

@export_category("Butões")
@export var drop_caixas: Button #So define na main

#o proprio nó
@onready var caixa_4: MeshInstance3D = $"."

func _process(_delta: float) -> void:
	if drop_caixas.button_pressed:
		drop_object()

func _transfer_object(): #transfere o proprio objeto caixas_1 para a mão do player
	caixa_4.reparent(SlotPlayer)
	caixa_4.position = Vector3.ZERO
	caixa_4.rotation = Vector3.ZERO

func drop_object():
	var caixa = SlotPlayer.get_child(0) if SlotPlayer.get_child_count() > 0 else null
	if caixa:
		caixa.queue_free()

func has_child() -> bool: #Verifica se tem nó filho
	return SlotPlayer.get_child_count() > 0

func _on_area_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D: #Verifica se foi player que entrou na area para se auto transferir
		if has_child():
			print("O nó já tem pelo menos um filho.")
		else:
			call_deferred("_transfer_object")
