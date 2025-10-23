extends ProgressBar

class_name EntityHealthBar

signal died
@export var max_health  = 100
var health : float = max_health
@export var hurt_box : HurtBox

func _ready() -> void:
	hurt_box.damage_taken.connect(update_health)
	value = health
	
func update_health(healthChange : int):
	health -= healthChange
	value = health
	if health <= 0:
		died.emit()
	#value = player.health
