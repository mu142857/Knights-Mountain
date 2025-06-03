extends Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."
@onready var detection_range: Area2D = $"../../PlayerCheck" # 寻找玩家的范围
@onready var backline: Line2D = $"../../Node/Line2D"

func enter():
	monster.show()
	ani_2D.play("Idle")
	var duration: float
	if monster.second_stage:
		duration = randf_range(1.3, 1.5)
	else:
		duration = randf_range(0.1, 0.3)
	$Timer.start(duration)
	
func process():
	pass
	
func _on_timer_timeout() -> void:
	
	# 技能列表
	var attacks: Array
	
	if monster.second_stage == false:
		attacks = [1, 2, 3, 4, 6, 8] #[1, 2, 3, 4, 6, 8] # 血量越低越弱， 第一阶段全技能，第二阶段只有逃跑技能
	else:
		attacks = [4, 8]

	attacks.erase(monster.last_attack)
	var choice = attacks[randi() % attacks.size()]
	
	# 记录并切换状态
	monster.last_attack = choice
	get_parent().change_state(choice)

func exit():
	$Timer.stop()
