extends Node
class_name HurtBox

signal damage_taken

@export var area2D: Area2D


func _ready()->void:
	area2D.area_entered.connect(collision)
	
func collision()->void:
	damage_taken.emit(25)
