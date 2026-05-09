extends PathFollow2D

@export var speed: float = 100.0
@export var damage: int = 1

signal reachedEnd

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress += speed * delta
	
	if progress_ratio >= 1.0:
		reachedEnd.emit()
		queue_free()
