extends Node

@export var mob_scene: PackedScene
var score

var spawn1
var spawn2
var spawn3
var spawn4 
var spawns 
# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.start($StartPosition.position)
	score = 0
	spawn1 = $EnemySpawn1.position
	spawn2 = $EnemySpawn2.position
	spawn3 = $EnemySpawn3.position
	spawn4 = $EnemySpawn4.position
	spawns = [spawn1, spawn2, spawn3, spawn4]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_start_timer_timeout():
	$ScoreTimer.start()
	$SpawnTimer.start()

func _on_score_timer_timeout():
	score += 1


func _on_spawn_timer_timeout():
	
	var mob = mob_scene.instantiate()
	var random_spawn = randi() % spawns.size()
	mob.position = spawns[random_spawn]
	
	add_child(mob)
