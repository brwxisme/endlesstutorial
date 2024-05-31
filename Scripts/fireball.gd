extends Node2D

var direction
var lifetime = 5
var Damage
var isEnemyWeapon = false
var speed = 400
func _ready():
	if isEnemyWeapon:
		speed /= 2 
		var area2d = $Area2D
		if is_instance_valid(area2d):
			area2d.set_collision_mask(64)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if lifetime >0:
		lifetime-=delta
	else:
		queue_free()
	
	position += delta*direction*speed
	pass


func _on_area_2d_body_entered(body):
	body._takeDamage(Damage)
	#body.call_deffered("_takeDamage",Damage)
	queue_free()
	pass # Replace with function body.
