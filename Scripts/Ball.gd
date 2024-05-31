extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var TWN = create_tween().set_loops()
	TWN.tween_property(self,"position:x",100,1).from(-100)
	TWN.tween_property(self,"position:x",-100,1).from(100)
	pass # Replace with function body.

