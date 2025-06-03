extends  Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."
@onready var detection_range: Area2D = $"../../PlayerCheck" # 寻找玩家的范围
@onready var ani_player: AnimationPlayer = $"../../AnimationPlayer"

var shuijin = preload("res://Assets/幽盲区/战斗场景/栗子劫念/弹射水晶.tscn")

func enter():
	ani_player.play("shoot_crystal")
	$Timer.start(0.325)
	var tween = get_tree().create_tween()
	tween.parallel().tween_property(ani_2D, "modulate", Color(1.3, 1.0, 1.5), 0.15)

func exit():
	ani_player.stop()

func release_crystal():
	
	Game.flash(3, Color(0.9, 0.8, 1, 0.3))
	Game.shake_camera(11)
	
	var sce1 = shuijin.instantiate()
	var sce2 = shuijin.instantiate()
	var sce3 = shuijin.instantiate()
	var sce4 = shuijin.instantiate()
	
	sce1.position = $"../../AttackCheck/水晶发射点".global_position
	sce2.position = $"../../AttackCheck/水晶发射点".global_position
	sce3.position = $"../../AttackCheck/水晶发射点".global_position
	sce4.position = $"../../AttackCheck/水晶发射点".global_position
	
	# 往固定位置发射
	#var player_position = get_player_info()[2]
	#sce.velocity = (player_position - monster.global_position).normalized() * sce.speed # 瞄准主角
	
	# 往固定弧度发射
	# 弧度模式, 0为向右 1.5707963268为向下 3.1415926536为向左 -1.5707963268为向上
	#var dir = Vector2(cos(3.1415926536), sin(3.1415926536))
	
	var dir1 = Vector2(cos(-1.308996939), sin(-1.308996939)) # -75
	sce1.velocity = dir1.normalized() * sce1.speed
	
	var dir2 = Vector2(cos(-1.8325957146), sin(-1.8325957146)) # -105
	sce2.velocity = dir2.normalized() * sce2.speed
	
	var dir3 = Vector2(cos(-0.7853981634), sin(-0.7853981634)) # -45
	sce3.velocity = dir3.normalized() * sce3.speed
	
	var dir4 = Vector2(cos(-2.3561944902), sin(-2.3561944902)) # -135
	sce4.velocity = dir4.normalized() * sce4.speed
	
	get_tree().current_scene.add_child(sce1)
	get_tree().current_scene.add_child(sce2)
	get_tree().current_scene.add_child(sce3)
	get_tree().current_scene.add_child(sce4)


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

func _on_animated_sprite_2d_animation_finished() -> void:
	if ani_2D.animation == "Target":
		get_parent().change_state(0)

func _on_timer_timeout() -> void:
	var tween = get_tree().create_tween()
	tween.parallel().tween_property(ani_2D, "modulate", Color(1, 1, 1), 0.3)
