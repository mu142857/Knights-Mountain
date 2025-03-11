extends Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."
@onready var attacks: Node2D = $"../../SummonPoint"
@onready var detection_range: Area2D = $"../../PlayerCheck" # 寻找玩家的范围

var skill_is_sprint: bool = false

func enter():
	#Game.shake_camera(30)
	#Game.flash(1.1, Color(0.6, 0.6, 0.6))
	ani_2D.play("Disappear")

func process():
	pass

func exit():
	pass

func _on_animated_sprite_2d_animation_finished() -> void:
	if ani_2D.animation == "Disappear":
		if monster.ready_to_underground_fire == true:
			get_parent().change_state(9)
		else:
			skill_brach()

func sprint_position_calculation():
	var k = randi_range(0,1)
	if k == 0:
		monster.global_position.x = monster.scene_startx + 170
		face_right()
	else:
		monster.global_position.x = monster.scene_endx - 170
		face_left()

func skill_position_calculation():
	var k = randi_range(0,1)
	if k == 0:
		monster.global_position.x = ((monster.scene_endx - monster.scene_startx) / 3) + monster.scene_startx
		monster.global_position.y -= 400
		face_right()
	else:
		monster.global_position.x = (2 * (monster.scene_endx - monster.scene_startx) / 3) + monster.scene_startx
		monster.global_position.y -= 400
		face_left()

func face_right():
	monster.direct = Vector2.RIGHT
	ani_2D.scale.x = 2
	attacks.scale.x = 1

func face_left():
	monster.direct = Vector2.LEFT
	ani_2D.scale.x = -2
	attacks.scale.x = -1

func skill_brach():
	monster.hide()
	if skill_is_sprint == true:
		sprint_position_calculation()
		get_parent().change_state(3)
	else:
		skill_position_calculation()
		get_parent().change_state(1)
	
