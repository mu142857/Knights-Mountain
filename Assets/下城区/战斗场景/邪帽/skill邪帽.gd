extends Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."

var skill_ready: bool = true
@export var skill_cooldown: float = 0.1
@export var number_of_skills: int = 1
var skills_count: int = 0

var change_timer_started:bool = false

func enter():
	#Game.shake_camera(30)
	#Game.flash(1.1, Color(0.6, 0.6, 0.6))
	change_timer_started = false
	if monster.health >= 1500:
		number_of_skills = 3
	elif monster.health >= 1000:
		number_of_skills = 5
	elif monster.health >= 500:
		number_of_skills = 7
	elif monster.health >= 0:
		number_of_skills = 9
		
	skills_count = 0
	ani_2D.play("SkillLoop")

func process():
	if skill_ready and skills_count < number_of_skills:
		test_skill()
	elif skills_count >= number_of_skills and !change_timer_started:
		change_timer_started = true
		var cooldown = monster.health / 1500
		$ChangerTimer.start(1.5 + cooldown)

func exit():
	pass

func test_skill():
	skill_ready = false
	var cooldown = monster.health / 2100
	$Timer.start(skill_cooldown + cooldown)
	skills_count += 1
	var sce1 = preload("res://Assets/幻乡/战斗场景/哥布林火焰兵/哥布林火球.tscn").instantiate()
	sce1.setup(monster.global_position - Vector2(0, 100), false, 840)
	monster.get_parent().add_child(sce1)
	var sce2 = preload("res://Assets/幻乡/战斗场景/哥布林火焰兵/哥布林火球.tscn").instantiate()
	sce2.setup(monster.global_position - Vector2(0, 100), true, 840)
	monster.get_parent().add_child(sce2)

func _on_timer_timeout() -> void:
	skill_ready = true

func _on_changer_timer_timeout() -> void:
	get_parent().change_state(5)
