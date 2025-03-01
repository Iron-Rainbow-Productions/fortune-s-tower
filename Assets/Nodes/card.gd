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
@onready var animation_player = $AnimationPlayer
@onready var burner = $burner
@onready var burntimer = $burntimer


@onready var cardstates = [cardback__bg,one__bg,two__bg,
three__bg,four__bg,five__bg,six__bg,
seven__bg,hero__bg,burn__fg]

var card:int = 0

#Core Functions
func _ready():
	turn_off()

func _process(delta):
	pass

#custom Funcs
func set_Card(cardID):
	card = cardID

func reveal_Card():
	cardstates[card].visible = true
	animation_player.play("Flip")

func hide_Card():
	cardstates[0].visible = true
	cardstates[card].visible = true

func burn():
	burntimer.start()

func turn_off():
	burner.emitting = false

func _on_burntimer_timeout():
	animation_player.play("burn")
