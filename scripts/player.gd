extends KinematicBody2D

var speed = 400
const PRE_LASER = preload("res://scenes/laser.tscn")
const PRE_BILHO = preload("res://scenes/brilho.tscn")

var especial = false
var tempo_especial = 3

func _ready():
	pass

func _process(delta):
	var dir = Vector2.ZERO
	
	dir.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	dir.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	if self.position.x <= 42:
		self.position.x = 42
	if self.position.x >= 470:
		self.position.x = 470
	
	move_and_slide(dir * speed)
	
	if Input.is_action_just_pressed("shoot") and get_tree().get_nodes_in_group("laser").size() < 3:
		brilho($laserPosition.global_position)
		shootLaser()
	
	if especial:
		tempo_especial -= delta
		if tempo_especial <= 0:
			especial = false
			tempo_especial = 3
	
func shootLaser():
	var laser = PRE_LASER.instance()
#	laser.position = self.position + Vector2(0, -35)
#	laser.position = get_node("laserPosition").global_position
	laser.position = $laserPosition.global_position
	laser.add_to_group("laser")
	$"../".add_child(laser)

func brilho(pos):
	var brilho = PRE_BILHO.instance()
	brilho.position = pos
	get_parent().add_child(brilho)

func activate_special():
	especial = true
