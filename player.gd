extends CharacterBody2D
#extends LivingEntity

class_name Player
#@export class_name LivingEntity

#signal hit
#signal abilityOne
#signal abilityTwo
signal healthChanged
signal attack
signal attack_finished


var player_node : CharacterBody2D = null

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


func _ready():
	player_node = get_tree().get_first_node_in_group("Player")
	

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
		if !IS_ATTACKING:
			$AnimatedSprite2D.play("jump")
		if not is_on_floor() :
			if !IS_ATTACKING:
				$AnimatedSprite2D.play("jump")
			is_double_jump = true
		velocity.y = JUMP_VELOCITY
		
	if Input.is_action_just_pressed("drop_down"):
		print("down")
		player_node.set_collision_mask_value(5, false);
		await get_tree().create_timer(.3).timeout
		player_node.set_collision_mask_value(5, true);

	
	var direction = Input.get_axis("move_left","move_right")
	#print(direction)
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x,0,SPEED)
	
	move_and_slide()
	
	$AnimatedSprite2D.flip_h = velocity.x < 0 or direction < 0
	if Input.is_action_just_pressed("attack"):
		handle_attack(2)
	
	if velocity.x != 0 and !IS_ATTACKING and !IS_JUMPING:
		$AnimatedSprite2D.play("run")
	elif !IS_ATTACKING and !IS_JUMPING:
		$AnimatedSprite2D.play("idle")
		
func handle_attack(attackType):
	if attackType == 2 and IS_ALIVE:
		IS_ATTACKING = true
		$AnimatedSprite2D.play("attack_2")
		attack.emit()
		
	
func _on_animated_sprite_2d_animation_finished() -> void:
	if IS_ATTACKING:
		IS_ATTACKING = false;
		attack_finished.emit()
		
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
