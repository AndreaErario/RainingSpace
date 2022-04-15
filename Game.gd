extends Node

const meteor_path = preload("res://Meteor/Meteor.tscn")
const explosion_particle = preload("res://Meteor/MeteorExplosion.tscn")


func _ready():
	# Removes lasers from previous game
	get_tree().call_group("lasers","queue_free")
	# Adds a non visible explosion to avoid lag
	var explosion = explosion_particle.instance()
	explosion.position = Vector2(0, -200)
	explosion.emitting = true
	get_tree().get_root().add_child(explosion)


func _process(_delta):
	randomize()
	# Spawns a meteor directed to player 
	if $MeteorTimer.time_left == 0 and not $Player.game_over:
		$MeteorSpawn/Location.offset = randi()
		var meteor = meteor_path.instance()
		meteor.position = $MeteorSpawn/Location.position
		meteor.spawn_position = meteor.position
		meteor.move_to = $Player.position
		self.add_child(meteor)
		$MeteorTimer.start()
