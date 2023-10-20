extends Sprite2D

var sprites = [load("res://Sprites/Sprite-IdleHouse2.png"), load("res://Sprites/Sprite-IdleBuilding.png")]
var current_sprite = 1

func _ready():
	set_texture(sprites[current_sprite])
