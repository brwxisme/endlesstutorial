extends CharacterBody2D

var myRes : HeroResource = preload("res://Resources/Heroes/Knight.tres")

var speed :float = 200
var animState : String = ""
var direction : Vector2 = Vector2(0,0)
var lastX = 0
var HPbar : TextureProgressBar
var weapons
var HP = 100

var DamageResist = 0.0
var DamageMultiplier = 0.0
var CooldownReduce = 0.0


func _enter_tree():
	myRes = GameLibrary.heroes[GameLibrary.choosenHero]
	self[myRes.Special] = myRes.Value
	$Sprite.texture = myRes.Sprite
	HP = myRes.HP
	speed = myRes.MS
	
	
	var mainHand : Weapon = GameLibrary.weapons[GameLibrary.mainHand].instantiate()
	mainHand.parentNode = self
	mainHand.handPosition = "Main"
	mainHand.Damage *= 5
	$Sprite/Hands/MainHand.add_child(mainHand)
	var offHand : Weapon = GameLibrary.weapons[GameLibrary.offHand].instantiate()
	offHand.parentNode = self 
	offHand.handPosition = "Offhand"
	offHand.Damage *= 5
	$Sprite/Hands/Offhand.add_child(offHand)

func _ready():
	HPbar = get_tree().current_scene.get_node("CanvasLayer/PlayerHP/HPBar")
	HPbar.max_value = HP
	HPbar.value = HP
	pass
	  
	
func _process(delta):
	direction.x = Input.get_axis("ui_left","ui_right")
	direction.y = Input.get_axis("ui_up","ui_down")
	
	direction = direction.normalized()
	
	if direction != Vector2(0,0):
		lastX = direction.x
		$AnimationPlayer.play("walk")
		animState = "walk"
		var pepe = delta*speed*direction
		#position += pepe
		move_and_collide(pepe)
		
	else:
		$AnimationPlayer.play("idle")
		animState = "idle"
	
	
	rotateSprite()
	


func rotateSprite():
	if position.direction_to(get_global_mouse_position()).x <0:
		$Sprite.scale.x = -1
	else:
		$Sprite.scale.x = 1
	#print(global_position.direction_to(get_global_mouse_position()).x)
	$Sprite/Hands/MainHand.look_at(get_global_mouse_position())
	$Sprite/Hands/Offhand.look_at(get_global_mouse_position())

func _takeDamage(dmg:int):
	dmg -=DamageResist*dmg
	HP -= dmg
	HPbar.value = HP
	print("player take DMG ",dmg)
	
	if HP<=0:
		#call_deferred("queue_free")
		#get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
		queue_free()
		
		GameLibrary.playerKilled.emit()
		#get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
