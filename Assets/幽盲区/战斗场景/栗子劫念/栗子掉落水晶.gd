extends Area2D

var y_add = 10
var explosion_scene = preload("res://Assets/幽盲区/战斗场景/栗子劫念/栗子水晶爆炸粒子.tscn")
var state: String = "regular"
func _ready() -> void:
	state = "regular"
	$Node/Line2D.is_spawn = true
	$AnimatedSprite2D.play("Ready")
	self.modulate.a = 0
	y_add = randf_range(0, 30)
	
func _physics_process(delta: float) -> void:
	
	if $AnimatedSprite2D.animation == "Ready":
		self.modulate.a += 0.01
		return
		
	if $AnimatedSprite2D.animation == "Falling":
		
		self.modulate.a = 1
		self.global_position.y += y_add
		y_add += 0.4
		return
		
	if $AnimatedSprite2D.animation == "End":
		$Node/Line2D.modulate.a -= 0.05
		self.modulate.a -= 0.05
		return

func _process(delta: float) -> void:
	if self.global_position.y >= 815 and state == "regular":
		state = "rest"
		$AnimatedSprite2D.play("End")
		var explosion = explosion_scene.instantiate()
		explosion.global_position = global_position + Vector2(0, 20)
		explosion.emitting = true
		get_tree().current_scene.add_child(explosion)

func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "Ready":
		$AnimatedSprite2D.play("Falling")
	elif $AnimatedSprite2D.animation == "End":
		self.queue_free()

func _on_body_entered(body: Node2D) -> void:
	if $AnimatedSprite2D.animation == "Falling":
		var arr = self.get_overlapping_bodies()
		attack_body(arr, 17)
	
func attack_body(arr: Array, damage: float):
	for i in arr:
		if i.is_in_group("player"):
			self.queue_free()
			i.take_hit(damage)
