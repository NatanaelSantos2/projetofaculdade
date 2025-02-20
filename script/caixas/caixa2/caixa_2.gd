extends MeshInstance3D

@export_category("SlotPlayer")
#SlotPlayer serve para armazenar a caixa e tambem para verificar se tem um nó filho
@export var SlotPlayer: Node3D #So define na main

@export_category("Butões")
@export var drop_caixas: Button #So define na main
@export var panelInfo: Panel #So define na main
@export var descText: TextEdit #So define na main

#o proprio nó
@onready var caixa_2: MeshInstance3D = $"."

var contVisiblePainel:int

var descricaoCaixa1:String
var nomeCaixa1:String
var texturaCaixa1:String

func _ready() -> void:
	var dados = carregar_json("res://script/pythonCaixas.json")
	var keyss = dados[str(Global.fundamentos)][str(Global.variacoes)]

	if keyss.has("textura1") and keyss.has("nome1") and keyss.has("descricao1"):
		adicionarVariavel(keyss["textura1"], keyss["nome1"], keyss["descricao1"])

	var textura = load(texturaCaixa1)
	if textura:
		var material = StandardMaterial3D.new()
		material.albedo_texture = textura
		caixa_2.material_override = material

func adicionarVariavel(textura1: String, nome: String, descricao: String):
	texturaCaixa1 = textura1
	nomeCaixa1 = nome
	descricaoCaixa1 = descricao


func carregar_json(caminho: String) -> Dictionary:
	var file = FileAccess.open(caminho, FileAccess.READ)
	if file:
		var conteudo = file.get_as_text()
		return JSON.parse_string(conteudo)
	return {}

func _process(_delta: float) -> void:
	
	if drop_caixas.button_pressed:
		drop_object()
	if Input.is_action_just_released("informacao"):
		contVisiblePainel += 1
		if contVisiblePainel == 1:
			descText.text = descricaoCaixa1
			panelInfo.visible = true
		if contVisiblePainel > 1:
			descText.text = " "
			panelInfo.visible = false
			contVisiblePainel = 0

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
