extends Basic_State

@onready var monster: CharacterBody2D = $"../.."
@onready var ani_sprite2d: AnimatedSprite2D = $"../../AnimatedSprite2D"

func enter():
	$"../../AnimationPlayer".play("Attack")

func process():
	if !$"../..".is_on_floor():
		$"../..".velocity.y += 15
		$"../..".move_and_slide()

func attack():
	var sce = preload("res://Assets/幻乡/战斗场景/哥布林回旋镖兵/哥布林回旋镖.tscn").instantiate()
	if monster.direct == Vector2.LEFT:
		sce.setup($"../../攻击位置/左攻击位置".global_position, false)
		monster.get_parent().add_child(sce)
	else:
		sce.setup($"../../攻击位置/右攻击位置".global_position, true)
		monster.get_parent().add_child(sce)
		
func exit():
	ani_sprite2d.stop()
	
func _on_animated_sprite_2d_animation_finished() -> void:
	if $"../../AnimatedSprite2D".animation == "Attack":
		get_parent().change_state(1)
