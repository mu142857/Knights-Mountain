extends Area2D

var attack_index: int = 0

func _ready() -> void:
	attack_index = 0
	$Timer.start(0.063)
	$AnimationPlayer.play("AttackCheck")
	var ptc = preload("res://Assets/下城区/战斗场景/微小提琴哥/提琴波粒子.tscn").instantiate()
	ptc.position = self.global_position
	ptc.emitting = true
	get_tree().current_scene.add_child(ptc)

func _on_animated_sprite_2d_animation_finished() -> void:
	self.queue_free()

func attack_check1():
	var arr = $AttackChecks/Area2D1.get_overlapping_bodies()
	for i in arr:
		if i.is_in_group("player"):
			i.take_hit(15)

func attack_check2():
	var arr = $AttackChecks/Area2D2.get_overlapping_bodies()
	for i in arr:
		if i.is_in_group("player"):
			i.take_hit(15)

func attack_check3():
	var arr = $AttackChecks/Area2D3.get_overlapping_bodies()
	for i in arr:
		if i.is_in_group("player"):
			i.take_hit(15)

func attack_check4():
	var arr = $AttackChecks/Area2D4.get_overlapping_bodies()
	for i in arr:
		if i.is_in_group("player"):
			i.take_hit(15)

func attack_check():
	match attack_index:
		0:
			pass
		1:
			attack_check1()
		2:
			attack_check2()
		3:
			attack_check3()
		4:
			attack_check4()
		5:
			attack_check3()
		6:
			attack_check2()
		7:
			attack_check1()

func _process(delta: float) -> void:
	attack_check()

func _on_timer_timeout() -> void:
	if attack_index % 2 == 0:
		$Timer.start(0.062)
		attack_index += 1
	else:
		$Timer.start(0.063)
		attack_index += 1
