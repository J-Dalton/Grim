class_name PlayerJumpingState
extends State

@export var actor: PlayerCharacter
@export var animator: AnimatedSprite2D
@export var a_player: AnimationPlayer
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
const JUMP_VELOCITY = -400.0
var falling: bool = false

signal player_landed

func _ready():
	set_physics_process(false)

func _enter_state() -> void:
	
	set_physics_process(true)
	
	
func _exit_state() -> void:
	set_physics_process(false)
	

func _physics_process(delta):
	
	if Input.is_action_just_pressed("Jump") and actor.is_on_floor():
		a_player.play("Jump")
		if Game.playerGravity == "normal":
			actor.velocity.y = JUMP_VELOCITY
			
		if Game.playerGravity == "water":
			actor.velocity.y = JUMP_VELOCITY + 300
			
	if actor.velocity.y == 0:
		falling = false
	elif actor.velocity.y > 0:
		falling = true
	
	if !falling:
		player_landed.emit()
	
	
	
	
	
	
	
		#if Game.playerGravity == "water":
			#actor.velocity.y = JUMP_VELOCITY + 300
			
			
	
		

