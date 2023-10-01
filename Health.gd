extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Health_body_entered(body):
	if body.has_method("heal"):
		body.heal(20)
	queue_free()
