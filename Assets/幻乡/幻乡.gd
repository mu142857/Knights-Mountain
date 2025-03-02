extends Node2D

@onready var map_array: Array = $"地图".get_children()
#                                   [0]室内粉色(小女孩房间)            [1]晚上森林
var canvas_modulate_array: Array = [Color(0.557, 0.467, 0.729, 1), Color(0.078, 0.236, 0.180, 1)]

func _ready() -> void:
	#$CanvasModulate.color = canvas_modulate_array[1]
	pass

func _process(delta: float) -> void:
	pass
