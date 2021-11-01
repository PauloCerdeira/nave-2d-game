extends KinematicBody2D

var speed = 400
const PRE_EXPLOSAO = preload("res://scenes/explosão.tscn")
const PRE_LASER = preload("res://scenes/laser.tscn")
const PRE_BILHO = preload("res://scenes/brilho.tscn")

var vidas = 3
var especial = false
var blinking = false
var tempo_blink = 0
var tempo_especial = 5
var tempo_laser = 0
var tempo_movimento = 0
var controlar_player = false
onready var pos_inicial = self.global_position

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
	if self.position.y <= 20:
		self.position.y = 20
	if self.position.y >= 760 and controlar_player:
		self.position.y = 760
	
	
	if controlar_player:
		move_and_slide(dir * speed)
		
		if Input.is_action_just_pressed("shoot") and get_tree().get_nodes_in_group("laser").size() < 3:
			brilho($laserPosition.global_position)
			shootLaser(1)
	
	else:
		self.position.y -= 200 * delta
		tempo_movimento += delta
		if tempo_movimento > 1:
			controlar_player = true
			tempo_movimento = 0
	
	if especial:
		tempo_especial -= delta
		tempo_laser += delta
		if tempo_laser > 0.15:			
			shootLaser(2)
			shootLaser(3)
			brilho($leftLaserPosition.global_position)
			brilho($rightLaserPosition.global_position)
			tempo_laser = 0
		if tempo_especial <= 0:
			especial = false
			tempo_especial = 5
	
	if blinking:
		tempo_blink += delta
		if tempo_blink > 0.3:
			self.visible = !self.visible
			tempo_blink = 0
		
func shootLaser(tipo):
	$laserSound.play()
	var laser = PRE_LASER.instance()
#	laser.position = self.position + Vector2(0, -35)
#	laser.position = get_node("laserPosition").global_position
	if tipo == 1:
		laser.position = $laserPosition.global_position
		laser.add_to_group("laser")
	elif tipo == 2:
		laser.position = $leftLaserPosition.global_position
		laser.add_to_group("especial")
		laser.scale *= 0.5
	else:
		laser.position = $rightLaserPosition.global_position
		laser.add_to_group("especial")
		laser.scale = Vector2(0.5,0.5)
	$"../".add_child(laser)

func brilho(pos):
	var brilho = PRE_BILHO.instance()
	brilho.position = pos
	get_parent().add_child(brilho)

func activate_special():
	$pwSound.play()
	if especial:
		tempo_especial = 5
	especial = true

func death():
	vidas -= 1
	var explosao = PRE_EXPLOSAO.instance()
	explosao.position = self.global_position
	get_parent().add_child(explosao)
	
	self.position = pos_inicial
	if vidas >= 0:
		especial = false
		blinking = true
		controlar_player = false
		$blinkingTimer.start()
		get_parent().get_node("vidas/Label").text = str(vidas) + "x"
	else:
		get_parent().gameOver()
		self.queue_free()
		
	
func _on_blinkingTimer_timeout():
	blinking = false
	self.visible = true
	
