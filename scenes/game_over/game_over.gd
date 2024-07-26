extends Control

@onready var game_over_label = $GameOverLabel
@onready var space_label = $SpaceLabel
@onready var restart_timer = $RestartTimer
@onready var sound = $Sound

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	SignalManager.on_plane_died.connect(on_plane_died)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if visible and space_label.visible and Input.is_action_just_pressed("fly"):
		GameManager.load_main_scene()

func on_plane_died() -> void:
	sound.play()
	show()
	restart_timer.start()
	

func _on_restart_timer_timeout():
	game_over_label.hide()
	space_label.show()
