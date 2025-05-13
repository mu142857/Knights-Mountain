extends Area2D

func _ready() -> void:
	$AnimatedSprite2D.play("BeforeWave")

func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "BeforeWave":
		$AnimatedSprite2D.play("Wave")
	elif $AnimatedSprite2D.animation == "Wave":
		$AnimatedSprite2D.play("AfterWave")
	elif $AnimatedSprite2D.animation == "AfterWave":
		self.queue_free()


func _process(delta: float) -> void:
	if $AnimatedSprite2D.animation == "Wave":
		var arr = self.get_overlapping_bodies()
		attack_body(arr, 15)
	
func attack_body(arr: Array, damage: float):
	for i in arr:
		if i.is_in_group("player"):
			i.take_hit(damage)
