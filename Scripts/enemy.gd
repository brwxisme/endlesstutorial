extends CharacterBody2D

var myRes : EnemyResource = preload("res://Resources/Enemies/Warrior.tres")
var speed :float = 100
var animState : String = ""
var direction : Vector2 = Vector2(0,0)
var myWeaponName 
var lastX = 0
var player = null
var weapon :Weapon
var isAttacking = false
var HP : int = 100
var attackDistance = 30


func _ready():
	player = get_tree().current_scene.get_node("Player")
	speed = myRes.MS
	HP = myRes.HP
	$Sprite.texture = myRes.Sprite
	if myRes.WeaponName == "Random":
		myWeaponName = GameLibrary.weapons.keys().pick_random()
	else:
		myWeaponName = myRes.WeaponName
	
	if myWeaponName == "Staff":
		attackDistance = 200
	_spawnWeapon()
	
	$HP/HPBar.max_value = HP
	$HP/HPBar.value = HP
	pass
	  
	
func _process(delta):
	if player == null || isAttacking : return
	
	
	direction = global_position.direction_to(player.global_position)
	direction = direction.normalized()
	
	if direction != Vector2(0,0) :
		lastX = direction.x
		$AnimationPlayer.play("walk")
		animState = "walk"
		var pepe = delta*speed*direction
		move_and_collide(pepe)
		
	else:
		$AnimationPlayer.play("idle")
		animState = "idle"
	
	
	rotateSprite()
	
	if global_position.distance_to(player.global_position) < attackDistance:
		_makeAttack()

func _makeAttack():
	isAttacking = true
	$AnimationPlayer.play("idle")
	weapon._attack()
	await get_tree().create_timer(2).timeout
	isAttacking = false


func rotateSprite():
	if global_position.direction_to(player.global_position).x < 0 :
		$Sprite.scale.x = -1
	else:
		$Sprite.scale.x = 1
	$Sprite/Hands/MainHand.look_at(player.global_position)

func _knockBack():
	var knockDirection = global_position.direction_to(player.global_position)
	knockDirection *= -1
	var knock = 25*knockDirection
	position += knock
	$Sprite.modulate.r = 100
	await get_tree().create_timer(0.25).timeout
	$Sprite.modulate.r = 1

func _takeDamage(dmg:int):
	HP-=dmg
	
	$HP/HPBar.value = HP
	if HP <=0:
		
		player = null
		$AnimationPlayer.play("death")
		await $AnimationPlayer.animation_finished
		queue_free()
	else:
		_knockBack()

func _spawnWeapon():
	weapon = GameLibrary.weapons[myWeaponName].instantiate()
	weapon.isEnemyWeapon = true
	weapon.parentNode = self
	weapon.handPosition = "404"
	
	$Sprite/Hands/MainHand.add_child(weapon)


func _exit_tree():
	GameLibrary.enemyKilled.emit()
	pass
