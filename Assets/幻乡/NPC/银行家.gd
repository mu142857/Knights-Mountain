extends CharacterBody2D

@onready var detection_range: Area2D = $"../../PlayerCheck" # 寻找玩家的范围
@onready var banker: AnimatedSprite2D = $AnimatedSprite2D
var direction: int = 0

func _on_player_check_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		banker.scale.x = -1.84
func _on_player_check_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		banker.scale.x = 1.84
