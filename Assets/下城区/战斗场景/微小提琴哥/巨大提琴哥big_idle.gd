extends Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."
@onready var detection_range: Area2D = $"../../PlayerCheck" # 寻找玩家的范围

func enter():
	ani_2D.play("BigIdle")
	var duration = randf_range(0.3, 0.4)
	$Timer.start(duration)
	
func process():
	pass
	
func _on_timer_timeout() -> void:
	# 9 - 13 五个技能
	var attacks = [9, 10, 12, 13]
	# 把上次的攻击从列表中移除
	attacks.erase(monster.last_attack)
	# 从剩下的攻击里随机选一个
	var choice = attacks[randi() % attacks.size()]
	# 记录并切换状态
	monster.last_attack = choice
	get_parent().change_state(choice)

func exit():
	$Timer.stop()
