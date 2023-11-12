extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func look(target):
	look_at(target.get_global_position())

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
