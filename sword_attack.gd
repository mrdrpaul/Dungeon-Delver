extends Node2D

@export var player : Player
var player_direction = 1
var last_player_direction = 1
var IS_ATTACKING = false
var current_player_direction = 1
var IS_NEW_ATTACK = true

func _ready():
	player.attack.connect(show_attack)
	player.attack_finished.connect(hide_attack)
	$SwordContainer/CollisionShape2D.disabled = true
	$SwordContainer.rotation = deg_to_rad(-95)
	$SwordContainer.hide()

func _process(_delta):
	if not $SwordContainer.visible:return
	current_player_direction = player.player_direction
	
	if current_player_direction != last_player_direction and IS_ATTACKING and !IS_NEW_ATTACK:
		var rotation_amount = rad_to_deg($SwordContainer.rotation)*2
		if current_player_direction < last_player_direction:
			$SwordContainer.rotation += deg_to_rad(rotation_amount)
		elif current_player_direction > last_player_direction:
			$SwordContainer.rotation -= deg_to_rad(rotation_amount)
	else:
		IS_NEW_ATTACK = false
		
	
	if current_player_direction == 1:
		last_player_direction = 1
		if rad_to_deg($SwordContainer.rotation) < 0:
			$SwordContainer.rotate(deg_to_rad(1.6))
		elif rad_to_deg($SwordContainer.rotation) < 135:
			$SwordContainer.rotate(deg_to_rad(4))
	elif current_player_direction == -1:
		last_player_direction = -1
		if rad_to_deg($SwordContainer.rotation) > 0:
			$SwordContainer.rotate(deg_to_rad(-1.6))
		elif rad_to_deg($SwordContainer.rotation) > -135:
			$SwordContainer.rotate(deg_to_rad(-4))
	

func show_attack():
	if IS_ATTACKING: return;
	IS_ATTACKING = true
	player_direction = player.player_direction
	if player_direction == 1:
		$SwordContainer.rotation = deg_to_rad(-95)
	elif player_direction == -1:
		$SwordContainer.rotation = deg_to_rad(95)
	$SwordContainer/CollisionShape2D.disabled = false
	$SwordContainer.show()

func hide_attack():
	IS_ATTACKING = false
	IS_NEW_ATTACK = true
	#$SwordContainer.rotation = deg_to_rad(-95)
	$SwordContainer/CollisionShape2D.disabled = true
	$SwordContainer.hide()
