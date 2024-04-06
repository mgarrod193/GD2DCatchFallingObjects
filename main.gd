extends Node

@export var mob_scene: PackedScene
@export var lives = 3
var score
var time = 2

var spawn1
var spawn2
var spawn3
var spawn4 
var spawns 
# Called when the node enters the scene tree for the first time.
func _ready():
	$HUD.update_message("Catch Them All!")
	$Player.start($StartPosition.position)
	$HUD.update_lives(lives)
	$Player.hide()
	score = 0
	spawn1 = $EnemySpawn1.position
	spawn2 = $EnemySpawn2.position
	spawn3 = $EnemySpawn3.position
	spawn4 = $EnemySpawn4.position
	spawns = [spawn1, spawn2, spawn3, spawn4]

func start():
	$SpawnTimer.set_wait_time(time)
	$Player.start($StartPosition.position)
	$Player.show()
	$SpawnTimer.start()
	lives = 3
	score = 0
	$HUD.update_score(score)
	$HUD.update_lives(lives)
	

func game_over():
	$Music.stop()
	$MusicTimer.start()
	$DeathSound.play()
	$Player.hide()
	$HUD.show_button()
	$HUD.update_message("Better Luck Next Time")
	$SpawnTimer.stop()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if lives == 0:
		game_over()
		lives = 3


func _on_score_timer_timeout():
	score += 1


func _on_spawn_timer_timeout():
	
	var mob = mob_scene.instantiate()
	var random_spawn = randi() % spawns.size()
	mob.position = spawns[random_spawn]
	
	add_child(mob)


func _on_area_2d_body_entered(body):
	lives -= 1
	$HUD.update_lives(lives) # Replace with function body.
	body.queue_free()


func _on_player_catch():
	score += 1
	$HUD.update_score(str(score))


func _on_hud_harder():
	time -= 0.5
	$SpawnTimer.set_wait_time(time)


func _on_music_timer_timeout():
	$Music.play()
