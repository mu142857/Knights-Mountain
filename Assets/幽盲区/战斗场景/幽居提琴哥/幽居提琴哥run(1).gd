extends  Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."
@onready var detection_range: Area2D = $"../../PlayerCheck" # 寻找玩家的范围
@onready var ani_player: AnimationPlayer = $"../../AnimationPlayer"

const MIN_RUNNING_DISTANCE: float = 300
const MAX_RUNNING_DISTANCE: float = 700
const PLAYER_FORBIDDEN: float = 200 # SAFETY_DISTANCE
const LEFT_BOUND: float = 200
const RIGHT_BOUND: float = 1200

var target_position: Vector2 = Vector2(0, 845.997)

func enter():

	$Timer.start(0.8)
	ani_2D.play("Run")
	target_postion_calculation()
	if target_position.x < monster.global_position.x:
		monster.face_left()
	else:
		monster.face_right()
	run()

func target_postion_calculation():

	# 获取玩家信息
	var info = get_player_info()
	var player_pos: Vector2 = info[2]
	var player_dir: int = info[1]  # -1 在左，1 在右，0 未知
	var monster_x = monster.global_position.x

	# 构建初始候选区间：monster_x ± [MIN_RUNNING_DISTANCE, MAX_RUNNING_DISTANCE]
	var raw_intervals := []
	var a1 = max(monster_x - MAX_RUNNING_DISTANCE, LEFT_BOUND)
	var b1 = monster_x - MIN_RUNNING_DISTANCE
	if b1 > a1:
		raw_intervals.append([a1, b1])
	var a2 = monster_x + MIN_RUNNING_DISTANCE
	var b2 = min(monster_x + MAX_RUNNING_DISTANCE, RIGHT_BOUND)
	if b2 > a2:
		raw_intervals.append([a2, b2])

	# 删除玩家禁区 [player_pos.x - PLAYER_FORBIDDEN, player_pos.x + PLAYER_FORBIDDEN]
	var forbid_l = player_pos.x - PLAYER_FORBIDDEN
	var forbid_r = player_pos.x + PLAYER_FORBIDDEN
	var valid_intervals := []
	for iv in raw_intervals:
		var l = iv[0]
		var r = iv[1]
		if r <= forbid_l or l >= forbid_r:
			# 完全在外侧
			valid_intervals.append([l, r])
		else:
			# 左侧残余
			if l < forbid_l:
				valid_intervals.append([l, forbid_l])
			# 右侧残余
			if r > forbid_r:
				valid_intervals.append([forbid_r, r])
	
	# 如果还有可落脚区间，从中随机挑一个点
	if valid_intervals.size() > 0:
		# 按区间长度加权随机
		var total_len = 0.0
		for iv in valid_intervals:
			total_len += iv[1] - iv[0]
		var pick = randf() * total_len
		for iv in valid_intervals:
			var length = iv[1] - iv[0]
			if pick < length:
				target_position.x = iv[0] + randf() * length
				break
			pick -= length
	else:
		# “穿过”玩家：反向取玩家禁区外的距离
		if player_dir == 0:
			player_dir = 1 if monster_x < player_pos.x else -1
		var flee_dir = -player_dir
		var base = player_pos.x + flee_dir * PLAYER_FORBIDDEN
		var l = base + flee_dir * MIN_RUNNING_DISTANCE
		var r = base + flee_dir * MAX_RUNNING_DISTANCE
		# 确保区间方向正确
		if l > r:
			var tmp = l
			l = r
			r = tmp
		l = clamp(l, LEFT_BOUND, RIGHT_BOUND)
		r = clamp(r, LEFT_BOUND, RIGHT_BOUND)
		if r > l:
			target_position.x = l + randf() * (r - l)
		else:
			# 如果还是出界，就直接往 flee_dir 方向移动最小距离
			target_position.x = clamp(monster_x + flee_dir * MIN_RUNNING_DISTANCE, LEFT_BOUND, RIGHT_BOUND)
	# 保持原来的 Y 坐标
	target_position.y = monster.global_position.y

	
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

func run():
	
	var tween = create_tween()

	# 在 1 秒内，将 position 从当前值插值到 target_pos
	tween.set_trans(Tween.TRANS_QUAD)       # 二次缓动曲线（加速—减速）
	tween.set_ease(Tween.EASE_IN_OUT)       # 先加速后减速
	tween.tween_property(monster, "position", target_position, 0.8) 

func exit():
	$Timer.stop()

func _on_timer_timeout() -> void:
	get_parent().change_state(2)
