extends Node2D

onready var playerNode = get_node("Player")

var enemy_scene = preload("res://actors/Enemy.tscn")
var health_scene = preload("res://Health.tscn")
var light_scene = preload("res://Light.tscn")

# Number of enemies to spawn
var num_enemies = 10
var num_items = 10

# Area where enemies will be randomly distributed
var spawn_area = Rect2(20, 20, 880, 880)

var matPis = []

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_enemies()
	for n in range(num_items):
		spawn_item()
	for x in range(9):
		matPis = matPis + [get_node("Pisos/Sprite"+str(x+1))]


func spawn_enemies():
	for n in range(num_enemies):
		var enemy_instance = enemy_scene.instance()

		# Randomly position the enemy within the spawn_area
		enemy_instance.position = Vector2(
			randi() % int(spawn_area.size.x) + spawn_area.position.x,
			randi() % int(spawn_area.size.y) + spawn_area.position.y
		)

		# Add the enemy to the World node
		add_child(enemy_instance)

func spawn_item():
	var choice = randi() % 2
	var item_instance
	if choice == 0:
		item_instance = health_scene.instance()
	else:
		item_instance = light_scene.instance()
	
	item_instance.position = Vector2(
		randi() % int(spawn_area.size.x) + spawn_area.position.x,
		randi() % int(spawn_area.size.y) + spawn_area.position.y
	)

	# Add the enemy to the World node
	add_child(item_instance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(playerNode != null):
		for item in matPis:
			var area = item.get_node("Area2D")
			if (playerNode.global_position.x >= area.areaIx and playerNode.global_position.x <= area.areaFx) and (playerNode.global_position.y >= area.areaIy and playerNode.global_position.y <= area.areaFy):
				area.at = true
			else:
				area.at = false


func _on_ItemTimer_timeout():
	spawn_item()

