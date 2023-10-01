extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var piso = get_node(".") #get_node("Piso")
onready var pos = piso.get_global_position()

var at = false
onready var areaIx = pos.x - 200
onready var areaFx = pos.x + 200
onready var areaIy = pos.y - 200
onready var areaFy = pos.y + 200

var animatedSprite : AnimatedSprite

func _ready():
	# Access the AnimatedSprite node using get_node
	at = true
	animatedSprite = $PisoSprite

func _process(delta):
	if at:
		animatedSprite.set_animation("An2")
		var overlapping_bodies = get_node(".").get_overlapping_bodies()
		for body in overlapping_bodies:
			if body.has_method("set_enemy_bool"):
				body.set_enemy_bool(true)
	else:
		animatedSprite.set_animation("An1")
		var overlapping_bodies = get_node(".").get_overlapping_bodies()
		for body in overlapping_bodies:
			if body.has_method("set_enemy_bool"):
				body.set_enemy_bool(false)
			# You might want to check if 'body' has a specific script method to handle the boolean value change

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass
