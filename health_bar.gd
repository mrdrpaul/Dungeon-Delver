extends ProgressBar

@export var player : Player
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.healthChanged.connect(update_health)
	update_health()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func update_health():
	value = player.health
