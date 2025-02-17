extends Node

@export var mob_scene: PackedScene
var score

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#new_game() (til at starte ny game) (udskift med pass)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func game_over() -> void:
	$ScoreTimer.stop()
	$MobTimer.stop()
	
	$HUD.show_game_over()
	$Music.stop()
	$DeathSound.play()

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	
	get_tree().call_group("mobs", "queue_free")
	#calls all mobs and deletes them (frees up the queue)
	#The call_group() function calls the named function on every node in a group - in this case we are telling every mob to delete itself.
	$Music.play()
	
func _on_score_timer_timeout():
	score += 1
	
	$HUD.update_score(score)
	
func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
	
	$HUD.update_score(score)
	
func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate()
	
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	var direction = mob_spawn_location.rotation + PI / 2
	
	mob.position = mob_spawn_location.position
	
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob)
