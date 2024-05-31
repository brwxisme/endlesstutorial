extends Button

@export var handType : String
@export var weaponName : String
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_toggled(toggled_on):
	if toggled_on:
		GameLibrary[handType] = weaponName
	pass # Replace with function body.
