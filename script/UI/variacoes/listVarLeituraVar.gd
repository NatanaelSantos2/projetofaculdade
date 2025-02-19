extends ItemList

@onready var list_var: ItemList = $"."

var item_ids = {}
var indexx = str(Global.fundamentos)
func _ready() -> void:
	var dados = carregar_json("res://script/PythonGeral.json")
	if dados:
		var keyss = dados[indexx]
		for id in keyss.keys():
			var item = dados[indexx][id]
			adicionar_item(int(id), item["nome"], item["imagem"])

func carregar_json(caminho: String) -> Dictionary:
	var file = FileAccess.open(caminho, FileAccess.READ)
	if file:
		var conteudo = file.get_as_text()
		return JSON.parse_string(conteudo)
	return {}

func adicionar_item(id: int, nome: String, icone_path: String):
	var icone = load(icone_path)
	var index = list_var.add_item(nome, icone)
	item_ids[index] = id

func adicionarItens(nome, imagem):
	for i in range(5):
		list_var.add_item(nome, imagem)
