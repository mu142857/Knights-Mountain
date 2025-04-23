extends Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."
@onready var detection_range: Area2D = $"../../PlayerCheck" # 寻找玩家的范围
@onready var beam: RayCast2D = $"../../主教激光"
@onready var aim_line: RayCast2D = $"../../主教激光瞄准线"

var player_position: Vector2
var beam_target_position: Vector2
var loop_number: int = 1
var half_life = 200

func enter():

	if monster.health <= half_life:
		loop_number = 6
	else:
		loop_number = 2

	$"../../AttackPlayer".play("Attack")

func process():
	pass

func exit():
	$"../../AttackPlayer".stop()
	
func attack():
	Game.flash(2, Color(0.8, 0.8, 1))
	Game.shake_camera(14)
	beam.cast_beem()

func preattack():
	aim_line.cast_beem()
	
func aim(): 
	player_position = get_player_direction()
	calculate_target_position(player_position)
	aim_line.target_position = aim_line.to_local(beam_target_position)
	beam.target_position = beam.to_local(beam_target_position)
	
func get_player_direction() -> Vector2:
	var position: Vector2 = Vector2.ZERO
	var arr: Array = detection_range.get_overlapping_bodies()
	if arr.size() > 0:
		for i in arr:
			if i.is_in_group("player"):
				position = i.global_position
	return position

func calculate_target_position(pos: Vector2):
	var diff: Vector2 = pos - $"../../主教激光瞄准线".global_position
	var diff_sign: float = pos.x - $"../../主教激光瞄准线".global_position.x
	var mul = 1000 / diff.x
	if diff_sign < 0:
		diff *= -mul
	else:
		diff *= mul
	beam_target_position = $"../../主教激光瞄准线".global_position + diff

func _on_animated_sprite_2d_animation_finished() -> void:
	if ani_2D.animation == "AfterAttack":
		if loop_number > 1:
			$"../../AttackPlayer".stop()
			$"../../AttackPlayer".play("Attack")
			loop_number -= 1
		else:
			get_parent().change_state(0)
