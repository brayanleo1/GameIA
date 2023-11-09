extends Node2D


var actor: KinematicBody2D = null
var target: Area2D = null
var goal: Area2D = null

var way = []



var speed = 100

func _ready():
	pass

func _physics_process(delta): #Here i shall have a behavior tree
	#Selector
	# isOnGoal
	# Sequence
	#  isThereWay
	#  Selector
	#   Sequence
	#    isOnPlace
	#    getNextTarget
	#   move
	# createWay
	if(target != null || goal != null):
		target = goal
		move(speed, delta)

func getNextTarget():
	target = way.pop_front()
	
func setGoal(g: Area2D):
	goal = g

func createWay():
	#A* using the blocks
	#Uses the h function to get numbers of "distance"
	#Needs to receive the freePis array to do the computing
	#and the place where it is located
	pass

func h():
	#Receives the an element of freePis array and puts value
	#The value is the distance towards the goal
	pass

func move(speed, delta):
	var direction = (target.get_global_position() - actor.transform.origin).normalized();
	var velocity = direction * speed * delta * 0.1;
	actor.move_and_collide(velocity);

func initialize(actor: KinematicBody2D):
	self.actor = actor
