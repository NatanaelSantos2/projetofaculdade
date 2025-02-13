extends Area3D

@onready var largar: Button = $"../Control/CanvasLayer/largar"
@onready var area_3d: Area3D = $"."

func _on_area_entered(area: Area3D) -> void:

	largar.disabled = false


func _on_area_exited(area: Area3D) -> void:
	largar.disabled = true
