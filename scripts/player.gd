extends Area2D

export var speed = 200
var screenSize
var bulletScene = load("res://entities/bullet.tscn")

func _ready():
	screenSize = get_viewport_rect().size
	

func _process(delta):
	# Movement
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("gameRight"):
		velocity.x += 1
	if Input.is_action_pressed("gameLeft"):
		velocity.x -= 1
	if Input.is_action_pressed("gameDown"):
		velocity.y += 1
	if Input.is_action_pressed("gameUp"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

	var pos = position + (velocity * delta)
	position.x = clamp(pos.x, 0, screenSize.x)
	position.y = clamp(pos.y, 0, screenSize.y)

	# Gun controls
	$playerGun.rotation = get_local_mouse_position().angle()
	if Input.is_action_just_pressed("gameGunFire"):
		var bullet = bulletScene.instance()
		get_parent().add_child(bullet)
		bullet.set_position(position)
		bullet.set_rotation($playerGun.rotation)
