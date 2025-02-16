extends CharacterBody3D

@export_category("Movimentação")
@export var speed = 4
@export var joystick:TouchScreenButton #Adiciona o joystick no nó menu

#Aplica a gravidade ao player
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

#nó para girar o player conforme a direção dado pelo joystick
@onready var player: CharacterBody3D = $"."

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta

	var input_dir = joystick.get_joystick_dir()
	var direction = Vector3(input_dir.x, 0, input_dir.y).normalized()

	if direction:
		# Gira o player na direção de movimento.
		player.look_at(player.global_transform.origin - direction, Vector3.UP)
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	move_and_slide()
