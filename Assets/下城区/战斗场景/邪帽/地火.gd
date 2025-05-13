extends Area2D

func _ready() -> void:
	$AnimationPlayer.play("Fire")

func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "Fire":
		self.queue_free()

func _process(delta: float) -> void:
	if $AnimatedSprite2D.animation == "Fire":
		var arr = self.get_overlapping_bodies()
		attack_body(arr, 30)
	
func attack_body(arr: Array, damage: float):
	for i in arr:
		if i.is_in_group("player"):
			i.take_hit(damage)
