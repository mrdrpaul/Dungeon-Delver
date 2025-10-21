extends CharacterBody2D

class_name Player

#signal hit
#signal abilityOne
#signal abilityTwo
signal healthChanged




const SPEED = 250.0
const JUMP_VELOCITY = -400.0
var IS_ATTACKING = false;
var IS_JUMPING = false;
var IS_JUMP_ANIM_TRIG = false
var IS_ALIVE = true;

var is_double_jump = false

@export var max_health: float = 100
var health : float = max_health

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		IS_JUMPING = true
	else:
		IS_JUMPING = false
		is_double_jump = false
	
	if Input.is_action_just_pressed("trigger_death"):
		print("dead")
		IS_ALIVE = false
		trigger_player_death()
		
	
	
	if !IS_ALIVE and is_on_floor():
		return
	
	if Input.is_action_just_pressed("jump") and (is_on_floor() or not is_double_jump) and IS_ALIVE:
		IS_JUMPING = true
		$AnimatedSprite2D.play("jump")
		if not is_on_floor() :
			$AnimatedSprite2D.play("jump")
			is_double_jump = true
		velocity.y = JUMP_VELOCITY
	
	var direction = Input.get_axis("move_left","move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x,0,SPEED)
	
	move_and_slide()
	
	$AnimatedSprite2D.flip_h = velocity.x < 0
	if Input.is_action_just_pressed("attack"):
		handle_attack(2)
	
	if velocity.x != 0 and !IS_ATTACKING and !IS_JUMPING:
		$AnimatedSprite2D.play("run")
	elif !IS_ATTACKING and !IS_JUMPING:
		$AnimatedSprite2D.play("idle")
		
func handle_attack(attackType):
	if attackType == 2:
		IS_ATTACKING = true
		$AnimatedSprite2D.play("attack_2")


func _on_animated_sprite_2d_animation_finished() -> void:
	if IS_ATTACKING:
		IS_ATTACKING = false;
		
func get_hit():
	health -=25
	healthChanged.emit()

	if self.health <= 0:
		health = max_health
		trigger_player_death()
		$ProgressBar.hide()
	else:
		print("ouch")
	
func trigger_player_death():
	print("dead")
	IS_ALIVE = false
	$AnimatedSprite2D.play("dead")
