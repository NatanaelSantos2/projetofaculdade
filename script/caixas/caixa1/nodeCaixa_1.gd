extends Node

@onready var nodecaixa_1: Node3D = $"."
var cena_mesh:String = "res://scenes/objects/caixas/caixas_1.tscn"
var acesso:bool = false

func _ready() -> void:
	print(has_child())
	var dados = Global.carregar_json("res://script/pythonCaixas.json")
	var keyss = dados[str(Global.fundamentos)][str(Global.variacoes)]

	if keyss.has("textura1") and keyss.has("nome1") and keyss.has("descricao1"):
		adicionarVariavel(keyss["textura1"], keyss["nome1"], keyss["descricao1"])
		ops(keyss["descricaocaixa1"], keyss["nome1"])

func adicionarVariavel(textura: String, nome: String, descricao: String):
	Global.texturaCaixa1.append(textura)
	Global.nomeCaixa1.append(nome)
	Global.descricaoCaixa1.append(descricao)
	
func ops(descricaocaixa1:String, nomecaixa1:String):
	Global.texturaCaixa1.append(descricaocaixa1)
	Global.nomeCaixa1.append(nomecaixa1)

func _process(delta: float) -> void:
	if !has_child():
		Global.validaCaixa2= true
		var cena = load(cena_mesh)  # Carrega a cena do mesh
		var instancia = cena.instantiate()  # Instancia o objeto
		nodecaixa_1.add_child(instancia)  # Adiciona ao nó pai
		Global.addIdClonado1 -= 1

func has_child() -> bool: #Verifica se tem nó filho
	return nodecaixa_1.get_child_count() > 0
