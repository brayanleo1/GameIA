extends Node2D

onready var blocoArea = $BlocoArea
onready var blocoBody = $BlocoCorpo

var full = false
var goal = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func fullBlock():
	blocoArea.fullBlock()
	blocoBody.fullBlock()
	full = true
	
	
func freeBlock():
	blocoArea.freeBlock()
	blocoBody.freeBlock()
	full = false
	goal = false

func goalBlock():
	blocoArea.goalBlock()
	goal = true

func getArea():
	return blocoArea


func _on_BlocoArea_body_entered(body: KinematicBody2D):
	if(body != self):
		full = true


func _on_BlocoArea_body_exited(body: KinematicBody2D):
	if(body != self):
		full = false
