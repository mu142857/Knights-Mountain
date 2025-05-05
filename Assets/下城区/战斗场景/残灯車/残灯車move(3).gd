extends Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."
@onready var detection_range: Area2D = $"../../PlayerCheck" # 寻找玩家的范围

var direction: int = 0
var speed: float = 0

func enter():
	var duration = randf_range(4, 6)
	$Timer.start(duration)
	ani_2D.play("Slide")
	
	speed = 10
	
func process():
	if $"../../移动粒子".modulate.a < 1:
		$"../../移动粒子".modulate.a += 0.008
	else:
		$"../../移动粒子".modulate.a = 1
	if monster.global_position.x > (monster.scene_endx - 100):
		monster.global_position.x = monster.scene_endx - 107
		get_parent().change_state(1)
		return
	elif monster.global_position.x < (monster.scene_startx + 100):
		monster.global_position.x = (monster.scene_startx + 107)
		get_parent().change_state(1)
		return
	direction = get_player_direction()[1]
	monster.velocity.x = direction * speed
	if speed < 170:
		speed += 2.1
	
	monster.move_and_slide()

func exit():
	pass
	
func get_player_direction() -> Array:
	
	var distance = 0.0
	var arr: Array = detection_range.get_overlapping_bodies()
	if arr.size() > 0:
		for i in arr:
			if i.is_in_group("player"):
				direction = sign(i.global_position.x - monster.global_position.x)
				distance = abs(i.global_position.x - monster.global_position.x)
	return [distance, direction] # direction中，-1表示左边，1表示右边，0表示未知

func _on_timer_timeout() -> void:
	get_parent().change_state(1)
