extends Node2D

func _process(delta: float) -> void:
	$CanvasLayer/Label.text = str($"..".health)
