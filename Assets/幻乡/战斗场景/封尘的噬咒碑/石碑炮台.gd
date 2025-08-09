extends CharacterBody2D

#var yinfulizi = preload("res://Assets/幻乡/战斗场景/封尘的噬咒碑/神秘文字.tscn")
var fd = preload("res://Assets/幻乡/战斗场景/封尘的噬咒碑/石碑十字炸弹.tscn")

func _ready() -> void:
	add_to_group("monster")
	$Timer.start(7)
	$AnimatedSprite2D.play("Open")

func _on_timer_timeout() -> void:
	if $AnimatedSprite2D.animation != "Death":
		$AnimatedSprite2D.play("Death")

func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "Firing" or $AnimatedSprite2D.animation == "Open":
		$AnimatedSprite2D.play("Firing")
		release_barrage()
	if $AnimatedSprite2D.animation == "Death":
		self.queue_free()

func release_barrage(): # 召唤飞弹(deifan)弹幕
	var szfd = fd.instantiate()
	szfd.position = self.global_position
	get_tree().current_scene.add_child(szfd)

func take_hit(value: int):
	if $AnimatedSprite2D.animation != "Death":
		$AnimatedSprite2D.play("Death")
