class_name Sel
extends Node2D

enum {
	SUC,
	FAI,
	RUN
}

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



var subT = []
	
func _init(subs):
	subT = subs
	
func exe():
	for t in subT:
		var status = t.exe()
		if status != FAI:
			return status
	return FAI
