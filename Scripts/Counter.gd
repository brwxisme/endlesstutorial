extends Control

var enemyKilled = 0

func _enter_tree():
	enemyKilled = 0
	$Label.text = str(enemyKilled)
	GameLibrary.enemyKilled.connect(_addCounter)


func _addCounter():
	enemyKilled +=1
	$Label.text = str(enemyKilled)
