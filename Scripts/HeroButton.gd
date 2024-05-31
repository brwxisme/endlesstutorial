extends Button

@export var resName : String
var myRes : HeroResource

func _ready():
	myRes = GameLibrary.heroes.get(resName)
	$Control/Sprite.texture = myRes.Sprite
	$Label.text = myRes.Name




func _on_toggled(toggled_on):
	if toggled_on:
		GameLibrary.choosenHero = resName
	pass # Replace with function body.
