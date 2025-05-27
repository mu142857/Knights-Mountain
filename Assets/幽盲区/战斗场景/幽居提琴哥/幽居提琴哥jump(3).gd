extends Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."
@onready var detection_range: Area2D = $"../../PlayerCheck" # 寻找玩家的范围

var wuxianpu = preload("res://Assets/幽盲区/战斗场景/幽居提琴哥/五线谱.tscn")

var wait_for_summon: bool = true

var music_sheet_exist: bool = false

func enter():
	 
	wait_for_summon = true
	
	monster.velocity.y = -2000
	ani_2D.play("Jump")
	var musicsheet = wuxianpu.instantiate()
	musicsheet.global_position = Vector2.ZERO
	get_tree().current_scene.add_child(musicsheet)
	
	$Timer.start(10)

func process():
	if !music_sheet_exist and ani_2D.animation != "Jump" and !wait_for_summon:
		get_parent().change_state(4)

	elif ani_2D.animation == "Jump":
		
		if monster.velocity.y >= -0:
			monster.velocity.y = 0
			ani_2D.play("Wait")

		monster.velocity.y += 15
		monster.move_and_slide()
		
	else:
		get_music_sheet_info()

func get_music_sheet_info() -> void:
	var arr: Array = detection_range.get_overlapping_bodies()
	if arr.size() > 0:
		for i in arr:
			if i.is_in_group("music_sheet"):
				music_sheet_exist = true
				return
		music_sheet_exist = false
	music_sheet_exist = false

func _on_timer_timeout() -> void:
	wait_for_summon = false
