extends CharacterBody2D

@onready var world: WorldEnvironment = $WorldEnvironment

var during_music: bool = true

func _ready() -> void:
	
	self.add_to_group("music_sheet")
	
	during_music = true
	$"五线谱".modulate.a = 0
	$AnimationPlayer.play("提琴哥的旋律")
	Game.play_music_tiqingeshengqu()

func play_note(pitch: String, top_or_bottom: String, note_duration: float, harmful: bool):
	var note = preload("res://Assets/幽盲区/战斗场景/幽居提琴哥/流动音符.tscn").instantiate()
	var pos: Vector2
	note.note_duration = str(note_duration)
	note.top_or_bot = top_or_bottom
	match pitch:
		"do":
			if top_or_bottom == "top":
				pos = $"NotePosition/do(top)".global_position
			else:
				pos = $"NotePosition/do(bottom)".global_position
		"re":
			if top_or_bottom == "top":
				pos = $"NotePosition/re(top)".global_position
			else:
				pos = $"NotePosition/re(bottom)".global_position
		"mi":
			if top_or_bottom == "top":
				pos = $"NotePosition/mi(top)".global_position
			else:
				pos = $"NotePosition/mi(bottom)".global_position
		"fa":
			if top_or_bottom == "top":
				pos = $"NotePosition/fa(top)".global_position
			else:
				pos = $"NotePosition/fa(bottom)".global_position
		"so":
			if top_or_bottom == "top":
				pos = $"NotePosition/so(top)".global_position
			else:
				pos = $"NotePosition/so(bottom)".global_position
		"la":
			if top_or_bottom == "top":
				pos = $"NotePosition/la(top)".global_position
			else:
				pos = $"NotePosition/la(bottom)".global_position
		"ti":
			if top_or_bottom == "top":
				pos = $"NotePosition/ti(top)".global_position
			else:
				pos = $"NotePosition/ti(bottom)".global_position
		"do^1":
			if top_or_bottom == "top":
				pos = $"NotePosition/do^1(top)".global_position
			else:
				pos = $"NotePosition/do^1(bottom)".global_position
		"re^1":
			if top_or_bottom == "top":
				pos = $"NotePosition/re^1(top)".global_position
			else:
				pos = $"NotePosition/re^1(bottom)".global_position
		"mi^1":
			if top_or_bottom == "top":
				pos = $"NotePosition/mi^1(top)".global_position
			else:
				pos = $"NotePosition/mi^1(bottom)".global_position
		"fa^1":
			if top_or_bottom == "top":
				pos = $"NotePosition/fa^1(top)".global_position
			else:
				pos = $"NotePosition/fa^1(bottom)".global_position
		"so^1":
			if top_or_bottom == "top":
				pos = $"NotePosition/so^1(top)".global_position
			else:
				pos = $"NotePosition/so^1(bottom)".global_position
		"la^1":
			if top_or_bottom == "top":
				pos = $"NotePosition/la^1(top)".global_position
			else:
				pos = $"NotePosition/la^1(bottom)".global_position
		"ti^1":
			if top_or_bottom == "top":
				pos = $"NotePosition/ti^1(top)".global_position
			else:
				pos = $"NotePosition/ti^1(bottom)".global_position
		"do^2":
			if top_or_bottom == "top":
				pos = $"NotePosition/do^2(top)".global_position
			else:
				pos = $"NotePosition/do^2(bottom)".global_position
		"re^2":
			if top_or_bottom == "top":
				pos = $"NotePosition/re^2(top)".global_position
			else:
				pos = $"NotePosition/re^2(bottom)".global_position
		"mi^2":
			if top_or_bottom == "top":
				pos = $"NotePosition/mi^2(top)".global_position
			else:
				pos = $"NotePosition/mi^2(bottom)".global_position
		"fa^2":
			if top_or_bottom == "top":
				pos = $"NotePosition/fa^2(top)".global_position
			else:
				pass
	note.position = pos
	note.damage = harmful
	get_tree().current_scene.add_child(note)

