extends Node2D

var protect = preload("res://ProtectCirc.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _free():
	queue_free()

func _on_Light_body_entered(body):
	var proc = protect.instance()
	proc.position = self.global_position
	get_parent().call_deferred("add_child",proc)
	queue_free()
	
