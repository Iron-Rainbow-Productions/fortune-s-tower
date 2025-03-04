extends Node2D
class_name  Card

signal spare_used
signal deck_ready


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
@onready var animation_player_2 = $AnimationPlayer2

@onready var burner = $burner
@onready var burntimer = $burntimer
@onready var revealtimer = $sparetimer
@onready var savetimer = $savetimer

@onready var cardstates = [cardback__bg,one__bg,two__bg,
three__bg,four__bg,five__bg,six__bg,
seven__bg,hero__bg,burn__fg]

@export var card:int = 0
@export var tower_coordinates = [0,0]
@export var target_pos:Vector2
@export var postion_cache: Vector2
@export var rotation_cache: float
@export var z_cache: int
var burnt = false

#Core Functions
func _ready():
	turn_off()
	postion_cache = position
	rotation_cache = rotation
	z_cache = z_index

func _process(delta):
	if self.position == Vector2(0,-335):
		deck_ready.emit()




#custom Funcs
func set_Card(cardID):
	card = cardID

func reveal_Card():
	cardstates[card].visible = true
	animation_player.play("Flip")

func hide_Card():
	if !cardback__bg.visible: 
		animation_player.play("unflip")
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

func go_Deck():
	var card_tween = get_tree().create_tween()
	card_tween.tween_property(self,"position",Vector2(0,-335),tower_coordinates[1]*.1)

func pickup_Deck():
	var deck_tween = get_tree().create_tween()
	deck_tween.tween_property(self,"rotation",0, .1)
	deck_tween.parallel().tween_property(self,"position",Vector2(0,-335),.2)
	deck_tween.parallel().tween_property(self,"scale",Vector2(.2,.2),.2)
	print("Deck in pos")

func go_center():
	var card_tween = get_tree().create_tween()
	card_tween.tween_property(self,"position",Vector2(0,0),1)

func shuffle_anim():
	var card_tween = get_tree().create_tween()
	card_tween.tween_property(self,"position",Vector2(randi_range(-200,200),randi_range(-350,350)),randf_range(.3,.75))
	card_tween.tween_property(self,"position",Vector2(0,0),1)

func ready_deck():
	var card_tween = get_tree().create_tween()
	card_tween.tween_property(self,"position",Vector2(0,-335),1)

func distribute():
	var card_tween = get_tree().create_tween()
	card_tween.tween_property(self,"position",postion_cache,tower_coordinates[1]*.1)


func shuffle_Signals():
	if self.position == Vector2(0,-335):
		if card == 0:
			deck_ready.emit()
		else:
			pass


#Signal Functions
func _on_burntimer_timeout():
	animation_player.play("burn")

func _on_spare_timeout():
	reveal_Card()
	animation_player_2.play("use_Spare")
	spare_used.emit()

func _on_savetimer_timeout():
	animation_player_2.play("Save")
	print("Save animation done")
