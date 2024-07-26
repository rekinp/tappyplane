extends CharacterBody2D



const GRAVITY: float = 1500.0
const FLYING_POWER: float = -500.0

@onready var sprite: AnimatedSprite2D = $Sprite
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var engine_sound = $EngineSound

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity.y += GRAVITY * delta
	fly()
	move_and_slide()
	if is_on_floor():
		die()
		
func die():
	sprite.stop()
	engine_sound.stop()
	set_physics_process(false)
	SignalManager.on_plane_died.emit()
	
func fly() -> void:
	pass
	if Input.is_action_just_pressed("fly"):
		velocity.y += FLYING_POWER
		animation_player.play("power")
		
