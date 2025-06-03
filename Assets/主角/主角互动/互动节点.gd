#class_name Interactable
extends Node2D

@export var type: String
# Teloport-场景切换， Talk-对话
@export var place: String
## 剧情场景
# Whisperwood-繁木林
# Hearthfall-村镇
# Shardcavern-晶石山洞
# Dreamwaste-空梦残乡
# Keepedge-城堡边境
## 战斗场景
# Crimson_Gorge-赤火沟
# Goblinwood-哥布林森林
# Stair-阶梯
# Onyx_Grove-墨晶林
# Solo_Sonata-孤旋琴房
# Ashen_Hall-残灯棋坊
# Chestnut_Den-栗子窝
@export_file("*.tscn") var new_scene_path: String
@export var entry_point: String
var player_in: bool = false

func _ready() -> void:
	$CanvasLayer.hide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if type == "Talk":
			player_in = true
			$CanvasLayer.show()
		else:
			body.queue_free()
			Game.change_scene(new_scene_path, entry_point)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		if type == "Talk":
			player_in = false
			$CanvasLayer.hide()

func _process(delta: float) -> void:
	if player_in and Input.is_action_just_pressed("interact"):
		Game.change_scene(new_scene_path, entry_point)
