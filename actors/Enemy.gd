extends KinematicBody2D

#onready var health_stat: int = 100
onready var ai = $AI

var animatedSprite : AnimatedSprite

export (int) var speed = 100

func _ready():
	ai.initialize(self)
	animatedSprite = $Body

func setGoal(area):
	ai.setGoal(area)
	
func setAt(area):
	ai.getPlace(area)

func setMap(area):
	ai.getMap(area)

func _process(delta):
	pass
