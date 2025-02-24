extends Node

@onready var nodecaixa_1: Node3D = $"."
var cena_mesh:String = "res://scenes/objects/caixas/caixas_1.tscn"
var acesso:bool = false

func _ready() -> void:
	print(has_child())
	var dados = Global.carregar_json("res://script/pythonCaixas.json")
	var keyss = dados[str(Global.fundamentos)][str(Global.variacoes)]

	if keyss.has("textura1") and keyss.has("descricao1"):
		adicionarVariavel(keyss["textura1"], keyss["descricao1"])
	if keyss.has("texturaAlternativo1") and keyss.has("descricaoAlternativo1"):
		alternativas(keyss["texturaAlternativo1"], keyss["descricaoAlternativo1"])
	if keyss.has("nome1"):
		adicionarNome(keyss["nome1"])

func adicionarNome(nome: String):
	Global.PainelResultado.append(nome)
	
func adicionarVariavel(textura: String, descricao: String):
	Global.texturaCaixa1.append(textura)
	Global.descricaoCaixa1.append(descricao)
	
func alternativas(texturacaixaalt1:String, descricaocaixaalt1:String):
	Global.texturaAlternativo1.append(texturacaixaalt1)
	Global.descricaoAlternativo1.append(descricaocaixaalt1)

func _process(_delta: float) -> void:
	#Para adicionar o objeto
	if !has_child() and Global.texturaAlternativo1.size() > 0 or Global.texturaCaixa1.size() > 0: 
		var cena = load(cena_mesh) 
		var instancia = cena.instantiate()  
		nodecaixa_1.add_child(instancia) 

func has_child() -> bool:
	#Verifica se tem nó filho
	return nodecaixa_1.get_child_count() > 0
