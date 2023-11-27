extends Node2D

func _ready():
	
	Utils.loadGame()
	if Game.playerHP <=0:
		Game.playerHP = 10
		Game.playerGold = 0
		Game.playerXP = 0

func _on_button_2_pressed():
	get_tree().quit()


func _on_btn_play_pressed():
	get_tree().change_scene_to_file("res://world.tscn")
