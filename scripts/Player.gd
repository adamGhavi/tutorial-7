extends KinematicBody

export var walk_speed = 10.0
export var sprint_speed = 20
export var crouch_speed = 5
var speed = 10

var stamina = 100
var stamina_max = stamina

export var acceleration = 5
export var gravity = 0.98

export var jump_power_normal = 30.0
export var jump_power_crouch = 32.0
var jump_power = 30

export var mouse_sensitivity = 0.3

onready var head = $Head
onready var camera = $Head/Camera
onready var head_ystart = head.translation.y

var velocity = Vector3()
var camera_x_rotation = 0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		head.rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))

		var x_delta = event.relative.y * mouse_sensitivity
		if camera_x_rotation + x_delta > -90 and camera_x_rotation + x_delta < 90:
			camera.rotate_x(deg2rad(-x_delta))
			camera_x_rotation += x_delta

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	speed = walk_speed
	jump_power = jump_power_normal
		
	if Input.is_action_pressed("sprint"):
		if (stamina > 0):
			speed = sprint_speed
			stamina -= 1
		
	else:
		stamina += .1
		
	print(stamina)
	
	stamina = clamp(stamina, 0, stamina_max)
	
	if Input.is_action_pressed("crouch") and is_on_floor():
		speed = crouch_speed
		jump_power = jump_power_crouch
		head.translation.y = head_ystart - 1
	else:
		head.translation.y = head_ystart
	

func _physics_process(delta):
	var head_basis = head.get_global_transform().basis
	
	var movement_vector = Vector3()
	if Input.is_action_pressed("movement_forward"):
		movement_vector -= head_basis.z
	if Input.is_action_pressed("movement_backward"):
		movement_vector += head_basis.z
	if Input.is_action_pressed("movement_left"):
		movement_vector -= head_basis.x
	if Input.is_action_pressed("movement_right"):
		movement_vector += head_basis.x
	
	movement_vector = movement_vector.normalized()
	
	var new_velocity = velocity.linear_interpolate(movement_vector * speed, acceleration * delta)
	new_velocity.y = velocity.y
	
	velocity = new_velocity	
	velocity.y -= gravity
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y += jump_power
	
	velocity = move_and_slide(velocity, Vector3.UP)
