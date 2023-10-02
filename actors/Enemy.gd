extends KinematicBody2D

#onready var health_stat: int = 100
onready var ai = $AI
onready var health_stat = $Health
onready var team = $Team

var isEnemyActive = false
var isEnemyStunned = false
var isEnemyAfraid = false

export (int) var speed = 100

func _ready():
	ai.initialize(self, team.team)

func _process(delta):
	get_node("AI").active = isEnemyActive
	get_node("AI").stun = isEnemyStunned
	get_node("AI").afraid = isEnemyAfraid

func set_enemy_bool(value):
	isEnemyActive = value

func set_enemy_stun(value):
	isEnemyStunned = value
	
func set_enemy_afraid(value):
	isEnemyAfraid = value

func rotate_toward(location: Vector2):
	rotation = lerp(rotation, global_position.direction_to(location).angle(), 0.1)
	
func velocity_toward(location: Vector2) -> Vector2:
	return global_position.direction_to(location) * speed

func get_team() -> int:
	return team.team

#func handle_hit():
#	health_stat.health -= 20
#	var body = get_node("Body")
#	body.modulate = Color8(body.modulate.r8-25,body.modulate.g8-25,body.modulate.b8-25)


func _on_StunTimer_timeout():
	isEnemyStunned = false


func _on_FearTimer_timeout():
	isEnemyAfraid = false
