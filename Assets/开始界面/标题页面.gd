extends Node2D

signal game_start

@onready var start_button : Sprite2D = $"按钮背景/开始Sprite2D"
@onready var jiamu_button : Sprite2D = $"按钮背景/人员Sprite2D"
@onready var exit_button : Sprite2D = $"按钮背景/退出Sprite2D"

var start_transition: bool = false

func _ready() -> void:
	$CanvasModulate.color = Color(1, 1, 1, 1)
	$"CanvasLayer/大标题".modulate = Color(1, 1, 1, 1)
	start_button.modulate = Color(0, 0.5, 1, 1)
	jiamu_button.modulate = Color(0, 0.5, 1, 1)
	exit_button.modulate = Color(0, 0.5, 1, 1)

func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	if start_transition:
		$CanvasModulate.color -= Color(0.03, 0.01, 0.01, 0)
		$"CanvasLayer/大标题".modulate -= Color(0, 0, 0, 0.025)
	if $CanvasModulate.color.b <= 0:
		#var level_selection_page = preload("res://Assets/开始界面/关卡选择.tscn").instantiate()
		#var level_selection_page = preload("res://Assets/下城区/孤弦琴房.tscn").instantiate()
		#var level_selection_page = preload("res://Assets/下城区/孤弦琴房.tscn").instantiate()
		#var level_selection_page = preload("res://Assets/幻乡/哥布林遭遇战.tscn").instantiate()
		var level_selection_page = preload("res://Assets/幻乡/繁木林.tscn").instantiate()
		get_tree().current_scene.add_child(level_selection_page)
		self.queue_free()

func _on_开始按钮判定_mouse_entered() -> void:
	start_button.modulate = Color(2, 0, -1, 1)

func _on_人员按钮判定_mouse_entered() -> void:
	jiamu_button.modulate = Color(1, 0.5, -1, 1)

func _on_退出游戏判定_mouse_entered() -> void:
	exit_button.modulate = Color(2.75, 0.5, -2, 1)

func _on_开始按钮判定_mouse_exited() -> void:
	start_button.modulate = Color(0, 0.5, 1, 1)

func _on_人员按钮判定_mouse_exited() -> void:
	jiamu_button.modulate = Color(0, 0.5, 1, 1)

func _on_退出游戏判定_mouse_exited() -> void:
	exit_button.modulate = Color(0, 0.5, 1, 1)

func _on_开始游戏_pressed() -> void:
	emit_signal("game_start")
	$"CanvasLayer/开始游戏".hide()
	$"CanvasLayer/人员名单".hide()
	$"CanvasLayer/退出游戏".hide()
	start_transition = true

func _on_人员名单_pressed() -> void:
	pass

func _on_退出游戏_pressed() -> void:
	get_tree().quit()
