extends MeshInstance3D

#SlotPlayer serve para armazenar a caixa e tambem para verificar se tem um nó filho
@onready var SlotPlayer: Node3D = $"../../../player/CollisionPlayer/SlotPlayer"
@onready var panelInfo: Panel = $"../../../Control/CanvasLayer/Painel/Panel" #Definido na main Control
@onready var descText: Label = $"../../../Control/CanvasLayer/Painel/Panel/TextDescricao" #Definido na main Control
@onready var nodecaixa_1: Node3D = $"../../../areaCaixas/Nodecaixa1" #Definido na main para dropa a caixa na area certa

#o proprio nó
@onready var caixa_1: MeshInstance3D = $"."

var contVisiblePainel:int

func _ready() -> void:
	if Global.texturaCaixa1.size() > 0:
		var textura = load(Global.texturaCaixa1[0])
		var material = StandardMaterial3D.new()
		material.albedo_texture = textura
		caixa_1.material_override = material
		Global.texturaCaixa1.pop_front()

	elif Global.texturaAlternativo1.size() > 0:
		var textura = load(Global.texturaAlternativo1[0])
		var material = StandardMaterial3D.new()
		material.albedo_texture = textura
		caixa_1.material_override = material
		Global.texturaAlternativo1.pop_front()

func _process(_delta: float) -> void:
	#exclui objeto do jogo 
	if Input.is_action_just_pressed("dropCaixas") and Global.excluirCaixa == true:
		exclui_caixa()
		print("teste")
	#Drop de objetos no areacaixa no Nodecaixa1
	if Input.is_action_just_pressed("dropCaixas") and Global.dropCaixa == true:
		drop_object()
	
	if Input.is_action_just_released("informacao"):
		descText.text = Global.descricaoCaixa1[0]
		panelInfo.visible = true
	if Input.is_action_just_pressed("FecharPainel"):
		descText.text = " "
		panelInfo.visible = false

func _transfer_object(): #transfere o proprio objeto caixas_1 para a mão do player
	caixa_1.reparent(SlotPlayer)
	caixa_1.position = Vector3.ZERO
	caixa_1.rotation = Vector3.ZERO

func drop_object():
	caixa_1.reparent(nodecaixa_1)
	caixa_1.position = Vector3.ZERO
	caixa_1.rotation = Vector3.ZERO

func exclui_caixa():
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
