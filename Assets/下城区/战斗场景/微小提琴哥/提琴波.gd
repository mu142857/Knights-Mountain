extends Area2D

func _ready() -> void:
	$AnimatedSprite2D.play("default")
	var ptc = preload("res://Assets/下城区/战斗场景/微小提琴哥/提琴波粒子.tscn").instantiate()
	ptc.position = self.global_position
	ptc.emitting = true
	get_tree().current_scene.add_child(ptc)

func _on_animated_sprite_2d_animation_finished() -> void:
	self.queue_free()
