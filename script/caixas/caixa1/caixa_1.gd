extends MeshInstance3D

#SlotPlayer serve para armazenar a caixa e tambem para verificar se tem um nó filho
@onready var SlotPlayer: Node3D = $"../../../player/CollisionPlayer/SlotPlayer"
@onready var drop_caixas: Button = $"../../../Control/CanvasLayer/Botoes/dropCaixas"
@onready var panelInfo: Panel = $"../../Panel"
@onready var descText: TextEdit = $"../../Panel/TextEdit"

#o proprio nó
@onready var caixa_1: MeshInstance3D = $"."

var contVisiblePainel:int


func _ready() -> void:

	var textura = load(texturaCaixa1)
	if textura:
		var material = StandardMaterial3D.new()
		material.albedo_texture = textura
		caixa_1.material_override = material

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
	caixa_1.reparent(SlotPlayer)
	caixa_1.position = Vector3.ZERO
	caixa_1.rotation = Vector3.ZERO

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
