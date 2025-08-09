extends Basic_State #5

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."
@onready var detection_range: Area2D = $"../../PlayerCheck" # 寻找玩家的范围extends Node

var lizi = preload("res://Assets/幻乡/战斗场景/封尘的噬咒碑/神秘文字.tscn")
var barrage_amount: int       # 飞弹波数(会减少)
var total_barrage_amount: int # 飞弹波数(不会减少)
var duration: float = 0.2 # 子弹间隔时间
# 加载弹幕
var x = preload("res://Assets/幻乡/战斗场景/封尘的噬咒碑/石碑十字炸弹.tscn")
var u_fire = preload("res://Assets/幻乡/战斗场景/封尘的噬咒碑/石碑地火炸弹.tscn")
var tt = preload("res://Assets/幻乡/战斗场景/封尘的噬咒碑/石碑十字炸弹.tscn")

# 随机弹幕设置
var position_list: Array # 其余弹幕x坐标列表(长度为4)

func enter() -> void:

	# 根据 stage 设定总波数
	if monster.stage == 1:
		barrage_amount = 5
		duration = 0.2
	elif monster.stage == 2:
		barrage_amount = 10
		duration = 0.15
	elif monster.stage == 3:
		barrage_amount = 17
		duration = 0.1
	total_barrage_amount = barrage_amount

	# 计算需要随机生成的数量（总波数 - 1）并在 enter() 里一次性生成
	var random_count := barrage_amount - 1

	# 获取玩家位置（若没有玩家则用中间默认）
	var player_pos = get_player_info()[2]
	var first_x: float
	if player_pos != Vector2.ZERO:
		first_x = player_pos.x
	else:
		first_x = (20 + 1380) / 2
	position_list = generate_poisson_1d_with_first(20, 1380, 50, first_x, random_count)
	
	$Timer.start(duration)
	ani_2D.play("Skill")

func process():
	pass

func _on_timer_timeout() -> void:
	barrage_amount -= 1
	if barrage_amount >= (total_barrage_amount - 1):
		release_barrage_underground_fire(false)
	else:
		release_barrage_underground_fire(true, position_list[barrage_amount]) # 将随机位置设置成列表position_list中的barrage_amount项
	if barrage_amount <= 0:
		get_parent().change_state(1)
	else:
		$Timer.start(duration)

func exit():
	$Timer.stop()

func release_barrage_x(): # 召唤飞弹弹幕
	var szfd = x.instantiate()
	szfd.position = monster.global_position + Vector2(0, -211)
	get_tree().current_scene.add_child(szfd)

func release_barrage_underground_fire(random: bool, target_x: float = 0): # 召唤飞弹弹幕()
	var szfd = u_fire.instantiate()
	var pos
	pos = monster.global_position + Vector2(0, -211)
	szfd.position = pos
	if random:
		var random_pos: Vector2 = Vector2(target_x, 810)
		szfd.target_pos = random_pos
	else:
		var player_pos: Vector2 = Vector2(get_player_info()[2].x, 810)
		szfd.target_pos = player_pos
	get_tree().current_scene.add_child(szfd)

func release_barrage_turret(): # 召唤飞弹弹幕
	var szfd = tt.instantiate()
	szfd.position = monster.global_position
	get_tree().current_scene.add_child(szfd)

func get_player_info() -> Array:
	var direction: int = 0
	var distance: float = 0.0
	var position: Vector2 = Vector2.ZERO
	var arr: Array = detection_range.get_overlapping_bodies()
	if arr.size() > 0:
		for i in arr:
			if i.is_in_group("player"):
				direction = sign(i.global_position.x - monster.global_position.x)
				distance = abs(i.global_position.x - monster.global_position.x)
				position = i.global_position
	return [distance, direction, position] # direction中，-1表示(在主角)左边，1表示右边，0表示未知

# 随机弹幕位置(已确定第一发瞄准玩家的弹幕)
func generate_poisson_1d_with_first(min_x: float, max_x: float, D: float, first_x: float, random_count: int) -> Array:
	# 1. 初始化：samples 存放所有已确定的位置，用于距离检查
	var samples = [ first_x ]
	# 2. 存放随机生成的结果
	var rand_positions := Array()
	# 3. 最大尝试次数，防止死循环
	var max_attempts = random_count * 10
	var attempts = 0

	while rand_positions.size() < random_count and attempts < max_attempts:
		var x = randf_range(min_x, max_x)
		var ok = true
		# 4. 距离检查：与 samples 中所有点都要保持 >= D
		for s in samples:
			if abs(s - x) < D:
				ok = false
				break
		if ok:
			# 5. 如果通过检查，就把它加入结果和 samples
			rand_positions.append(x)
			samples.append(x)
		attempts += 1

	if rand_positions.size() < random_count:
		push_warning("generate_poisson_1d_with_first: 尝试次数不足，未生成足够弹幕！")

	# 6. 返回排序后的随机弹幕 x 列表
	rand_positions.sort()
	return rand_positions
