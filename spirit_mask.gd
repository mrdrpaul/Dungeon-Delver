extends RigidBody2D

@export var healthComponent : EntityHealthBar
var IS_DEAD = false

func _ready() -> void:
	$Sprite2D.flip_h= true
	healthComponent.died.connect(perish)
	$AnimatedSprite2D.hide()
	#$HitBox.body_entered.connect(_on_body_entered)
	
func perish():
	$AnimatedSprite2D.show()
	IS_DEAD = true
	#call_deferred("set_process_mode", PROCESS_MODE_DISABLED)	
	$AnimatedSprite2D.play("death")
	
	
	
func _on_animated_sprite_2d_animation_finished() -> void:
	if IS_DEAD:
		queue_free()
