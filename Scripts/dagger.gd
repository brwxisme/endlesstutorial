extends Weapon


# Called when the node enters the scene tree for the first time.

func _ready():
	super._ready()
	animPlayer = $AnimationPlayer
	CD = 0.5
	
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.



func _on_area_2d_body_entered(body):
	body._takeDamage(Damage)
	pass # Replace with function body.
