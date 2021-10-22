extends Node2D

const PRE_INIMIGO = preload("res://scenes/inimigo.tscn")
var enemyTimer = 0
var enemyTimerMax = 1

const PRE_POWERUP = preload("res://scenes/powerUp.tscn")
var powerUpTimer = 0
var powerUpTimerMax = 7 

func _ready():
	randomize()
	pass

func _process(delta):
	enemyTimer += delta
	if enemyTimer > enemyTimerMax :
		spawnEnemy()
		enemyTimerMax = rand_range(0.5, 2)
		enemyTimer = 0
	
	powerUpTimer += delta
	if powerUpTimer > powerUpTimerMax:
		spawnPowerUp()
		powerUpTimerMax = int(rand_range(7,10))
		powerUpTimer = 0

func spawnEnemy():
	var inimigo = PRE_INIMIGO.instance()
	inimigo.position = Vector2(rand_range(50, 480), -100)
	add_child(inimigo)
	
func spawnPowerUp():
	var powerUp = PRE_POWERUP.instance()
	powerUp.position = Vector2(rand_range(50, 480), -100)
	add_child(powerUp)
