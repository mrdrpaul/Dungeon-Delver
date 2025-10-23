extends Node
class_name HurtBox

signal damage_taken

@export var area2D: Area2D


func _ready()->void:
	#area2D.body_entered.connect(collision)
	area2D.area_entered.connect(collision)
	
func collision(body)->void:
	if body is Sword:
		print("collision entered")
		print("body is ", body.get_class())
		damage_taken.emit(25)
