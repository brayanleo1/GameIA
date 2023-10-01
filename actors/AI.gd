extends Node2D

signal state_changed(new_state)

enum State {
	DEACTIVE,
	CHASE,
	STUNNED,
	AFRAID
}

onready var stun_timer = $StunTimer

var current_state: int = -1 setget set_state
var actor: KinematicBody2D = null
var target: KinematicBody2D = null
var team: int = -1
var active = false
var stun = false

var speed = 100

func _ready():
	set_state(State.DEACTIVE)

func _physics_process(delta):

	match current_state:
		State.DEACTIVE:
			if active:
				set_state(State.CHASE)
		State.CHASE:
			if not active:
				set_state(State.DEACTIVE)
			elif stun:
				set_state(State.STUNNED)
				stun_timer.start()
			else:
				if(target != null):
					var direction = (target.transform.origin - actor.transform.origin).normalized();
					var velocity = direction * speed * delta;
					actor.move_and_collide(velocity);
				else:
					print("targetto null")
		_:
			print("Error: found enemy state that should not exist")

func set_state(new_state: int):
	if new_state == current_state:
		return
	
	current_state = new_state
	emit_signal("state_changed", current_state)

func initialize(actor: KinematicBody2D, team: int):
	self.actor = actor
	self.team = team
	

func _on_StunTimer_timeout():
	stun = false
	set_state(State.CHASE)

func _on_DetectionZone_body_entered(body):
	if body.has_method("get_team") and body.get_team() != team and body.get_team() != 2:
		target = body


#func _on_DetectionZone_body_exited(body):
#	if target and body == target:
#		set_state(State.PATROL)
#		target = null
