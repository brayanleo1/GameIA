class_name ActCon
extends Node2D

enum {
	SUC,
	FAI,
	RUN
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
		

var ref = null
	
func _init(f):
	ref = f
	
func exe():
	var r = ref.call_func()
	if r:
		return SUC
	return FAI
