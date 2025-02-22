extends MeshInstance3D

#SlotPlayer serve para armazenar a caixa e tambem para verificar se tem um nó filho
@onready var SlotPlayer: Node3D = $"../../../player/CollisionPlayer/SlotPlayer"
@onready var panelInfo: Panel = $"../../../Control/CanvasLayer/Painel/Panel" #Definido na main Control
@onready var descText: Label = $"../../../Control/CanvasLayer/Painel/Panel/TextDescricao" #Definido na main Control

#o proprio nó
@onready var caixa_2: MeshInstance3D = $"."

var contVisiblePainel:int

var descricaoCaixa2:String
var texturaCaixa2:String

func _ready() -> void:
	var dados = Global.carregar_json("res://script/pythonCaixas.json")
	var keyss = dados[str(Global.fundamentos)][str(Global.variacoes)]

	if keyss.has("textura2") and keyss.has("descricao2"):
		adicionarVariavel(keyss["textura2"], keyss["descricao2"])

	var textura = load(texturaCaixa2)
	if textura:
		var material = StandardMaterial3D.new()
		material.albedo_texture = textura
		caixa_2.material_override = material

func adicionarVariavel(textura: String, descricao: String):
	texturaCaixa2 = textura
	descricaoCaixa2 = descricao

#func _process(_delta: float) -> void:
	#if Input.is_action_just_pressed("dropCaixas"):
		#drop_object()
	#if Input.is_action_just_released("informacao"):
		#contVisiblePainel += 1
		#if contVisiblePainel == 1:
			#descText.text = descricaoCaixa2[0]
			#panelInfo.visible = true
		#if contVisiblePainel > 1:
			#descText.text = " "
			#panelInfo.visible = false
			#contVisiblePainel = 0

func _transfer_object(): #transfere o proprio objeto caixas_1 para a mão do player
	caixa_2.reparent(SlotPlayer)
	caixa_2.position = Vector3.ZERO
	caixa_2.rotation = Vector3.ZERO

func drop_object():
	var caixa = SlotPlayer.get_child(0) if SlotPlayer.get_child_count() > 0 else null
	if caixa:
		caixa.queue_free()

func has_child() -> bool: #Verifica se tem nó filho
	return SlotPlayer.get_child_count() > 0

func _on_area_caixa_2_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D: #Verifica se foi player que entrou na area para se auto transferir
		if has_child():
			print("O nó já tem pelo menos um filho.")
		else:
			call_deferred("_transfer_object")
