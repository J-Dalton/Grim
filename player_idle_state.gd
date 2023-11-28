class_name PlayerIdleState
extends State

@export var actor: PlayerCharacter
@export var animator: AnimatedSprite2D
@export var a_player: AnimationPlayer

signal player_stopped_idle
signal player_jumped_idle

func _ready():
	set_physics_process(false)

func _enter_state() -> void:
	set_physics_process(true)
	
	a_player.play("Idle")
	
	
func _exit_state() -> void:
	set_physics_process(false)
	
	
func _physics_process(_delta):
	var direction = Input.get_axis("Left", "Right")
	
	
	if Input.is_action_just_pressed("Jump"):
		player_jumped_idle.emit()
	
	if direction != 0:
		player_stopped_idle.emit()
