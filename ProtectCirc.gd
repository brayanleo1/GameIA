extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	var bodies = get_overlapping_bodies()
	for b in bodies:
		if b.has_method("set_enemy_stun"):
			b.set_enemy_stun(true)
	var light_bodies = get_node("LightArea").get_overlapping_bodies()
	for b in light_bodies:
		if b.has_method("set_enemy_afraid"):
			b.set_enemy_afraid(true)
			b.get_node("AI").set_fear(get_node("."))
			


func _on_LightCounter_timeout():
	queue_free()

