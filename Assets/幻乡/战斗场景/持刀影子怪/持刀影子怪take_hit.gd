extends Basic_State

@onready var shadow: CharacterBody2D = $"../.."
@onready var ani_sprite2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
var direct: Vector2 = Vector2.RIGHT
var speed: float = 0

var ready_to_escape: bool = true

func enter():
	if !ready_to_escape:
		get_parent().change_state(6)
		pass
	else:
		ani_sprite2d.play("Escape")
		sprint()

func process():
	shadow.velocity = direct * speed
	shadow.move_and_slide()
	
func exit():
	speed = 0
	
func sprint():
	
	if is_instance_valid($"../../Rays/玩家检测射线右".get_collider()):
		var plrr = $"../../Rays/玩家检测射线右".get_collider()
		if plrr.is_in_group("player"):
			direct = Vector2.RIGHT
			ani_sprite2d.scale.x = -1.52
			$"../../AttackChecks".scale.x = 1
			speed = abs(((plrr.global_position.x) - shadow.position.x) / 0.05)
			
	if is_instance_valid($"../../Rays/玩家检测射线左".get_collider()):
		var plrl = $"../../Rays/玩家检测射线左".get_collider()
		if plrl.is_in_group("player"):
			direct = Vector2.LEFT
			ani_sprite2d.scale.x = 1.52
			$"../../AttackChecks".scale.x = -1
			speed = abs(((plrl.global_position.x) - shadow.position.x) / 0.05)

func _on_animated_sprite_2d_animation_finished() -> void:
	if ani_sprite2d.animation == "Escape" and ready_to_escape == true:
		speed = 0
		ready_to_escape = false
		$Timer.start(2.5)
		get_parent().change_state(5)

func _on_timer_timeout() -> void:
	ready_to_escape = true
