extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sprite2D.flip_h = true;
	$HitBox.body_entered.connect(_on_body_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node) -> void:
	if body.has_method("get_hit"):
		body.get_hit()
