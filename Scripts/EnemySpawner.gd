extends Node2D

var enemyList : Array
var enemyScene  = preload("res://Characters/enemy.tscn")
var spawnRate : float = 3
var spawnTimer
var topLeft
var botRight
var spawningEnemy = true

func _ready():
	topLeft = $SpawnLimit/TopLeft.position
	botRight = $SpawnLimit/BotRight.position
	enemyList = GameLibrary.enemies.keys()
	spawnTimer = spawnRate
	GameLibrary.playerKilled.connect(func():spawningEnemy=false)

func _process(delta):
	if !spawningEnemy:return
	if spawnTimer > 0:
		spawnTimer -=delta
	else:
		spawnTimer = spawnRate
		_spawnNewEnemy()
		
		

func _spawnNewEnemy():
	
	var enemyRes = enemyList.pick_random()
	var newEnemy = enemyScene.instantiate()
	newEnemy.myRes = GameLibrary.enemies[enemyRes]
	
	newEnemy.position = Vector2(randi_range(topLeft.x,botRight.x),
	randi_range(topLeft.y,botRight.y))
	
	add_child(newEnemy)
