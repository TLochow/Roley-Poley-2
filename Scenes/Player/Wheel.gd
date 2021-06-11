extends RigidBody2D

export(bool) var WhiteWheel = true

onready var JumpCast = $JumpCast

var RotationForce = 100.0
var JumpForce = 200.0

var UpPressed = false
var LeftPressed = false
var RightPressed = false

func _ready():
	if WhiteWheel:
		set_collision_layer_bit(1, true)
		set_collision_mask_bit(1, true)
		JumpCast.set_collision_mask_bit(1, true)
	else:
		set_collision_layer_bit(0, true)
		set_collision_mask_bit(0, true)
		JumpCast.set_collision_mask_bit(0, true)
		$Sprite.frame = 1

func _physics_process(delta):
	GetInputs()
	
	var rot = 0.0
	if LeftPressed:
		rot -= RotationForce
	if RightPressed:
		rot += RotationForce
	
	angular_velocity = clamp(angular_velocity + (rot * delta), -50.0, 50.0)
	
	JumpCast.rotation = -global_rotation
	
	if UpPressed and JumpCast.is_colliding():
		linear_velocity += Vector2(0.0, -JumpForce)

func GetInputs():
	if WhiteWheel:
		UpPressed = Input.is_action_just_pressed("WhiteUp")
		LeftPressed = Input.is_action_pressed("WhiteLeft")
		RightPressed = Input.is_action_pressed("WhiteRight")
	else:
		UpPressed = Input.is_action_just_pressed("BlackUp")
		LeftPressed = Input.is_action_pressed("BlackLeft")
		RightPressed = Input.is_action_pressed("BlackRight")
