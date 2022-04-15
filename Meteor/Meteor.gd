extends KinematicBody2D

const explosion_particle = preload("res://Meteor/MeteorExplosion.tscn")

var types = [0, 1, 2, 3]
var spawn_position
var move_to


func _ready():
	# Select a random type and set the collision shape
	randomize()
	var type = randi() % types.size()
	$CollisionShape2D/AnimatedSprite.frame = type
	$CollisionShape2D.shape = $CollisionShape2D.shape.duplicate()
	$CollisionShape2D.shape.extents = $CollisionShape2D/AnimatedSprite.frames.get_frame("default", type).get_size()/2


func _physics_process(delta):
	# Stops the meteor on game over
	if get_node("/root/Game/Player").game_over:
		set_physics_process(false)

	# Moves towards the player
	var collision = move_and_collide((move_to - spawn_position).normalized() * delta * 150)

	if collision:
		# If collides with another meteor
		if "Meteor" in collision.collider.name:
			explode()
			self.queue_free()
			collision.collider.queue_free()
			

func explode():
	# Creates the particles
	var explosion = explosion_particle.instance()
	explosion.position = self.position
	explosion.emitting = true
	get_tree().get_root().add_child(explosion)
