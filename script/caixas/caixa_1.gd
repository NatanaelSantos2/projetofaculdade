extends MeshInstance3D

@export var hand: Node3D
@onready var caixas: Node3D = $"."
@export var parent_node: Node3D
@onready var largar: Button = $"../../../Control/CanvasLayer/largar"

var dados = {}  # Armazena os dados carregados do JSON

func _ready():
	dados = carregar_dados_da_caixa()
	if dados:
		print("Caixa ID:", str(Global.contCaixa), "Descrição:", dados["descricao"], "Peso:", dados["peso"], "Cor:", dados["cor"])
		
func carregar_dados_da_caixa():
	var file = FileAccess.open("res://script/imprimirMensagem.json", FileAccess.READ)
	if file:
		var json_data = JSON.parse_string(file.get_as_text())
		return json_data.get(str(Global.contCaixa), {})  # Retorna os dados da caixa ou um dicionário vazio
	return {}

func has_child() -> bool:
	return parent_node.get_child_count() > 0

func _process(_delta: float) -> void:
	if largar.button_pressed:
		drop_object()

func _transfer_object():
	caixas.reparent(hand)
	caixas.position = Vector3.ZERO
	caixas.rotation = Vector3.ZERO

func drop_object():
	var caixa = hand.get_child(0) if hand.get_child_count() > 0 else null
	if caixa:
		caixa.queue_free()

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		if has_child():
			print("O nó já tem pelo menos um filho.")
		else:
			call_deferred("_transfer_object")
