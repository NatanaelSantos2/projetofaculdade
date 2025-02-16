extends TouchScreenButton

@onready var knod = $knod
@onready var max_distance = shape.radius

var stick_center: Vector2 = texture_normal.get_size() / 2
var touch_index: int = -1  # Índice do toque que controla o joystick

func _ready():
	set_process(false)
	
func _process(_delta):
	if touch_index != -1:  # Só processa se houver um toque válido
		knod.global_position = get_global_mouse_position()
		knod.position = stick_center + (knod.position - stick_center).limit_length(max_distance)

func _input(event):
	if event is InputEventScreenTouch:
		# Captura apenas toques dentro da área do joystick
		if event.pressed and touch_index == -1 and is_touch_inside(event.position):
			touch_index = event.index
			set_process(true)
		elif not event.pressed and event.index == touch_index:
			touch_index = -1
			set_process(false)
			knod.position = stick_center

func get_joystick_dir() -> Vector2:
	var dir = knod.position - stick_center
	return dir.normalized()

# Verifica se o toque está dentro da área do joystick
func is_touch_inside(touch_pos: Vector2) -> bool:
	var rect_position = get_global_transform().origin
	var rect_size = texture_normal.get_size()
	var rect = Rect2(rect_position, rect_size)
	return rect.has_point(touch_pos)
