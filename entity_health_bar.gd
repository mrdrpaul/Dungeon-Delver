extends ProgressBar

class_name HealthBar

signal died
@export var max_health  = 100
var health : float = max_health
@export var hurt_box : HurtBox

func _ready() -> void:
	hurt_box.damage_taken.connect(update_health)
	#player.healthChanged.connect(update_health)
	#update_health()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func update_health(healthChange : int):
	health -= healthChange
	if health <= 0:
		died.emit()
	#value = player.health
