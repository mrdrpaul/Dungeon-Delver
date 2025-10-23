extends RigidBody2D

@export var healthComponent : EntityHealthBar

func _ready() -> void:
	$Sprite2D.flip_h = true;
	healthComponent.died.connect(perish)
	$HitBox.body_entered.connect(_on_body_entered)
	#healthComponent.max_health = 400
	healthComponent.set_max_health(400)
	#healthComponent.health = 400

func _on_body_entered(body: Node) -> void:
	if body is Player:
		body.get_hit()

func perish():
	call_deferred("set_process_mode", PROCESS_MODE_DISABLED)	
