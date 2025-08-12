extends Area2D

func _ready() -> void:
	$AnimatedSprite2D.play("Ready")

func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "Ready":
		$AnimatedSprite2D.play("Firing")
	elif $AnimatedSprite2D.animation == "Firing":
		$AnimatedSprite2D.play("Done")
	else:
		self.queue_free()

func _on_body_entered(body: Node2D) -> void:
	if $AnimatedSprite2D.animation == "Firing":
		var arr = self.get_overlapping_bodies()
		attack_body(arr, 25)
	
func attack_body(arr: Array, damage: float):
	for i in arr:
		if i.is_in_group("player"):
			i.take_hit(damage)
