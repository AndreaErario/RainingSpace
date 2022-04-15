extends KinematicBody2D

const laser_path = preload("res://Player/Laser/Laser.tscn")
const end = preload("res://Menus/End/EndMenu.tscn")

var game_over = false
	
func _physics_process(delta):
	# Player movement
	var velocity = Vector2()
	var speed = 300

	if Input.is_action_pressed("ui_up") and self.position.y > $CollisionShape2D/Sprite.texture.get_height()/2:
		velocity.y = -1 
	if Input.is_action_pressed("ui_left") and self.position.x > $CollisionShape2D/Sprite.texture.get_width()/2:
		velocity.x = -1
	if Input.is_action_pressed("ui_down") and self.position.y < OS.window_size.y - $CollisionShape2D/Sprite.texture.get_height()/2:
		velocity.y = 1
	if Input.is_action_pressed("ui_right") and self.position.x < OS.window_size.x - $CollisionShape2D/Sprite.texture.get_width()/2:
		velocity.x = 1 
	
	var collision = move_and_collide(velocity.normalized() * speed * delta)

	if collision:
		if "Meteor" in collision.collider.name:
			set_physics_process(false)
			game_over = true
			
	if game_over:
		var end_win = end.instance()
		get_tree().get_root().add_child(end_win)
		
	# Shooting
	if Input.is_action_pressed("ui_accept") and $ReloadTimer.time_left == 0:
		$ReloadTimer.start()
		shoot()


func shoot():
	# Creates two lasers on set positions
	var laser = laser_path.instance()
	var laser1 = laser_path.instance()
	get_tree().get_root().add_child(laser)
	get_tree().get_root().add_child(laser1)
	laser.position = $LaserPosition.global_position
	laser1.position = $Laser1Position.global_position
	laser.connect("meteor_destroyed", get_node("/root/Game/CanvasLayer/PointsLabel"), "_on_Laser_meteor_destroied")
	laser1.connect("meteor_destroyed", get_node("/root/Game/CanvasLayer/PointsLabel"), "_on_Laser_meteor_destroied")
