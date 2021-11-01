extends Node2D

var isGameOver = false

const PRE_INIMIGO = preload("res://scenes/inimigo.tscn")
var enemyTimer = 0
var enemyTimerMax = 0.5

const PRE_POWERUP = preload("res://scenes/powerUp.tscn")
var powerUpTimer = 0
var powerUpTimerMax = 18

var tempo_restante = 15
var tempo_cooldown = 0
var tempo_multiplier = 1.0

var ondaCounter = 1

var score = 0
var addScore = false

func _ready():
	randomize()
	pass

func _process(delta):
	$tempo.text = "Tempo restante: " + str(int(tempo_restante))
	$pontosLabel.text = "Pontos: " + str(score)
	$ondaLabel.text = ""
	
	if !isGameOver:
		if tempo_restante > 0:
			addScore =  true
			tempo_restante -= delta
			enemyTimer += delta * (tempo_multiplier * 1.5)
			if enemyTimer > enemyTimerMax :
				spawnEnemy()
				enemyTimerMax = rand_range(enemyTimerMax, enemyTimerMax + 0.5)
				enemyTimer = 0
		else:
			$tempo.text = ""
			$ondaLabel.text = "Onda " + str(ondaCounter) + " Completa!"
			if addScore:
				score += 1000 * (tempo_multiplier / 2)
				addScore = false
			
			tempo_cooldown += delta
			if tempo_cooldown > 3:
				ondaCounter += 1
				tempo_cooldown = 0
				tempo_multiplier = tempo_multiplier + ondaCounter
				tempo_restante = 15
		powerUpTimer += delta
		if powerUpTimer > powerUpTimerMax:
			spawnPowerUp()
			powerUpTimerMax = int(rand_range(powerUpTimerMax,powerUpTimerMax + 10))
			powerUpTimer = 0
	else:
		if Input.is_action_just_pressed("reset"):
			get_tree().change_scene("res://scenes/fase.tscn")

func spawnEnemy():
	var inimigo = PRE_INIMIGO.instance()
	inimigo.position = Vector2(rand_range(50, 480), -100)
	add_child(inimigo)
	
func spawnPowerUp():
	var powerUp = PRE_POWERUP.instance()
	powerUp.position = Vector2(rand_range(50, 480), -100)
	add_child(powerUp)

func gameOver():
	$AnimationPlayer.stop()
	$tempo.visible = false
	$gameOverLabel.visible =  true
	isGameOver = true
	
