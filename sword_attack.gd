extends Node2D

@export var player : Player

func _ready():
	player.attack.connect(show_attack)
	player.attack_finished.connect(hide_attack)
	$SwordContainer/CollisionShape2D.disabled = true
	$SwordContainer.rotation = deg_to_rad(-95)
	$SwordContainer.hide()

func _process(_delta):
	if not $SwordContainer.visible:return
	if rad_to_deg($SwordContainer.rotation) < 0:
		$SwordContainer.rotate(deg_to_rad(1.6))
	elif rad_to_deg($SwordContainer.rotation) < 135:
		$SwordContainer.rotate(deg_to_rad(4))

func show_attack():
	$SwordContainer/CollisionShape2D.disabled = false
	$SwordContainer.show()

func hide_attack():
	$SwordContainer.rotation = deg_to_rad(-95)
	$SwordContainer/CollisionShape2D.disabled = true
	$SwordContainer.hide()
