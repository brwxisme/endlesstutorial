extends Weapon

var fireballScene = preload("res://Weapons/fireball.tscn")
# Called when the node enters the scene tree for the first time.

func _ready():
	weaponType = "Staff"
	super._ready()
	animPlayer = $AnimationPlayer
	CD = 2
	
	pass
	


func _attack():
	super._attack()
	var newFireball = fireballScene.instantiate()
	newFireball.Damage = Damage 
	newFireball.direction = $Hands/Base.global_position.direction_to($Hands/Tip.global_position)
	newFireball.global_position = $Hands/Tip.global_position
	newFireball.isEnemyWeapon = isEnemyWeapon
	get_tree().current_scene.add_child(newFireball)
# Called every frame. 'delta' is the elapsed time since the previous frame.

