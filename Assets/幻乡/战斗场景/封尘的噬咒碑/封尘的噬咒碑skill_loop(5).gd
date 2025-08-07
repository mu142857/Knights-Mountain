extends Basic_State #5

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."
@onready var detection_range: Area2D = $"../../PlayerCheck" # 寻找玩家的范围extends Node

var lizi = preload("res://Assets/幻乡/战斗场景/封尘的噬咒碑/神秘文字.tscn")

func enter() -> void:
	ani_2D.play("Skill")
