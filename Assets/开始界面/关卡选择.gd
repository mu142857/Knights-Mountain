extends Node2D

# 场景特效
var pier_chandelier: float = 0.20
var pier_chandelier_is_fading: bool = false
var volcano_crater: float = 0.20
var volcano_crater_is_fading: bool = false

# 鼠标是否可以选择
var mouse_ready: float = false

# 场景切换变量
var worlds_array: Array = []
var worlds_selection: int = 1
@export var day_and_night: int = 1

# 标题
@onready var title : Label = $"CanvasLayer/大标题"
@onready var battle1 : Label = $"CanvasLayer/关卡1标题"
@onready var battle2 : Label = $"CanvasLayer/关卡2标题"
@onready var battle_title : Label = $"CanvasLayer/战斗关卡"
var title_array: Array = ["", "旅途", "闭锁寂塔", "荆棘城", "孤舟", "幻乡", "归鸿丘", "奥斯卡号", "下城"]
var battle1_array: Array = ["", "→第一关", "→锻钢堡", "→落榕聚", "→渔人港", "→赤火沟", "→平山坜", "→奥斯卡舱", "→破巷街"]
var battle2_array: Array = ["", "→第二关", "→金钟关", "→苍木城", "→汪粼渊", "→明灯堡", "→四方坛", "→纯粹舱", "→残灯坊"]
var current_title = 0

func _ready() -> void:
	$"开始时渐变".modulate.a = 1.0
	title.text = "旅途"
	battle1.text = "第一关"
	battle2.text = "第二关"
	worlds_array = $"关卡".get_children()
	for i in range(9):
		worlds_array[i].modulate.a = 0.0
	worlds_array[worlds_selection].modulate.a = 1.0
	
	mouse_ready = false

func _process(delta: float) -> void:
	
	if $"开始时渐变".modulate.a <= 0.0:
		mouse_ready = true # 当开始渐变消失后，鼠标可以使用

func _physics_process(delta: float) -> void:

	pier_chandelier_process()
	volcano_crater_process()
	
	if $"开始时渐变".modulate.a >= 0.0: # 开始时黑色图片渐变，逐渐变透明
		$"开始时渐变".modulate.a -= 0.03

	if worlds_array[worlds_selection].modulate.a < 1 : # 关卡切换
		worlds_array[worlds_selection].modulate.a += 0.05
		for i in range(9):
			if worlds_array[i].modulate.a > 0.0 and i != worlds_selection:
				worlds_array[i].modulate.a -= 0.3
			
	if current_title != worlds_selection: # 标题切换		
		if battle1.modulate.a <= 0:
			set_title()
		else:
			title.modulate.a -= 0.3
			battle1.modulate.a -= 0.3
			battle2.modulate.a -= 0.3
			battle_title.modulate.a -= 0.3
				
	elif current_title == worlds_selection and title.modulate.a <= 1:
		title.modulate.a += 0.05
		battle1.modulate.a += 0.05
		battle2.modulate.a += 0.05
		battle_title.modulate.a += 0.05
	
func pier_chandelier_process(): # 灯塔亮度变化
	
	$"灯光/灯塔".energy = pier_chandelier

	if pier_chandelier >= 1.2:
		pier_chandelier_is_fading = true
	elif pier_chandelier <= 0.2:
		pier_chandelier_is_fading = false
	
	if !pier_chandelier_is_fading:
		pier_chandelier += 0.01
	elif pier_chandelier_is_fading:
		pier_chandelier -= 0.01
	
func volcano_crater_process(): # 火山口亮度变化
	
	$"灯光/火山口".energy = volcano_crater
	
	if volcano_crater >= 2.5:
		volcano_crater = 2.5
		volcano_crater_is_fading = true
	elif volcano_crater <= 0.5:
		volcano_crater = 0.5
		volcano_crater_is_fading = false
	
	if !volcano_crater_is_fading:
		volcano_crater += randf_range(-0.045, 0.15)
	elif volcano_crater_is_fading:
		volcano_crater -= randf_range(-0.015, 0.03)
		
func toggle_selection(final: int):
	worlds_selection = final
		
func _on_下城_mouse_entered() -> void:
	if mouse_ready:
		toggle_selection(8)

func _on_金_mouse_entered() -> void:
	if mouse_ready:
		toggle_selection(2)

func _on_木_mouse_entered() -> void:
	if mouse_ready:
		toggle_selection(3)

func _on_水_mouse_entered() -> void:
	if mouse_ready:
		toggle_selection(4)

func _on_火_mouse_entered() -> void:
	if mouse_ready:
		toggle_selection(5)

func _on_土_mouse_entered() -> void:
	if mouse_ready:
		toggle_selection(6)

func _on_飞艇_mouse_entered() -> void:
	if mouse_ready:
		toggle_selection(7)

func _on_其他_mouse_entered() -> void:
	if mouse_ready:
		toggle_selection(day_and_night)

func set_title(): # 设置标题文字
	title.text = title_array[worlds_selection]
	battle1.text = battle1_array[worlds_selection]
	battle2.text = battle2_array[worlds_selection]
	current_title = worlds_selection
