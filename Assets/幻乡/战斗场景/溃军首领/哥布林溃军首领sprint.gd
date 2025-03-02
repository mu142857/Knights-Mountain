extends Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var ami_plr: AnimationPlayer = $"../../AnimationPlayer"
@onready var monster: CharacterBody2D = $"../.."

var speed: float = 0

func enter():
	ami_plr.play("Sprint")

func process():
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
	
func shake_camera():
	Game.shake_camera(5)
	Game.flash(0.5, Color(1, 0.7, 0.7))
