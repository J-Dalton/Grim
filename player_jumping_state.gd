class_name PlayerJumpingState
extends State

@export var actor: PlayerCharacter
@export var animator: AnimatedSprite2D
@export var a_player: AnimationPlayer

const JUMP_VELOCITY = -400.0



func _ready():
	set_physics_process(false)

func _enter_state() -> void:
	
	set_physics_process(true)
	
	
func _exit_state() -> void:
	set_physics_process(false)
	

func _physics_process(_delta):
	
	if Input.is_action_just_pressed("Jump") and actor.is_on_floor():
		if Game.playerGravity == "normal":
			actor.velocity.y = JUMP_VELOCITY
			
		if Game.playerGravity == "water":
			actor.velocity.y = JUMP_VELOCITY + 300
	
	actor.is_
	

