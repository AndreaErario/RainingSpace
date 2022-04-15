extends ParallaxBackground

var speed = 200


func _process(delta):
	# Moves the background
	if get_node("/root/Game/Player").game_over:
		speed = 0
	self.scroll_offset.x -= speed * delta
