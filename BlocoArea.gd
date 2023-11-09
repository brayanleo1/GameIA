extends Area2D

onready var piso = get_node(".") #get_node("BlocoArea")
onready var pos = piso.get_global_position()

onready var areaIx = pos.x - 8.5
onready var areaFx = pos.x + 8.5
onready var areaIy = pos.y - 8.5
onready var areaFy = pos.y + 8.5

var animatedSprite : AnimatedSprite

func _ready():
	# Access the AnimatedSprite node using get_node
	animatedSprite = $PisoSprite

func fullBlock():
	animatedSprite.set_animation("An2")
	
func goalBlock():
	animatedSprite.set_animation("An3")

func freeBlock():
	animatedSprite.set_animation("An1")
