extends Area2D

var speed = 650

func _ready():
	pass

func _process(delta):
	self.position.y -= speed * delta
	
	if self.position.y < -50:
		self.queue_free()
