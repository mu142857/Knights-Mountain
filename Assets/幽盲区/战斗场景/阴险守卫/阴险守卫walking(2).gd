extends Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."
@onready var detection_range: Area2D = $"../../PlayerCheck" # 寻找玩家的范围

var tween: Tween

var player_pos: Vector2
var time: float = 3.5
var pos_list: Array = [Vector2(1620, 846), Vector2(-220, 846), Vector2(1620, 690), Vector2(-220, 690)]
var random_pos: int = 1

var summon = preload("res://Assets/幽盲区/战斗场景/阴险守卫/虚假阴险守卫.tscn")

func enter():
	# 隐身状态
	monster.modulate = Color(0.2, 0.2, 0.2, 0.1)
	
	ani_2D.play("Walking")
	time = 4.0
	
	random_pos = randi_range(0, 3)
	monster.global_position = pos_list[random_pos] # 随机选取列表里的位置
	
	var summoner = summon.instantiate()
	
	if random_pos == 0: # 召唤物面向相反的方向，走不同的路线
		monster.face_right()
		summoner.direct = 1
		summoner.low_road = false
	elif random_pos == 1:
		monster.face_left()
		summoner.direct = -1
		summoner.low_road = false
	elif random_pos == 2:
		monster.face_right()
		summoner.direct = 1
		summoner.low_road = true
	else:
		monster.face_left()
		summoner.direct = -1
		summoner.low_road = true
		
	get_tree().current_scene.add_child(summoner)
	run()
	$Timer.start(time)

func process():
	pass

func exit():
	if tween and tween.is_valid():
		tween.kill()  # 停止并立即移除
	monster.modulate = Color(1, 1, 1, 1)
	$Timer.stop()
	
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
	tween = create_tween()
	
	if random_pos == 0:
		tween.tween_property(monster, "position", Vector2(-220, 846), time)  
	elif random_pos == 1:
		tween.tween_property(monster, "position", Vector2(1620, 846), time) 
	elif random_pos == 2:
		tween.tween_property(monster, "position", Vector2(-220, 690), time) 
	else:
		tween.tween_property(monster, "position", Vector2(1620, 690), time) 
		
		
	tween.set_trans(Tween.TRANS_QUART)  # 四次缓动曲线
	tween.set_ease(Tween.EASE_IN)
	tween.parallel().tween_property(monster, "modulate", Color(1, 1, 1, 1), time) 

func _on_timer_timeout() -> void:
	get_parent().change_state(1)

func _on_attack_alert_body_entered(body: Node2D) -> void:
	if ani_2D.animation == "Walking":
		var random_skill = randi_range(4, 5)
		get_parent().change_state(random_skill)
