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
@onready var revealtimer = $revealtimer
@onready var animation_player_2 = $AnimationPlayer2


@onready var cardstates = [cardback__bg,one__bg,two__bg,
three__bg,four__bg,five__bg,six__bg,
seven__bg,hero__bg,burn__fg]

var card:int = 0
@export var target_pos:Vector2

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

func replace_Card():
	for x in cardstates:
		x.visible = false

func use_Spare(target_card:Card):
	var tween = get_tree().create_tween()
	
	tween.tween_property(self,"position", self.position + Vector2(0,0), 1)
	revealtimer.start()
	
	tween.tween_property(self,"position", self.position - Vector2(0,100), .5)
	tween.parallel().tween_property(self,"z_index", 16, 2)
	
	tween.tween_property(self,"z_index", target_card.z_index,.5)
	tween.parallel().tween_property(self,"position",target_card.position,.5)
	tween.parallel().tween_property(target_card,"z_index",target_card.z_index-1,.5)


func burn():
	burntimer.start()

func turn_off():
	burner.emitting = false

func _on_burntimer_timeout():
	animation_player.play("burn")


func _on_revealtimer_timeout():
	reveal_Card()
	animation_player_2.play("use_Spare")
