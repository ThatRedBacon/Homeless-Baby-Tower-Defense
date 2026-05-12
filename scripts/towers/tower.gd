extends Node2D

@export var fireRate: float = 2.0
@export var range: float = 300.0

# Color(r, g, b, a) with parameters between 0-1
@export var radiusColor = Color(0.5, 0.5, 1, 0.2)
@export var radiusBorderColor = Color(0.3, 0.3, 1, 0.8)
@export var radiusBorderWidth = 3.0

var cooldown: float = 0.0
var target = null
var isSelected = false

@onready var attackArea = $AttackArea
@onready var attackShape = $AttackArea/CollisionShape2D
@onready var rangeIndicator = $RangeIndicator

# tower fires on its designated target
func shoot():
	if target == null:
		return
	
	print("Firing...")
	target.takeDamage(1)

# radius draw function
func _draw():
	if not isSelected:
		return
	
	draw_circle(Vector2.ZERO, range, radiusColor)
	
	draw_arc(
		Vector2.ZERO,
		range,
		0,
		TAU,
		64,
		radiusBorderColor,
		radiusBorderWidth
	)

# syncs displayed and actual attack range
func updateRange():
	var shape = attackShape.shape
	
	if shape is CircleShape2D:
		shape.radius = range
	
	queue_redraw()

# called when user clicks tower. changes tower radius visibility
func selectTower():
	isSelected = !isSelected
	queue_redraw()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	updateRange()
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
