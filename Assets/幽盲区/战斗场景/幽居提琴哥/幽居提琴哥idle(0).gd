extends Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."
@onready var detection_range: Area2D = $"../../PlayerCheck" # 寻找玩家的范围

var duration
func enter():
	ani_2D.play("Idle")
	duration = randf_range(0.75, 0.75)
	$Timer.start(duration)
	
func process():
	pass
	
func _on_timer_timeout() -> void:
	var attacks = [1, 1]
	# 把上次的攻击从列表中移除
	attacks.erase(monster.last_attack)
	# 从剩下的攻击里随机选一个
	var choice = attacks[randi() % attacks.size()]
	# 记录并切换状态
	monster.last_attack = choice
	get_parent().change_state(choice)

func exit():
	$Timer.stop()
