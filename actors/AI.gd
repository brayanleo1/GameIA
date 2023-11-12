extends Node2D

#formula to access matPis based on position:
#x,y:(value - 8)/15 then we can get from 0 to 9 for lines and columns

#var actCon = preload("res://ActCon.tscn")
#var seq = preload("res://Seq.tscn")
#var sel = preload("res://Sel.tscn")

enum {
	SUC,
	FAI,
	RUN
}

var actor: KinematicBody2D = null

var target = null
var goal = null
var obstacle = []

var map = []
var way = []
var at = null

var canMove = true

var speed = 100

var iog = ActCon.new(funcref(self, 'isOnGoal'))
var itw = ActCon.new(funcref(self, 'isThereWay'))
var iop = ActCon.new(funcref(self, 'isOnPlace'))
var gnt = ActCon.new(funcref(self, 'getNextTarget'))
var mov = ActCon.new(funcref(self, 'moveLine'))
var crw = ActCon.new(funcref(self, 'createWay'))
var seq2 = Seq.new([iop, gnt]) #isOnPlace, getNextTarget
var sel2 = Sel.new([seq2, mov]) #Sequence 2, moveLine
var seq1 = Seq.new([itw, sel2]) #isThereWay, Selector 2
var sel1 = Sel.new([iog,seq1,crw]) #isOnGoal, Sequence 1, CreateWay

func selF1():
	var status = isOnGoal()
	if (status == true):
		return SUC
	status = seqF1()
	if (status == SUC):
		return SUC
	status = createWay()
	if (status == true):
		return SUC
	return FAI

func seqF1():
	var status = isThereWay()
	if (status == false):
		return FAI
	status = selF2()
	if (status == FAI):
		return FAI
	return SUC

func selF2():
	var status = seqF2()
	if (status == SUC):
		return SUC
	status = moveLine()
	if (status == true):
		return SUC
	return FAI

func seqF2():
	var status = getNextTarget()
	if (status == false):
		return FAI
	status = isOnPlace()
	if (status == false):
		return FAI
	return SUC

func _ready():
	pass

func _physics_process(delta): #Here i shall have a behavior tree
	#Selector sel1
	# isOnGoal
	# Sequence seq1
	#  isThereWay
	#  Selector sel2
	#   Sequence seq2
	#    getNextTarget
	#    isOnPlace
	#   move
	# createWay
	#sel1.exe()
	selF1()

func setGoal(g):
	goal = g

func getMap(m):
	map = m

func isOnPlace():
	if(target == null):
		return false
	if (target.get_global_position()-actor.get_global_position()).length() < 6:
	#if(target.get_global_position() == actor.get_global_position()):
		return true
	return false

func isOnGoal():
	getPlace(map)
	if(at.get_global_position() == goal.get_global_position()):
		return true
	return false

func isThereWay():
	if way == null or way == [] or way.back() != goal:
		return false
	return true

#for testing
func showWay():
	for b in way:
		print(str((b.get_global_position().x - 8)/15)," ",str((b.get_global_position().y - 8)/15))

func getNextTarget():
	if(way.size() > 0):
		target = way.pop_front()
		return true
	return false

func getPlace(matPis):
	var p = actor.transform.origin
	var xp = int((p.x - 0.5)/15)
	var yp = int((p.y - 0.5)/15)
	at = matPis[yp][xp]
	#x,y: (val - 0.5)/15
	#from 0.5 to 15.5 is 0
	#from 15.5 to 30.5 is 1
	#...

func createWay():
	#A* using the blocks
	#Uses the h function to get numbers of "distance"
	#Needs to receive the map array to do the computing
	#and the place where it is located
	var g = 0
	var h = heur(at)
	var open = [{ar=[at],vg=g,vh=h}]
	var openL = [at]
	var closed = []
	while open.size() != 0:
		var n = removeLowestF(open)
		if(n.ar.back() == goal):
			#Return path to n
			#Path to n is the first value of the dictionary, an array
			way = n.ar
			return true
		closed = closed + [n.ar.back()]
		#gen neighbors that aren't in closed nor open
		var neighs = neighbors(n.ar.back(), openL, closed)
		#for neighbors of n not in closed or open
		for m in neighs:
			open = open + [{ar=(n.ar)+[m], vg=n.vg + 1, vh=heur(m)}]
			openL = openL + [m]
			#neigh.parent = n -> neigh.ar = n.ar + [m] where m is node on map
			#neigh.vg = n.vg + 1
			#neigh.vh = heur(m) where m is node on map
			#open = open + [neigh]
	return false
	#and we finished this A* magic 

