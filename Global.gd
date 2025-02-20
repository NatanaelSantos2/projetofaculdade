extends Node

#Para o fudamentos enviar qual index para o variações que tambem ler qual index para pega qual variação no JSON
var fundamentos:int #Fundamentos manda o index e vai para as caxas
var variacoes:int #Variações manda o index e vai para as caxas

var nomeCaixa1 = {}
var descricaoCaixa1 = {}
var texturaCaixa1 = {}

func carregar_json(caminho: String) -> Dictionary: #ler json para as caixas
	var file = FileAccess.open(caminho, FileAccess.READ)
	if file:
		var conteudo = file.get_as_text()
		return JSON.parse_string(conteudo)
	return {}
