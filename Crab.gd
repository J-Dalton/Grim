extends CharacterBody2D

const SPEED = 50
var chase = false
var player
@onready var crab = get_node("AnimatedSprite2D")
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	crab.play("Idle")

func _physics_process(delta):
	velocity.y += gravity * delta
	if chase == true:
		if crab.animation != "Death":
			crab.play("Walk")
			player = get_node("../../Player/Player")
			
			var direction = (player.position - self.position).normalized()
			if direction.x > 0:
				crab.flip_h = true
			else:
				crab.flip_h = false
			velocity.x = direction.x * SPEED
	else:
		if crab.animation != "Death":
			crab.play("Idle")
		velocity.x = 0
	move_and_slide()
	
func _on_player_detection_body_entered(body):
	if body.name == "Player":
		chase = true
		

func _on_player_detection_body_exited(body):
	if body.name == "Player":
		chase = false

	
func _on_player_death_body_entered(body):
	if body.name == "Player":
		death()


func _on_player_collision_body_entered(body):
	if body.name == "Player":
		Game.playerHP -= 1
		death()
		
func death():
	Game.playerGold += 3
	Utils.saveGame()
	velocity.x = 0
	chase = false
	crab.play("Death")
	await crab.animation_finished
	self.queue_free()
	Game.playerXP +=3


func _on_player_collision_body_exited(_body):
	pass


func _on_bullet_collision_body_entered(body):
	if body.is_in_group("bullets"):
		body.queue_free()
		body.remove_from_group("bullets")
		death()
