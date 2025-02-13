extends CharacterBody3D

@export var SPEED = 4
const JUMP_VELOCITY = 4.5

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var joystick: TouchScreenButton = $"../Control/CanvasLayer/joystick"


# Adiciona uma variável para controlar se o jogador já pulou.
var has_jumped = false

@onready var player: CollisionShape3D = $Collision

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta

	var input_dir = joystick.get_joystick_dir()
	var direction = Vector3(input_dir.x, 0, input_dir.y).normalized()

	if direction:
		# Gira o player na direção de movimento.
		player.look_at(player.global_transform.origin - direction, Vector3.UP)

	velocity.x = direction.x * SPEED
	velocity.z = direction.z * SPEED

	move_and_slide()
