extends KinematicBody2D
class_name Player

export (int) var speed = 200

onready var health_stat = $Health
onready var team = $Team
var alive = true

func _ready():
	get_node("ProgressBar").value = health_stat.health

func _physics_process(delta):
	if(alive):
		var movement_direction := Vector2.ZERO
		
		if Input.is_action_pressed("ui_up"):
			movement_direction.y = -1
		if Input.is_action_pressed("ui_down"):
			movement_direction.y = 1
		if Input.is_action_pressed("ui_left"):
			movement_direction.x = -1
		if Input.is_action_pressed("ui_right"):
			movement_direction.x = 1
		
		movement_direction = movement_direction.normalized()
		move_and_slide(movement_direction * speed)
		var overlapping_bodies = get_node("Area2D").get_overlapping_bodies()
		if overlapping_bodies.size() > 0:
			handle_hit()
	

func get_team() -> int:
	return team.team

func handle_hit():
	health_stat.health -= 1
	get_node("ProgressBar").value = health_stat.health
	if health_stat.health <= 0:
		print("player dies")
		alive = false
	#print("player hit", health_stat.health)
	
func heal(value):
	health_stat.health += value
	get_node("ProgressBar").value = health_stat.health