func neighbors(block, openL, closedL):
	#(value - 8)/15
	var vpx = (block.get_global_position().x - 8)/15
	var vpy = (block.get_global_position().y - 8)/15
	var neighs = []
	if(vpy-1 > -1):
		neighs = neighs + [map[vpy-1][vpx]]
	if(vpy+1 < 10):
		neighs = neighs + [map[vpy+1][vpx]]
	if(vpx-1 > -1):
		neighs = neighs + [map[vpy][vpx-1]]
	if(vpx+1 < 10):
		neighs = neighs + [map[vpy][vpx+1]]
	var truNeighs = []
	for nei in neighs:
		if (openL.find(nei) != -1):
			pass
		elif (closedL.find(nei) != -1):
			pass
		elif nei.full:
			pass
		else:
			truNeighs = truNeighs + [nei]
	return truNeighs

class sortByF:
	static func sortAscending(a, b):
		if a.vg+a.vh < b.vg+b.vh:
			return true
		return false

func removeLowestF(open):
	open.sort_custom(sortByF, "sortAscending")
	return open.pop_front()

#It just works!
func heur(block):
	#Receives the an element of map array and puts value
	#The value is the distance towards the goal
	var p = (goal.get_global_position() - block.get_global_position())/15
	return abs(p.x) + abs(p.y)

func move(delta):
	var velocity = 0
	if obstacle != []:
		velocity = move_with_obstacle_avoidance(delta)
	else:
		var direction = (target.get_global_position() - actor.transform.origin).normalized();
		velocity = direction * speed * delta * 0.1;
	#rotation_degrees = lerp(rotation_degrees, global_position.direction_to(target.get_global_position()).angle(), 1)
	#rotation_degrees = Transform.IDENTITY.direction_to(velocity, Vector2.UP).basis.get_euler()
	$DetectionZone.look(target)
	actor.move_and_slide(velocity*100);

func moveLine():
	if(target == null):
		return false
	if(target.full):
		way = []
		return false
	if(!canMove):
		return false
	actor.position = target.get_global_position()
	canMove = false
	$tillNext.start()
	at.full = false
	getPlace(map)
	at.full = true
	return true

func avoid_obstacles():
	var avoidance_force = Vector2.ZERO
	
	for o in obstacle:
		# Calculate the vector from the obstacle to the actor
		var to_obstacle = actor.get_global_position() - o.get_global_position()
		# Calculate the distance to the obstacle
		var distance = to_obstacle.length()
		
		to_obstacle = to_obstacle.normalized()  # Normalize the vector
		avoidance_force += to_obstacle * 3 / distance  # Weight the force by the distance
	
	return avoidance_force

func move_with_obstacle_avoidance(delta):
	var move_direction = (target.get_global_position() - actor.get_global_position()).normalized()

	# Calculate the steering force for obstacle avoidance
	var avoidance_force = avoid_obstacles()

	# Adjust the movement direction based on avoidance force
	move_direction += avoidance_force

	# Normalize the resulting direction
	move_direction = move_direction.normalized()

	# Move the actor using move_and_collide()
	var velocity = move_direction * speed * delta * 0.1
	return velocity

func initialize(actor: KinematicBody2D):
	self.actor = actor


func _on_DetectionZone_body_entered(body):
	if(body != actor):
		obstacle = obstacle + [body]
	pass # Replace with function body.


func _on_DetectionZone_body_exited(body):
	if(body != actor):
		obstacle.remove(obstacle.find(body))
	pass # Replace with function body.


func _on_tillNext_timeout():
	canMove = true
