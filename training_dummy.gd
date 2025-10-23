extends CharacterBody2D

@export var healthComponent : EntityHealthBar

func _ready():
	healthComponent.died.connect(perish)

func hurt():
	print("ouch")

func perish():
	call_deferred("set_process_mode", PROCESS_MODE_DISABLED)	



func isdead() -> void:
	print("dead")
	pass
	#if area == $HitBox: return
	#$HitBox.set_deferred("monitorable",false)
	#print("hitbox entered")
	#if area is Node2D:
		#print("area is ", area)
