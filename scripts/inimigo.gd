extends Area2D

var vel = 300
const PRE_EXPLOSAO = preload("res://scenes/explosão.tscn")

func _ready():
	pass

func _process(delta):
	self.position.y += vel * delta
	
	if self.position.y > 850:
		queue_free()


func _on_inimigo_area_entered(area):
	if area.is_in_group("laser") or area.is_in_group("especial"):
		get_parent().score += 50
		explode()
		queue_free()
		area.queue_free()

func explode():
	var explosao = PRE_EXPLOSAO.instance()
	explosao.position = self.position
	get_parent().add_child(explosao)


func _on_inimigo_body_entered(body):
	if !body.blinking:
		body.death()
		self.queue_free()
