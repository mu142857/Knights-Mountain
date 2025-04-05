extends Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."
@onready var attacks: Node2D = $"../../SummonPoint"
@onready var detection_range: Area2D = $"../../PlayerCheck" # 寻找玩家的范围

func enter():
	#Game.shake_camera(30)
	#Game.flash(1.1, Color(0.6, 0.6, 0.6))
	ani_2D.play("SkillEnd")

func process():
	if $"../../技能汲取特效".modulate.a > 0.0:
		$"../../技能汲取特效".modulate.a -= 0.03

func exit():
	pass

func _on_animated_sprite_2d_animation_finished() -> void:
	if ani_2D.animation == "SkillEnd":
		skill()

func sprint_position_calculation():
	var k = randi_range(0,1)
	if k == 0:
		monster.global_position.x = monster.scene_startx + 170
		face_right()
	else:
		monster.global_position.x = monster.scene_endx - 170
		face_left()

func face_right():
	monster.direct = Vector2.RIGHT
	ani_2D.scale.x = 2
	attacks.scale.x = 1

func face_left():
	monster.direct = Vector2.LEFT
	ani_2D.scale.x = -2
	attacks.scale.x = -1

func skill():
	monster.hide()
	sprint_position_calculation()
	get_parent().change_state(3)
