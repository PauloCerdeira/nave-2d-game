extends Sprite


func _ready():
	$AnimationPlayer.play("brilho")
	$AnimationPlayer.connect("animation_finished", self, "destruir")

func destruir(_obj):
	queue_free()
