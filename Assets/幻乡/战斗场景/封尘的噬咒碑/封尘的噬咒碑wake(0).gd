extends Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."
@onready var detection_range: Area2D = $"../../PlayerCheck" # 寻找玩家的范围

var morning_grumpiness: bool = false
func enter():
	morning_grumpiness = false
	monster.show()
	if monster.health < 1490:
		ani_2D.play("Wake")
	else:
		get_parent().change_state(2)
	
func process():
	if morning_grumpiness:
		absorb_energy()
		morning_grumpiness = false

func _on_animated_sprite_2d_animation_finished() -> void:
	if ani_2D.animation == "Wake":
		$WakingTime.start(1.5)
		morning_grumpiness = true


func _on_waking_time_timeout() -> void:
	get_parent().change_state(6)

func absorb_energy():
	var tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_QUART)  # 四次缓动曲线
	tween.set_ease(Tween.EASE_IN)       # 加速
	tween.tween_property(monster, "global_position", Vector2(700, -100) ,1.5)
