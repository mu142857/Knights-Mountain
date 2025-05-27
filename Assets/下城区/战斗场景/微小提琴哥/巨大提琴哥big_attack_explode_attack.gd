extends Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."
@onready var detection_range: Area2D = $"../../PlayerCheck" # 寻找玩家的范围
@onready var ani_player: AnimationPlayer = $"../../AnimationPlayer"

var baozha = preload("res://Assets/下城区/战斗场景/微小提琴哥/提琴哥爆炸粒子.tscn")
var yinfulizi = preload("res://Assets/下城区/战斗场景/微小提琴哥/音符粒子.tscn")
var tiqinbo = preload("res://Assets/下城区/战斗场景/微小提琴哥/提琴波发射器.tscn")

func enter():
	ani_player.play("BigExplode")

func explode():
	
	attack_check()
	
	Game.shake_camera(10)
	var expl = baozha.instantiate()
	expl.position = monster.global_position
	expl.emitting = true
	get_tree().current_scene.add_child(expl)
	var note = yinfulizi.instantiate()
	note.position = monster.global_position
	note.emitting = true
	get_tree().current_scene.add_child(note)
	release_wave()

func release_wave():
	var wave1 = tiqinbo.instantiate()
	wave1.direct = monster.direct
	wave1.position = monster.global_position
	wave1.small_or_big = "big"
	get_tree().current_scene.add_child(wave1)
	
	var wave2 = tiqinbo.instantiate()
	wave2.direct = -monster.direct
	wave2.position = monster.global_position
	wave1.small_or_big = "big"
	get_tree().current_scene.add_child(wave2)

func _on_animated_sprite_2d_animation_finished() -> void:
	if ani_2D.animation == "BigExplode":
		ani_2D.play("BigAppear")
		return
	elif ani_2D.animation == "BigAppear":
		get_parent().change_state(9)
		return

func attack_check():
	var arr = $"../../AttackCheck/BigExplode".get_overlapping_bodies()
	for i in arr:
		if i.is_in_group("player"):
			i.take_hit(20)
