extends Node2D

var blocoScene = preload("res://Bloco.tscn")
var enemy_scene = preload("res://actors/Enemy.tscn")

var matPis = []
var freePis = []
var goals = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for x in range(10):
		for y in range(10):
			matPis = matPis + [get_node("BlocosL"+str(x+1)+"/Bloco"+str(y+1))]
	var i = 0
	for item in matPis:
		i = i + 1
		if i%7==0:
			i = 0
			if item.has_method("fullBlock"):
				item.fullBlock()
		else:
			freePis = freePis + [item]
	
	createGoals()

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_s"):
		createGoals()

func createGoals():
	if goals.size() > 0:
		for g in goals:
			if g.has_method("freeBlock"):
				g.freeBlock()
		goals.clear()
	for x in range(2):
			var freePisT = freePis[randi() % int(freePis.size())]
			if(freePisT.has_method("goalBlock")):
				freePisT.goalBlock()
				goals = goals + [freePisT]
				get_node("Enemy"+str(x+1)).setGoal(freePisT.getArea())

func retFreePis():
	return freePis
