extends Control


func _ready():
	# Getting keyboard focus on startup
	$VBoxContainer/Button.grab_focus()


func _on_Button_pressed():
	# Starts the game scene
	var _change = get_tree().change_scene("res://Game.tscn")


func _on_Button2_pressed():
	# Quits game
	get_tree().quit()
