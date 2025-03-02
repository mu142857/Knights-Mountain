extends Basic_State

@onready var shadow: CharacterBody2D = $"../.."
@onready var ani_play: AnimationPlayer = $"../../AnimationPlayer"

func enter():
	ani_play.play("Attack")

func _on_animated_sprite_2d_animation_finished() -> void:
	if !shadow.is_on_floor():
		shadow.velocity.y += 20
		shadow.move_and_slide() 	
	if $"../../AnimatedSprite2D".animation == "Attack":
		get_parent().change_state(0)

func attack():
	var sce = preload("res://Assets/幻乡/战斗场景/执杖影子怪/执法杖影子怪子弹.tscn").instantiate()
	if shadow.global_position.x > (shadow.scene_startx + shadow.scene_endx) / 2: 
		sce.position = $"../../攻击位置/左攻击位置".global_position
		sce.vec_x = -1
		shadow.get_parent().add_child(sce)
	else:
		sce.position = $"../../攻击位置/右攻击位置".global_position
		sce.vec_x = 1
		shadow.get_parent().add_child(sce)

func exit():
	ani_play.stop()
	
