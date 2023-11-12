class_name Seq
extends Node2D


enum {
	SUC,
	FAI,
	RUN
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



var subT = []
	
func _init(subs):
	subT = subs
		
func exe():
	for x in subT.size():
		var status = subT[x].exe()
		if status != SUC:
			return status
		return SUC
