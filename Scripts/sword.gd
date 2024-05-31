extends Weapon

func _ready():
	super._ready() 
	animPlayer = $AnimationPlayer
	CD = 1
	
	pass
	

func _on_area_2d_body_entered(body):
	body._takeDamage(Damage)
	print("Deal Damage",Damage)
	pass # Replace with function body.
