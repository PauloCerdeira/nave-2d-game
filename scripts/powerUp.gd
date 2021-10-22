extends Area2D
var vel = 100

func _ready():
	pass
	
func _process(delta):
	self.position.y += vel * delta
	if self.position.y > 850:
		queue_free()


func _on_powerUp_body_entered(body):
	body.activate_special()
	queue_free()
