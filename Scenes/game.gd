extends Node2D

@onready var game_board = $GameBoard
@onready var tower = $Tower

@onready var row_2__lb = $UI/Row2__lb
@onready var row_3__lb = $UI/Row3__lb
@onready var row_4__lb = $UI/Row4__lb
@onready var row_5__lb = $UI/Row5__lb
@onready var row_6__lb = $UI/Row6__lb
@onready var row_7__lb = $UI/Row7__lb
@onready var row_8__lb = $UI/Row8__lb


@onready var rows = [row_2__lb, row_3__lb, 
					row_4__lb, row_5__lb, 
					row_6__lb, row_7__lb, row_8__lb]


#UI Children
@onready var buttons = $UI/Buttons



# Called when the node enters the scene tree for the first time.
func _ready():
	#hide_Scores()
	connectUp()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func hide_Scores():
	row_2__lb.visible = false
	row_3__lb.visible = false
	row_4__lb.visible = false
	row_5__lb.visible = false
	row_6__lb.visible = false
	row_7__lb.visible = false
	row_8__lb.visible = false

func connectUp():
	Game_Dealer.rowgood.connect(update_Labels)
	Game_Dealer.round_end.connect(end_Round)


func update_Labels():
	var turn = tower.turn
	rows[turn-2].text = str(tower.activescore)
	rows[turn-2].visible = true


func _on_stay_pressed():
	tower._ready()

func end_Round():
	buttons.reveal.disabled = true
	buttons.stay.disabled = true


func _on_reveal_pressed():
	buttons.reveal.disabled = true
	buttons.stay.disabled = true
	tower._on_reveal_pressed()
	await get_tree().create_timer(1).timeout
	print("go")
	if tower.burnt == false and tower.turn < 8:
		buttons.reveal.disabled = false
		buttons.stay.disabled = false
