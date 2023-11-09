extends StaticBody2D

onready var body = get_node(".") #get_node("Corpo")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func freeBlock():
	body.set_collision_layer_bit(int(7),false)
	body.set_collision_mask_bit(int(7),false)
	body.set_collision_layer_bit(int(8),false)
	body.set_collision_mask_bit(int(8),false)

func fullBlock():
	body.set_collision_layer_bit(int(7),true)
	body.set_collision_mask_bit(int(7),true)
	body.set_collision_layer_bit(int(8),true)
	body.set_collision_mask_bit(int(8),true)
