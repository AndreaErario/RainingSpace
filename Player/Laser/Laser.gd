extends KinematicBody2D

var velocity = Vector2(1, 0)
var speed = 600

signal meteor_destroyed

func _physics_process(delta):
	# Stops the laser on game over
	if get_node("/root/Game/Player").game_over:
		set_physics_process(false)

	# Collisions
	var collision = move_and_collide(velocity.normalized() * delta * speed)

	if collision:
		if "Meteor" in collision.collider.name:
			collision.collider.explode()
			self.queue_free()
			collision.collider.queue_free()
			emit_signal("meteor_destroyed")

	# If laser goes out of the screen
	if self.position.x > OS.window_size.x:
		self.queue_free()
