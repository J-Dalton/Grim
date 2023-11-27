class_name PlayerIdleState
extends State

@export var actor: PlayerCharacter
@export var animator: AnimatedSprite2D

var right = false
var left = true
var idleRight:bool
var idleLeft:bool


signal player_idle

func _ready():
	set_physics_process(false)
	
func _enter_state() -> void:
	set_physics_process(true)
	animator.play("Idle")
	
	
func _exit_state() -> void:
	set_physics_process(false)
	
	
func _physics_process(delta):
	var direction = Input.get_axis("Left", "Right")
		
	if direction == 0 && animator.flip_h == false:
		

		idleRight = true
		idleLeft = false
		
	if direction == 0 && animator.flip_h == true:
		
	
		idleRight = false
		idleLeft = true
		
	if idleRight:
		player_idle.emit()
	
		
	elif idleLeft:
		player_idle.emit()

	
	
