extends Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."
@onready var detection_range: Area2D = $"../../PlayerCheck" # 寻找玩家的范围

func enter():
	ani_2D.play("Attack")
	var duration = randf_range(3, 5)
	$Timer.start(duration)
	$AttackDuration.start(0.8)
	
func process():
	pass

func _on_timer_timeout() -> void:
	get_parent().change_state(0)

func exit():
	$AttackDuration.stop()
	
func _on_attack_duration_timeout() -> void:
	var fire_ball = preload("res://Assets/下城区/战斗场景/残灯马/残灯马火球.tscn").instantiate()
	if $"../../AnimatedSprite2D".scale.x < 0:
		fire_ball.global_position = $"../../发射点/发射子弹点右".global_position
		fire_ball.vec_x = 1
	else:
		fire_ball.global_position = $"../../发射点/发射子弹点左".global_position
		fire_ball.vec_x = -1
	get_tree().current_scene.add_child(fire_ball)
	$AttackDuration.start(1.9)
