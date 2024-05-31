extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	GameLibrary.playerKilled.connect(_backToMain)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _backToMain():
	await get_tree().create_timer(1).timeout
	#get_tree().change_scene_to_file("res://Scenes/main.tscn")
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
