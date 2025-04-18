extends Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."
@onready var detection_range: Area2D = $"../../PlayerCheck" # 寻找玩家的范围

func enter():
	ani_2D.play("Idle")
	var duration = randf_range(0.3, 0.5)
	$Timer.start(duration)
	
func process():
	pass

func _on_timer_timeout() -> void:
	get_parent().change_state(2)
