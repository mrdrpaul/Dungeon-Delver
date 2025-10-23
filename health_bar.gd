extends ProgressBar

@export var player : Player

func _ready() -> void:
	player.healthChanged.connect(update_health)
	update_health()

func update_health():
	value = player.health
