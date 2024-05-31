extends Node

var choosenHero = "Knight"
var mainHand = "Sword"
var offHand = "Sword"

signal enemyKilled
signal playerKilled

var weapons : Dictionary = {
	"Sword" : preload("res://Weapons/sword.tscn")
	,"Dagger" : preload("res://Weapons/dagger.tscn")
	,"Staff" : preload("res://Weapons/staff.tscn")
}

var heroes : Dictionary = {
	"Knight" : preload("res://Resources/Heroes/Knight.tres")
	,"Rogue" : preload("res://Resources/Heroes/Rogue.tres")
	,"Mage" : preload("res://Resources/Heroes/Mage.tres")
}

var enemies : Dictionary = {
	"Skelly" : preload("res://Resources/Enemies/Skelly.tres")
	,"Warrior" : preload("res://Resources/Enemies/Warrior.tres")
	,"Rogue" : preload("res://Resources/Enemies/Rogue.tres")
	,"Mage" : preload("res://Resources/Enemies/Mage.tres")
}
