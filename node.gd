extends Node

class_name Health


@export var max_health: int = 100 : set = _set_max

signal health_changed(current:int, max:int)
signal died
#@export var player : Player
@export var entity_with_health : LivingEntity
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	entity_with_health.healthChanged.connect(update_health)
	update_health()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func update_health():
	value = entity_with_health.health
