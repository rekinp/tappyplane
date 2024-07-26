extends Node2D

@export var pipes_scene: PackedScene
@onready var pipes_holder = $PipesHolder
@onready var spawn_u = $SpawnU
@onready var spawn_l = $SpawnL
@onready var spawn_timer = $SpawnTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_plane_died.connect(_on_plane_died)
	ScoreManager.set_score(0)
	spawn_pipes()


func spawn_pipes() -> void:
	var initial_timer: float = 3
	var time_penalty: float = ScoreManager.get_score() * 0.1
	var new_time = initial_timer - time_penalty
	spawn_timer.set("wait_time", new_time)
	spawn_timer.start(new_time)
	var start_x: int = 550
	var new_pipes = pipes_scene.instantiate()
	var y_pos = randf_range(spawn_u.position.y, spawn_l.position.y)
	var x_pos = randf_range(0, 50)
	new_pipes.position = Vector2(start_x + x_pos, y_pos)
	pipes_holder.add_child(new_pipes)

func stop_pipes() -> void:
	spawn_timer.stop()
	for pipe in pipes_holder.get_children():
		pipe.set_process(false)
		
	
	
func _on_spawn_timer_timeout():
	spawn_pipes()


func _on_plane_died():
	stop_pipes()
