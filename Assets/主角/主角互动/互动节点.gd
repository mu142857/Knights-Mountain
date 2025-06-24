#class_name Interactable
extends Node2D

@export var type: String
# Teloport-场景间切换， Conditionedteloport-场景间按交互键切换， Talk-对话， Bridge-场景内直接传送， Bridgeport-场景内按交互键传送
@export var battle: bool
@export var place: String
## 剧情场景 peace
# Whisperwood-繁木林
# Hearthfall-村镇
# Shardcavern-晶石山洞
# Dreamwaste-空梦残乡
# Keepedge-城堡边境
## 战斗场景 battle
# Crimson_Gorge-赤火沟
# Goblinwood-哥布林森林
# Stair-阶梯
# Onyx_Grove-墨晶林
# Solo_Sonata-孤旋琴房
# Ashen_Hall-残灯棋坊
# Chestnut_Den-栗子窝

@export_file("*.tscn") var new_scene_path: String
@export var entry_point: String
@export var available: bool
var player_in: bool = false

var port_body # 为Bridgeport记录主角

func _ready() -> void:
	$CanvasLayer.hide()
	player_in = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and available:
		if type == "Talk":
			player_in = true
			$CanvasLayer.show()
		elif type == "Teloport":
			body.queue_free()
			Game.change_scene(new_scene_path, entry_point, battle)
		elif type == "Bridge":
			Game.change_pos(body, entry_point)
		elif type == "Bridgeport":
			player_in = true
			port_body = body
			$CanvasLayer.show()
		elif type == "Conditionedteloport":
			player_in = true
			port_body = body
			$CanvasLayer.show()


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		if type == "Talk":
			player_in = false
			$CanvasLayer.hide()
		elif type == "Bridgeport":
			player_in = false
			$CanvasLayer.hide()
		elif type == "Conditionedteloport":
			player_in = false
			$CanvasLayer.hide()

func _process(delta: float) -> void:
	if type == "Talk":
		if player_in and Input.is_action_just_pressed("interact"):
			pass
	elif type == "Bridgeport":
		if player_in and Input.is_action_just_pressed("interact"):
			Game.change_pos(port_body, entry_point)
	elif type == "Conditionedteloport":
		if player_in and Input.is_action_just_pressed("interact"):
			port_body.queue_free()
			Game.change_scene(new_scene_path, entry_point, battle)
