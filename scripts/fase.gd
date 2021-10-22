extends Node2D

const PRE_INIMIGO = preload("res://scenes/inimigo.tscn")
var enemyTimer = 0
var enemyTimerMax = 1

func _ready():
	pass

func _process(delta):
	enemyTimer += delta
	if enemyTimer > enemyTimerMax :
		spawnEnemy()
		enemyTimerMax = rand_range(0.5, 2)
		enemyTimer = 0

func spawnEnemy():
	var inimigo = PRE_INIMIGO.instance()
	inimigo.position = Vector2(rand_range(50, 480), -100)
	add_child(inimigo)
