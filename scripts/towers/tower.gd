extends Node2D

@export var fireRate: float = 2.0
@export var range: float = 150.0

var cooldown: float = 0.0
var target = null
var isSelected = false

@onready var attackArea = $AttackArea
@onready var rangeIndicator = $RangeIndicator

# tower fires on its designated target
func shoot():
	if target == null:
		return
	
	print("Firing...")
	target.takeDamage(1)

# draws a radius around the tower when clicked on
func drawRangeIndicator():
	rangeIndicator.clear_points()
	
	var segments = 64
	for i in range(segments + 1):
		var angle = (TAU * i) / segments
		
		var point = Vector2(
			cos(angle),
			sin(angle)
		) * range
		
		rangeIndicator.add_point(point)

# called when user clicks tower. changes tower radius visibility
func selectTower():
	isSelected = !isSelected
	rangeIndicator.visible = isSelected	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	drawRangeIndicator()
	rangeIndicator.visible = false	
	print("Tower ready.")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	cooldown -= delta
	
	if target and cooldown <= 0:
		shoot()
		cooldown = 1.0 / fireRate

# designates a target when one enters its defense radius
func _on_area_2d_body_entered(body):
	if body.name == "Enemy":
		target = body

# tower clears its active target when they exit its radius
func _on_area_2d_body_exited(body):
	if body == target:
		target = null

# called when the player clicks on the tower, selecting it
func _on_click_area_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			selectTower()
