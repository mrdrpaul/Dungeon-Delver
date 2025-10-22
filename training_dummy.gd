extends Area2D
#extends LivingEntity

#class_name LivingEntity

#signal healthChanged


#@export var max_health: float = 100
#var health : float = max_health
@export var healthComponent : HealthBar

func _ready():
	healthComponent.died.connect(perish)

func isdead():
	print("Training Dummy has Died")
	pass

func perish():
	process_mode = ProcessMode.PROCESS_MODE_DISABLED