func part_one_to_two_top():
	play_note("re^1", "top", 0.125, false)
	await get_tree().create_timer(0.375).timeout
	play_note("mi^1", "top", 0.125, false)
	await get_tree().create_timer(0.375).timeout
	play_note("fa^1", "top", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("so^1", "top", 0.125, false)
	await get_tree().create_timer(0.375).timeout
	play_note("la^1", "top", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("fa^1", "top", 0.125, false)
	await get_tree().create_timer(0.375).timeout
	play_note("mi^1", "top", 0.125, false)
	await get_tree().create_timer(0.375).timeout
	play_note("re^1", "top", 0.125, false)
	await get_tree().create_timer(0.375).timeout
	play_note("mi^1", "top", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("do^1", "top", 0.125, false)
	await get_tree().create_timer(0.375).timeout
	play_note("la", "top", 0.75, true)
	await get_tree().create_timer(2.25).timeout

func part_three_top():
	play_note("re^1", "top", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("mi^1", "top", 0.125, false)
	await get_tree().create_timer(0.375).timeout
	play_note("fa^1", "top", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("so^1", "top", 0.125, false)
	await get_tree().create_timer(0.375).timeout
	play_note("la^1", "top", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("fa^1", "top", 0.125, false)
	await get_tree().create_timer(0.375).timeout
	play_note("mi^1", "top", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("re^1", "top", 0.125, false)
	await get_tree().create_timer(0.375).timeout
	play_note("mi^1", "top", 0.125, false)
	await get_tree().create_timer(0.375).timeout
	play_note("la^1", "top", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("la^1", "top", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("mi^1", "top", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("do^1", "top", 0.25, true)
	await get_tree().create_timer(0.75).timeout
	play_note("la", "top", 0.25, true)
	await get_tree().create_timer(0.75).timeout

func part_four_top():
	play_note("ti", "top", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("re^1", "top", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("fa^1", "top", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("la^1", "top", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("do^2", "top", 0.25, true)
	await get_tree().create_timer(0.75).timeout
	play_note("ti^1", "top", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("la^1", "top", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("ti^1", "top", 1.0, true)
	await get_tree().create_timer(3).timeout
	
func part_fibe_and_seven_top():
	play_note("fa^1", "top", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("so^1", "top", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("la^1", "top", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("ti^1", "top", 0.125, false)
	await get_tree().create_timer(0.375).timeout
	play_note("do^2", "top", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("re^2", "top", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("ti^1", "top", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("re^2", "top", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("do^2", "top", 0.125, false)
	await get_tree().create_timer(0.375).timeout
	play_note("ti^1", "top", 0.125, false)
	await get_tree().create_timer(0.375).timeout
	play_note("la^1", "top", 0.75, true)
	await get_tree().create_timer(2.25).timeout

func part_six_top():
	play_note("fa^1", "top", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("so^1", "top", 0.125, false)
	await get_tree().create_timer(0.375).timeout
	play_note("la^1", "top", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("ti^1", "top", 0.125, false)
	await get_tree().create_timer(0.375).timeout
	play_note("do^2", "top", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("re^2", "top", 0.125, false)
	await get_tree().create_timer(0.375).timeout
	play_note("mi^2", "top", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("fa^2", "top", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("mi^2", "top", 0.125, false)
	await get_tree().create_timer(0.375).timeout
	play_note("do^2", "top", 0.125, false)
	await get_tree().create_timer(0.375).timeout
	play_note("la^1", "top", 0.75, true)
	await get_tree().create_timer(2.25).timeout

func part_eight_top():
	play_note("ti", "top", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("re^1", "top", 0.125, false)
	await get_tree().create_timer(0.375).timeout
	play_note("fa^1", "top", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("la^1", "top", 0.125, false)
	await get_tree().create_timer(0.375).timeout
	play_note("re^2", "top", 0.25, true)
	await get_tree().create_timer(0.75).timeout
	play_note("do^2", "top", 0.125, false)
	await get_tree().create_timer(0.375).timeout
	play_note("ti^1", "top", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("ti^1", "top", 1.0, true)
	await get_tree().create_timer(3).timeout

func bottom_first():
	play_note("do", "bottom", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("re", "bottom", 0.125, false)
	await get_tree().create_timer(0.375).timeout
	play_note("do", "bottom", 0.125, false)
	await get_tree().create_timer(0.375).timeout
	play_note("re", "bottom", 0.125, false)
	await get_tree().create_timer(0.375).timeout
	play_note("mi", "bottom", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("fa", "bottom", 0.125, false)
	await get_tree().create_timer(0.375).timeout
	play_note("re", "bottom", 0.125, false)
	await get_tree().create_timer(0.375).timeout
	play_note("do", "bottom", 0.125, false)
	await get_tree().create_timer(0.375).timeout
	play_note("mi", "bottom", 1.0, true)
	await get_tree().create_timer(3).timeout

func bottom_second():
	play_note("mi", "bottom", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("fa", "bottom", 0.125, false)
	await get_tree().create_timer(0.375).timeout
	play_note("mi", "bottom", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("fa", "bottom", 0.125, false)
	await get_tree().create_timer(0.375).timeout
	play_note("so", "bottom", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("la", "bottom", 0.125, false)
	await get_tree().create_timer(0.375).timeout
	play_note("mi", "bottom", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("re", "bottom", 0.125, false)
	await get_tree().create_timer(0.375).timeout
	play_note("mi", "bottom", 1.0, true)
	await get_tree().create_timer(3).timeout

func bottom_last():
	await get_tree().create_timer(1.5).timeout
	play_note("mi", "bottom", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("fa", "bottom", 0.125, false)
	await get_tree().create_timer(0.375).timeout
	play_note("mi", "bottom", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("so", "bottom", 0.125, false)
	await get_tree().create_timer(0.375).timeout

func bottom_start():
	play_note("fa", "bottom", 1.0, true)
	await get_tree().create_timer(3).timeout

func bottom_transist():
	await get_tree().create_timer(1.5).timeout
	play_note("mi", "bottom", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("fa", "bottom", 0.125, false)
	await get_tree().create_timer(0.375).timeout
	play_note("re", "bottom", 0.125, false)
	await get_tree().create_timer(0.375).timeout
	play_note("fa", "bottom", 0.125, true)
	await get_tree().create_timer(0.375).timeout

func bottom_climax_one():
	play_note("mi", "bottom", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("la", "bottom", 0.125, false)
	await get_tree().create_timer(0.375).timeout
	play_note("la", "bottom", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("mi", "bottom", 0.125, false)
	await get_tree().create_timer(0.375).timeout
	play_note("mi", "bottom", 0.125, false)
	await get_tree().create_timer(0.375).timeout
	play_note("do", "bottom", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("do", "bottom", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("mi", "bottom", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("fa", "bottom", 0.125, false)
	await get_tree().create_timer(0.375).timeout
	play_note("la", "bottom", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("la", "bottom", 0.125, false)
	await get_tree().create_timer(0.375).timeout
	play_note("fa", "bottom", 0.125, false)
	await get_tree().create_timer(0.375).timeout
	play_note("fa", "bottom", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("re", "bottom", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("re", "bottom", 0.125, false)
	await get_tree().create_timer(0.375).timeout
	play_note("fa", "bottom", 0.125, true)
	await get_tree().create_timer(0.375).timeout

func bottom_climax_two():
	play_note("fa", "bottom", 0.125, false)
	await get_tree().create_timer(0.375).timeout
	play_note("ti", "bottom", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("ti", "bottom", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("fa", "bottom", 0.125, false)
	await get_tree().create_timer(0.375).timeout
	play_note("fa", "bottom", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("re", "bottom", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("re", "bottom", 0.125, false)
	await get_tree().create_timer(0.375).timeout
	play_note("fa", "bottom", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("mi", "bottom", 0.125, false)
	await get_tree().create_timer(0.375).timeout
	play_note("ti", "bottom", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("ti", "bottom", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("mi", "bottom", 0.125, false)
	await get_tree().create_timer(0.375).timeout
	play_note("mi", "bottom", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("re", "bottom", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("re", "bottom", 0.125, false)
	await get_tree().create_timer(0.375).timeout
	play_note("mi", "bottom", 0.125, true)
	await get_tree().create_timer(0.375).timeout

func bottom_climax_three():
	play_note("mi", "bottom", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("do^1", "bottom", 0.125, false)
	await get_tree().create_timer(0.375).timeout
	play_note("do^1", "bottom", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("mi", "bottom", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("mi", "bottom", 0.125, false)
	await get_tree().create_timer(0.375).timeout
	play_note("re", "bottom", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("re", "bottom", 0.125, false)
	await get_tree().create_timer(0.375).timeout
	play_note("mi", "bottom", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("fa", "bottom", 0.125, false)
	await get_tree().create_timer(0.375).timeout
	play_note("re^1", "bottom", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("re^1", "bottom", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("fa", "bottom", 0.125, false)
	await get_tree().create_timer(0.375).timeout
	play_note("fa", "bottom", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("re", "bottom", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("re", "bottom", 0.125, false)
	await get_tree().create_timer(0.375).timeout
	play_note("ti", "bottom", 0.125, true)
	await get_tree().create_timer(0.375).timeout

func bottom_climax_four():
	play_note("ti", "bottom", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("mi^1", "bottom", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("mi^1", "bottom", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("ti", "bottom", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("ti", "bottom", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("mi", "bottom", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("mi", "bottom", 0.125, false)
	await get_tree().create_timer(0.375).timeout
	play_note("fa", "bottom", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("mi", "bottom", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("ti", "bottom", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("ti", "bottom", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("mi", "bottom", 0.125, false)
	await get_tree().create_timer(0.375).timeout
	play_note("mi", "bottom", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("la", "bottom", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("do^1", "bottom", 0.125, true)
	await get_tree().create_timer(0.375).timeout
	play_note("mi^1", "bottom", 0.125, true)
	await get_tree().create_timer(0.375).timeout

func _physics_process(delta: float) -> void:
	if during_music:
		if $"五线谱".modulate.a < 1:
			$"五线谱".modulate.a += 0.001
			world.environment.adjustment_contrast += 0.0005
			world.environment.adjustment_brightness -= 0.0005
			return
		else:
			$"五线谱".modulate.a = 1
			return
	else:
		if $"五线谱".modulate.a > 0:
			$"五线谱".modulate.a -= 0.001
			world.environment.adjustment_contrast -= 0.0005
			world.environment.adjustment_brightness += 0.0005
			return
		else:
			world.environment.adjustment_contrast = 1.0
			world.environment.adjustment_brightness = 1.0
			self.queue_free()

func music_done():
	during_music = false
