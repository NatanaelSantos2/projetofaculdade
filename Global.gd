extends Node

#Para o fudamentos enviar qual index para o variações que tambem ler qual index para pega qual variação no JSON
var fundamentos:int #Fundamentos manda o index e vai para as caxas
var variacoes:int #Variações manda o index e vai para as caxas

var excluirCaixa: bool
var dropCaixa: bool

#Area de armazenamento da caixa 1
var descricaoCaixa1 = []
var texturaCaixa1 = []
var texturaAlternativo1 = []
var descricaoAlternativo1 = []

#Area de armazenamento da caixa 2
var nomeCaixa2 = []
var descricaoCaixa2 = []
var texturaCaixa2 = []
var nomeAlternativo2 = []
var descricaoAlternativo2 = []

#Area de armazenamento da caixa 3
var nomeCaixa3 = []
var descricaoCaixa3 = []
var texturaCaixa3 = []
var nomeAlternativo3 = []
var descricaoAlternativo3 = []

#Area de armazenamento da caixa 4
var nomeCaixa4 = []
var descricaoCaixa4 = []
var texturaCaixa4 = []
var nomeAlternativo4 = []
var descricaoAlternativo4 = []

#Area de armazenamento da caixa 5
var nomeCaixa5 = []
var descricaoCaixa5 = []
var texturaCaixa5 = []
var nomeAlternativo5 = []
var descricaoAlternativo5 = []

func carregar_json(caminho: String) -> Dictionary: #ler json para as caixas
	var file = FileAccess.open(caminho, FileAccess.READ)
	if file:
		var conteudo = file.get_as_text()
		return JSON.parse_string(conteudo)
	return {}
