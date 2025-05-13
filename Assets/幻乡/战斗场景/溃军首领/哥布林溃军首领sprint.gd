extends Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var ami_plr: AnimationPlayer = $"../../AnimationPlayer"
@onready var monster: CharacterBody2D = $"../.."

var speed: float = 0
var damaging: bool = false

func enter():
	damaging = false
	ami_plr.play("Sprint")

func process():

	if damaging:
		attack_check(10)
	
	if monster.velocity.y > 0:
		get_parent().change_state(0)
		return
		
	monster.velocity.x = monster.direct.x * speed
	monster.velocity.y += 15
	monster.move_and_slide()
	
func exit():
	monster.velocity = Vector2.ZERO
	ami_plr.stop()
	
func _on_animated_sprite_2d_animation_finished() -> void:
	if ani_2D.animation == "Sprint":
		get_parent().change_state(0)

func set_speed(velocity):
	speed = velocity

func set_damage(damage: bool):
	damaging = damage

func shake_camera():
	Game.shake_camera(5)
	Game.flash(0.4, Color(1, 0.7, 0.7, 0.3))
	
func attack_check(damage: float):
	var arr = $"../../AttackChecks/Punch".get_overlapping_bodies()
	for i in arr:
		if i.is_in_group("player"):
			i.take_hit(damage)
