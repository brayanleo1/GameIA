extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_ProtectCirc_body_entered(body):
	if has_method("set_enemy_stun"):
		body.set_enemy_stun(true)
