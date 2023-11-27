class_name PlayerCharacter
extends CharacterBody2D

const bulletPath = preload("res://bullet.tscn")

const JUMP_VELOCITY = -400.0
var slide_speed = 150.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = get_node("AnimationPlayer")
@onready var animSprite = get_node("AnimatedSprite2D")

var right = false
var left = true
var idleRight:bool
var idleLeft:bool

@onready var fsm = $FiniteStateMachine as FiniteStateMachine
@onready var player_running_state = $FiniteStateMachine/PlayerRunningState as PlayerRunningState
@onready var player_idle_state = $FiniteStateMachine/PlayerIdleState as PlayerIdleState



func _ready():
	player_running_state.player_running.connect(fsm.change_state.bind(player_idle_state))
	player_idle_state.player_idle.connect(fsm.change_state.bind(player_running_state))
	
func _physics_process(delta):

	
	var shoot = Input.is_action_just_pressed("Click")
	
	
	
	
	if not is_on_floor():
		if Game.playerGravity == "normal":
			velocity.y += gravity * delta
		if Game.playerGravity == "water":
			velocity.y += 100 * delta
#
#
#
#
	if right && shoot && is_on_floor():
		anim.play("Run_Shooting")

	if left && shoot && is_on_floor():
		anim.play("Run_Shooting")

	if idleRight && shoot && is_on_floor():
		anim.play("Idle_Shooting")

	if idleLeft && shoot && is_on_floor():
		anim.play("Idle_Shooting")
#
#
#
	print(anim.get_current_animation())
#	jump()
#
#
#	if shoot:
#		Shoot()
#
	move_and_slide()
#
#	if Game.playerHP <= 0:
#		queue_free()
#		get_tree().change_scene_to_file("res://main.tscn")
		
func Shoot():
	var bullet = bulletPath.instantiate()
	get_parent().add_child(bullet)
	
	if idleLeft || left:
		bullet.bullDirection = -1
		bullet.position = $Marker2D2.global_position
		
	if idleRight || right:
		bullet.bullDirection = 1
		bullet.position = $Marker2D.global_position
	
		
func jump():
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		if Game.playerGravity == "normal":
			velocity.y = JUMP_VELOCITY
			anim.play("Jump")
		if Game.playerGravity == "water":
			velocity.y = JUMP_VELOCITY + 300
			anim.play("Jump")
			
func directionPrint():
	print(str("Right: ", right, "\n",
	 "Left: ", left, "\n",
	 "IdleRight: ", idleRight,"\n",
	 "IdleLeft: ", idleLeft, "\n"))
