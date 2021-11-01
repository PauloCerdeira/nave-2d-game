extends AnimatedSprite


func _ready():
	$sound.pitch_scale = rand_range(1.5, 3)
	self.play("explosao")

func _on_sound_finished():
	self.queue_free()
