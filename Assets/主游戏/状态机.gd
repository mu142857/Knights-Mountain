class_name State_Manager
extends Node

var states_array: Array = []
@onready var current: Basic_State # 初始状态

func _ready() -> void:
	states_array = get_children() # 获取状态列表
	current = states_array[0]
	current.enter() #进入默认状态

func _physics_process(delta: float) -> void:
	current.process() #执行状态中的程序

func change_state(id: int) -> void: #切换状态
	current.exit()
	current = states_array[id]
	current.enter()
	
#				对玩家增益减益及判定列表
# take_hit(damage)                               受击
# curse_of_shadow_debuff()                       诅咒debuff
# frost_debuff(severity, duration)               霜冻debuff
# inflammation_debuff(total_damage, duration)    燃烧debuff
# inflammation_debuff(damage_percent, duration)  中毒debuff
# weak_debuff(add_blood_loss_percent, duration)  易伤debuff

#				怪物类型列表
# group: monster                                 全敌怪统称
# group: shadow                                  阴影怪物
