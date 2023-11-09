extends KinematicBody2D
class_name Player

export (int) var speed = 200

onready var health_stat = $Health
onready var team = $Team
var alive = true
var won = false
var time_start = 0
var time_now = 0

func _ready():
	get_node("ProgressBar").value = health_stat.health
	time_start = OS.get_unix_time()

func _physics_process(delta):
	if won:
			get_node("WinOrLose").text = "You Won"
			get_node("WinOrLose").visible = true
	
	if(alive and not won):
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
		
		time_now = OS.get_unix_time()
		var time_elapsed = time_now - time_start
		var minutes = time_elapsed / 60
		var seconds = time_elapsed % 60
		var str_elapsed = "%02d : %02d" % [minutes, seconds]
		get_node("Time").text = str_elapsed
		
		
		if minutes == 10:
			won = true

func get_team() -> int:
	return team.team

func handle_hit():
	health_stat.health -= 1
	get_node("ProgressBar").value = health_stat.health
	if health_stat.health <= 0 and not won:
		print("player dies")
		alive = false
		get_node("WinOrLose").text = "You Lose"
		get_node("WinOrLose").visible = true
	#print("player hit", health_stat.health)
	
func heal(value):
	health_stat.health += value
	if health_stat.health > 100:
		health_stat.health = 100
	get_node("ProgressBar").value = health_stat.health
