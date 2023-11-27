extends CharacterBody2D

var b_velocityR = Vector2(1, 0)
var b_velocityL = Vector2(-1,0)
var b_speed = 300
var bullDirection; 
@onready var anim = get_node("Area2D/AnimationPlayer")
@onready var anima = get_node("Area2D/AnimatedSprite2D")
@onready var player = get_node("/root/World/Player/Player/AnimatedSprite2D")

func _ready():
	self.add_to_group("bullets")
	
func _physics_process(delta):

	if bullDirection == 1:
		anima.flip_h = false
		move_and_collide(b_velocityR.normalized() * delta * b_speed)
		
	if bullDirection == -1:
		anima.flip_h = true
		move_and_collide(b_velocityL.normalized() * delta * b_speed)

func _on_area_2d_body_entered(body):
	if body.name == "TileMap":
		anim.play("b_collision")
		b_velocityR = Vector2(0,0)
		b_velocityL = Vector2(0,0)
		await anim.animation_finished
		self.queue_free()
