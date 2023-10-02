extends Node2D

enum State {
	DEACTIVE,
	CHASE,
	STUNNED,
	AFRAID
}

onready var stun_timer = $StunTimer
onready var fear_timer = $FearTimer

var current_state: int = -1 setget set_state
var actor: KinematicBody2D = null
var target: KinematicBody2D = null
var fear = null
var team: int = -1
var active = false
var stun = false
var afraid = false

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
			elif afraid:
				set_state(State.AFRAID)
				fear_timer.start()
			else:
				if(target != null):
					var direction = (target.transform.origin - actor.transform.origin).normalized();
					var velocity = direction * speed * delta;
					actor.move_and_collide(velocity);
		State.STUNNED:
			if not stun:
				set_state(State.CHASE)
		State.AFRAID:
			if not active:
				set_state(State.DEACTIVE)
			elif stun:
				set_state(State.STUNNED)
				stun_timer.start()
			elif not afraid:
				set_state(State.CHASE)
			else:
				var direction = (actor.transform.origin - fear).normalized();
				var velocity = direction * speed * delta;
				actor.move_and_collide(velocity);
		_:
			print("Error: found enemy state that should not exist")

func set_state(new_state: int):
	if new_state == current_state:
		return
		
	current_state = new_state

func set_fear(fearable):
	fear = fearable.transform.origin

func initialize(actor: KinematicBody2D, team: int):
	self.actor = actor
	self.team = team

func _on_DetectionZone_body_entered(body):
	if body.has_method("get_team") and body.get_team() != team and body.get_team() != 2:
		target = body
