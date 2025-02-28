extends Node2D
class_name  Card

#Connections
@onready var one__bg = $one__bg
@onready var two__bg = $two__bg
@onready var three__bg = $three__bg
@onready var four__bg = $four__bg
@onready var five__bg = $five__bg
@onready var six__bg = $six__bg
@onready var hero__bg = $hero__bg
@onready var seven__bg = $seven__bg
@onready var burn__fg = $burn__fg
@onready var cardback__bg = $cardback__bg

#Array
@onready var cardstates = [cardback__bg,one__bg,two__bg,
three__bg,four__bg,five__bg,six__bg,
seven__bg,hero__bg,burn__fg]

#utility
@onready var turn = 0


#Core Functions
func _ready():
	for x in cardstates:
		x.visible = false
	cardback__bg.visible = true


func _process(delta):
	pass
