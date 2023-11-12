extends Node2D

enum {
	SUC,
	FAI,
	RUN
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

class Seq:
	var subT = []
	
	func _init(subs):
		subT = subs
		
	func exe():
		for x in subT.size():
			var status = subT[x].exe()
			if status != SUC:
				return status
			return SUC

class Sel:
	var subT = []
	
	func _init(subs):
		subT = subs
		
	func exe():
		for t in subT:
			var status = t.exe()
			if status != FAI:
				return status
		return FAI
		
class IsOnPlaceC:
	func exe():
		var r = call('isOnPlace')
		if r:
			return SUC
		return FAI
		
class actCon:
	var ref = null
	var name = null
	
	func _init(f, n):
		ref = f
		name = n
	
	func exe():
		var r = ref.call(name)
		if r:
			return SUC
		return FAI
