extends Area2D

var vel = 300

func _ready():
	pass

func _process(delta):
	self.position.y += vel * delta
	
	if self.position.y > 850:
		queue_free()


func _on_inimigo_area_entered(area):
	if area.is_in_group("laser"):
		queue_free()
		area.queue_free()
