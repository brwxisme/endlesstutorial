extends Node2D
class_name Weapon
var animPlayer
@export var parentNode : Node2D
var weaponType = "Melee"
var handPosition = ""
var trigger = ""
var weaponState = "idle"
var CD = 1
var cdTimer = 1
var isEnemyWeapon = false
var Damage :int = 10

func _ready():
	_applyModifier()
	
	if handPosition == "Main":
		trigger = "MainAttack"
	elif handPosition == "Offhand":
		trigger = "OffhandAttack"
	
	if isEnemyWeapon && weaponType == "Melee":
		var area2d = $Area2D
		if is_instance_valid(area2d): 
			area2d.set_collision_mask(64)
	

func _input(event):
	if isEnemyWeapon:return
	
	if Input.is_action_just_pressed(trigger) && !cdTimer:
		_attack()

func _process(delta):
	if cdTimer > 0:
		cdTimer -=delta
	else:
		cdTimer= 0
	
	if weaponState == "attack":return
	
	if parentNode.animState == "walk":
		$AnimationPlayer.play("walk")
	else:
		$AnimationPlayer.play("RESET")
		pass
	pass


func _attack():
	cdTimer = CD
	weaponState = "attack"
	animPlayer.play("attack")
	await animPlayer.animation_finished
	weaponState = ""
	print("Attacking")

func _applyModifier():
	if isEnemyWeapon:return
	CD *= parentNode.CooldownReduce
	Damage += parentNode.DamageMultiplier*Damage
