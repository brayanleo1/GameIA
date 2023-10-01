extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var piso = get_node("Piso")
onready var pos = piso.get_global_position()

var at = false
var areaIx = pos.x - 150
var areaFx = pos.x + 150
var areaIy = pos.y - 150
var areaFy = pos.y + 150


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
