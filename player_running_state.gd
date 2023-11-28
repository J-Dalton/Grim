class_name PlayerRunningState
extends State

@export var actor: PlayerCharacter
@export var animator: AnimatedSprite2D
@export var a_player: AnimationPlayer


const SPEED = 150.0
const ACCEL = 15

signal player_stopped_running
signal player_jumped_running

func _ready():
	set_physics_process(false)

func _enter_state() -> void:
	
	set_physics_process(true)
	
	a_player.play("Run")
	
func _exit_state() -> void:
	set_physics_process(false)
	
	
func _physics_process(_delta):
	
	var direction = Input.get_axis("Left", "Right")
	
	
	if actor.is_on_floor() && direction !=0:
		actor.velocity.x = direction * SPEED
	else:
		actor.velocity.x = move_toward(actor.velocity.x, direction * SPEED, ACCEL)
	
	if actor.velocity.x == 0 && actor.is_on_floor():
		player_stopped_running.emit()
	
	if Input.is_action_just_pressed("Jump"):
		player_jumped_running.emit()
	
	
