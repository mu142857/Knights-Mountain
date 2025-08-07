extends Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."
@onready var detection_range: Area2D = $"../../PlayerCheck" # 寻找玩家的范围

func enter():
	monster.show()
	ani_2D.play("Idle")
	var duration: float
	if monster.stage == 1:
		duration = 0.2
	else:
		duration = 0.1
	$Timer.start(duration)
	
func process():
	pass
	
func _on_timer_timeout() -> void:
	# 技能列表
	var attacks: Array
	
	if monster.stage == 1:
		attacks = [4, 4]
	elif monster.stage == 2:
		attacks = [8, 6, 5]
	else:
		attacks = [7, 6]

	attacks.erase(monster.last_attack)
	var choice = attacks[randi() % attacks.size()]
	
	# 记录并切换状态
	monster.last_attack = choice
	get_parent().change_state(choice)

func exit():
	$Timer.stop()
