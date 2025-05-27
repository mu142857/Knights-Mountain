extends Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."

var skill_ready: bool = true
@export var skill_cooldown: float = 0.1
@export var number_of_skills: int = 1
var skills_count: int = 0

var change_timer_started: bool = false

var daliandao = preload("res://Assets/下城区/战斗场景/邪帽/大镰刀.tscn")
var zhongliandao = preload("res://Assets/下城区/战斗场景/邪帽/中镰刀.tscn")
var xiaoliandao = preload("res://Assets/下城区/战斗场景/邪帽/小镰刀.tscn")

# [技能组设定] 预设技能组字典，键为技能个数，值为可能的技能组合（每个组合用字符串数组表示，对应技能函数）
var all_skill_groups = {
	3: [
		["small", "small", "small"],
		["mid", "mid", "mid"],
		["big", "small", "small"],
		["big", "mid", "mid"],
		["big", "big", "big"]
	],
	5: [
		["big", "mid", "mid", "mid", "mid"],
		["big", "small", "small", "small", "small"],
		["big", "mid", "mid", "mid", "big"],
		["big", "small", "small", "small", "mid"],
		["big", "mid", "small", "mid", "small"]
	],
	7: [
		["big", "mid", "mid", "mid", "mid", "mid", "mid"],
		["big", "small", "small", "small", "small", "small", "small"],
		["big", "small", "mid", "small", "mid", "small", "mid"],
		["big", "big", "mid", "mid", "mid", "mid", "mid"],
		["big", "small", "mid", "mid", "mid", "small", "mid"]
	],
	9: [
		["big", "mid", "mid", "mid", "mid", "mid", "mid", "mid", "mid"],
		["big", "mid", "mid", "mid", "mid", "mid", "mid", "mid", "mid"],
		["big", "small", "small", "small", "small", "small", "small", "small", "small"],
		["big", "small", "mid", "small", "mid", "small", "mid", "small", "mid"],
		["big", "big", "big", "small", "small", "small", "mid", "mid", "mid"],
		["big", "big", "big", "mid", "mid", "mid", "small", "small", "small"]
	]
}

# [技能组设定]记录各血量段已用过的组合（键为技能个数，值为已选组合的下标数组）
var groups_used = {
	3: [],
	5: [],
	7: [],
	9: []
}

# [技能组设定]本次状态所选的技能组和当前索引
var chosen_group = []      # 比如 ["small", "big", "mid"]
var current_group_index = 0

func enter():
	#Game.shake_camera(30)
	#Game.flash(1.1, Color(0.6, 0.6, 0.6))
	
	change_timer_started = false
	if monster.health >= 1500:
		number_of_skills = 3
	elif monster.health >= 1000:
		number_of_skills = 5
	elif monster.health >= 500:
		number_of_skills = 7
	elif monster.health >= 0:
		number_of_skills = 9
		
	skills_count = 0
	ani_2D.play("SkillLoop")
	
	#【新增】根据当前技能数选择一个随机未用过的技能组
	var possible_groups = all_skill_groups[number_of_skills]
	var available_indices = []
	for i in range(possible_groups.size()):
		if i not in groups_used[number_of_skills]:
			available_indices.append(i)
	# 若所有组合都已用过，则重置记录
	if available_indices.is_empty():
		groups_used[number_of_skills] = []
		for i in range(possible_groups.size()):
			available_indices.append(i)
	var random_index = available_indices[randi() % available_indices.size()]
	groups_used[number_of_skills].append(random_index)
	chosen_group = possible_groups[random_index]
	current_group_index = 0

func process():
	
	if 	$"../../技能汲取特效".modulate.a < 1:
			$"../../技能汲取特效".modulate.a += 0.008
	else:
		$"../../技能汲取特效".modulate.a = 1
	# 当技能可释放且还没走完预设的技能组时，按组合顺序释放技能
	if skill_ready and current_group_index < number_of_skills:
		var current_skill = chosen_group[current_group_index]
		current_group_index += 1
		# 根据字符串调用对应技能函数
		if current_skill == "big":
			big_sickle()
		elif current_skill == "mid":
			mid_sickle()
		elif current_skill == "small":
			small_sickle()
	elif skills_count >= number_of_skills and !change_timer_started:
		change_timer_started = true
		var cooldown = monster.health / 1500
		$ChangerTimer.start(1.5 + cooldown)

func exit():
	pass

func big_sickle():
	skill_ready = false
	var cooldown = monster.health / 2100
	$Timer.start(0.4 + cooldown)
	skills_count += 1
	var sce = daliandao.instantiate()
	sce.global_position = monster.global_position
	monster.get_parent().add_child(sce)
	
func small_sickle():
	skill_ready = false
	var cooldown = monster.health / 2100
	$Timer.start(0.5 + cooldown)
	skills_count += 1
	var sce1 = xiaoliandao.instantiate()
	sce1.global_position = monster.global_position
	sce1._direction = 1
	monster.get_parent().add_child(sce1)
	var sce2 = xiaoliandao.instantiate()
	sce2.global_position = monster.global_position
	sce2._direction = -1
	monster.get_parent().add_child(sce2)
	
func mid_sickle():
	skill_ready = false
	var cooldown = monster.health / 2100
	$Timer.start(0.45 + cooldown)
	skills_count += 1
	var sce = zhongliandao.instantiate()
	sce.global_position = monster.global_position
	monster.get_parent().add_child(sce)
	
func _on_timer_timeout() -> void:
	skill_ready = true

func _on_changer_timer_timeout() -> void:
	get_parent().change_state(5)
