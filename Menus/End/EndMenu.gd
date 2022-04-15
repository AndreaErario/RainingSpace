extends Control


func _ready():
	# Getting keyboard focus on startup
	$VBoxContainer/Button.grab_focus()


func _on_Button_pressed():
	# Returns to game scene
	var _change = get_tree().change_scene("res://Game.tscn")
	self.queue_free()


func _on_Button2_pressed():
	# Quits game
	get_tree().quit()
