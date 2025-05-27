extends Basic_State

@onready var monster: CharacterBody2D = $"../.."
@onready var ani_sprite2d: AnimatedSprite2D = $"../../AnimatedSprite2D"

var huoqiu = preload("res://Assets/幻乡/战斗场景/哥布林火焰兵/哥布林火球.tscn")

func enter():
	$"../../AnimationPlayer".play("Attack")

func process():
	if !$"../..".is_on_floor():
		$"../..".velocity.y += 15
		$"../..".move_and_slide()

func attack():
	
	var sce1 = huoqiu.instantiate()
	sce1.setup($"../../攻击位置/左攻击位置".global_position, false, monster.global_position.y)
	monster.get_parent().add_child(sce1)
	
	var sce2 = huoqiu.instantiate()
	sce2.setup($"../../攻击位置/右攻击位置".global_position, true, monster.global_position.y)
	monster.get_parent().add_child(sce2)

func stop():
	ani_sprite2d.stop()
	
func _on_animated_sprite_2d_animation_finished() -> void:
	if $"../../AnimatedSprite2D".animation == "Attack":
		get_parent().change_state(0)
