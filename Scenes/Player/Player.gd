extends Node2D

onready var PlayerCam = $Camera2D
onready var BlackWheel = $BlackWheel/Wheel
onready var WhiteWheel = $WhiteWheel/Wheel
onready var ScreenSize = get_viewport_rect().size

export var ZoomSpeed = 0.25
var MinZoom = 0.5
var MaxZoom = 5
var ZoomMargin = Vector2(400, 200)

var Connected = true

func _process(delta):
	PlaceCamera(delta)

func PlaceCamera(delta):
	var blackPos = BlackWheel.get_global_position()
	var whitePos = WhiteWheel.get_global_position()
	var vec = blackPos - whitePos
	var dist = vec.length() / 80.0
	var averagePos = whitePos + (vec * 0.5)
	
	PlayerCam.set_position(averagePos)
	
	var r = Rect2(blackPos, Vector2.ONE).expand(whitePos)
	r = r.grow_individual(ZoomMargin.x, ZoomMargin.y, ZoomMargin.x, ZoomMargin.y)
	var d = max(r.size.x, r.size.y)
	var z = 0.1
	if r.size.x > r.size.y * ScreenSize.aspect():
		z = clamp(r.size.x / ScreenSize.x, MinZoom, MaxZoom)
	else:
		z = clamp(r.size.y / ScreenSize.y, MinZoom, MaxZoom)
	PlayerCam.zoom  = lerp(PlayerCam.zoom, Vector2.ONE * z, ZoomSpeed)

func _input(event):
	if Connected and event.is_action_pressed("Switch"):
		Connected = false
		$BlackWheel/PinJoint2D.call_deferred("queue_free")
		$WhiteWheel/PinJoint2D.call_deferred("queue_free")
