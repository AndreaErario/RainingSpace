extends Label

var counter = 0
var best


func _ready():
	# Reads the value
	var file = File.new()
	file.open("user://best.txt", File.READ)
	best = file.get_line()
	if not best:
		best = 0
	self.text = "Current: " + str(counter) + "\nBest: " + str(best)
	file.close()


func _on_Laser_meteor_destroied():
	# Updates the value
	counter += 1
	if counter > int(best):
		best = counter
		var file = File.new()
		file.open("user://best.txt", File.WRITE)
		file.store_string(str(best))
	self.text = "Current: " + str(counter) + "\nBest: " + str(best)
