class_name PlayerRunningState
extends State

@export var actor: PlayerCharacter
@export var animator: AnimatedSprite2D

var right = false
var left = true


const SPEED = 150.0
var ACCEL = 10

signal player_running

func _ready():
	set_physics_process(false)
	
func _enter_state() -> void:
	set_physics_process(true)
	animator.play("Run")
	
	
func _exit_state() -> void:
	set_physics_process(false)
	
	
func _physics_process(delta):
	var direction = Input.get_axis("Left", "Right")
	
	if direction == -1:
		right = false
		left = true
	
		animator.flip_h = true
		
	if direction == 1:
		right = true
		left = false
	
		animator.flip_h = false
		
	if direction:
		player_running.emit()
		actor.velocity.x = direction * SPEED
		if actor.is_on_floor():
			animator.play("Run")
	else:
		actor.velocity.x = move_toward(actor.velocity.x, direction * SPEED, ACCEL)
		
