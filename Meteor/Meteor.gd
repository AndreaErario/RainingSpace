extends KinematicBody2D

const explosion_particle = preload("res://Meteor/MeteorExplosion.tscn")

var types = [0, 1, 2, 3]
var polygons = [
	PoolVector2Array(
		[Vector2(-33, -40), Vector2(23, -40), 
		Vector2(49, -1), Vector2(34, 32), 
		Vector2(10, 29), Vector2(-21, 40), Vector2(-49, 10)]
	), 
	PoolVector2Array(
		[Vector2(7, -48), Vector2(59, -29), 
		Vector2(45, 18), Vector2(-8, 32), 
		Vector2(-26, 48), Vector2(-53, 26), 
		Vector2(-59, -6), Vector2(-39, -40)]
	), 
	PoolVector2Array(
		[Vector2(-10, -39), Vector2(28, -27), 
		Vector2(43, 0), Vector2(20, 40), 
		Vector2(-27, 32), Vector2(-41, 14), Vector2(-43, -18)]
	), 
	PoolVector2Array(
		[Vector2(16, -45), Vector2(47, -12), 
		Vector2(29, 41), Vector2(-19, 45), 
		Vector2(-47, 10), Vector2(-34, -32)]
	)
]
var spawn_position
var move_to


func _ready():
	# Select a random type and set the collision shape
	randomize()
	var type = randi() % types.size()
	$CollisionPolygon2D/AnimatedSprite.frame = type
	$CollisionPolygon2D.set_polygon(polygons[type])


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
