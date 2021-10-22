extends KinematicBody2D

var speed = 400
const PRE_LASER = preload("res://scenes/laser.tscn")

func _ready():
	pass

func _process(delta):
	var dir = Vector2.ZERO
	
#	if Input.is_action_pressed("left"):
#		dir.x = -1
#	if Input.is_action_pressed("right"):
#		dir.x = 1
#	if Input.is_action_pressed("up"):
#		dir.y = -1
#	if Input.is_action_pressed("down"):
#		dir.y = 1
	dir.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	dir.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	if self.position.x <= 42:
		self.position.x = 42
	if self.position.x >= 470:
		self.position.x = 470
	
	move_and_slide(dir * speed)
	
	if Input.is_action_just_pressed("shoot") and get_tree().get_nodes_in_group("laser").size() < 3:
		shootLaser()
	
func shootLaser():
	var laser = PRE_LASER.instance()
#	laser.position = self.position + Vector2(0, -35)
#	laser.position = get_node("laserPosition").global_position
	laser.position = $laserPosition.global_position
	laser.add_to_group("laser")
	$"../".add_child(laser)
