extends AnimatedSprite


func _ready():
	self.play("explosao")
	pass


func _on_exploso_animation_finished():
	self.queue_free()
