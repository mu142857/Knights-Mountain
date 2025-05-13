extends Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var ami_plr: AnimationPlayer = $"../../AnimationPlayer"
@onready var monster: CharacterBody2D = $"../.."

func enter():
	Game.shake_camera(7)
	Game.flash(1.1, Color(0.243, 0.145, 0.184, 0.3))
	ami_plr.play("Attack")

func process():
		
	monster.velocity.y += 15
	monster.move_and_slide()

func exit():
	ami_plr.stop()
	
func _on_animated_sprite_2d_animation_finished() -> void:
	if ani_2D.animation == "Attack":
		get_parent().change_state(0)

func shake_camera():
	Game.shake_camera(8.5)
	Game.flash(0.5, Color(0.443, 0.345, 0.484, 0.3))

func attack_check1():
	var arr = $"../../AttackChecks/Attack1".get_overlapping_bodies()
	for i in arr:
		if i.is_in_group("player"):
			i.take_hit(10)

func attack_check2():
	var arr = $"../../AttackChecks/Attack2".get_overlapping_bodies()
	for i in arr:
		if i.is_in_group("player"):
			i.take_hit(10)

func attack_check3():
	var arr = $"../../AttackChecks/Attack3".get_overlapping_bodies()
	for i in arr:
		if i.is_in_group("player"):
			i.take_hit(10)

func attack_check4():
	var arr = $"../../AttackChecks/Attack4".get_overlapping_bodies()
	for i in arr:
		if i.is_in_group("player"):
			i.take_hit(10)
