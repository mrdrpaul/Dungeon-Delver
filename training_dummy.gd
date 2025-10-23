extends CharacterBody2D
#extends LivingEntity

#class_name LivingEntity

#signal healthChanged


#@export var max_health: float = 100
#var health : float = max_health
#@export var hurt_box : HurtBox
@export var healthComponent : EntityHealthBar

func _ready():
	healthComponent.died.connect(perish)
	#hurt_box.damage_taken.connect(_on_body_entered)

func hurt():
	print("ouch")

#func isdead():
	#print("Training Dummy has Died")

func perish():
	process_mode = ProcessMode.PROCESS_MODE_DISABLED


func isdead() -> void:
	#if area == $HitBox: return
	#$HitBox.set_deferred("monitorable",false)
	print("hitbox entered")
