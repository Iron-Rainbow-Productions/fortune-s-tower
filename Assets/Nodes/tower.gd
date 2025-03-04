extends Node2D

class_name Tower

signal row_done

signal cards_revealing
signal cards_burning
signal cards_Saving

var turn = 1
var burnt = Game_Dealer._burnt
var spare_there = true
var activescore = 0
var good_save = false
var reburn = true


@onready var deck = $Deck
@onready var card_1 = $Card1
@onready var card_2 = $Card2
@onready var card_3 = $Card3
@onready var card_4 = $Card4
@onready var card_5 = $Card5
@onready var card_6 = $Card6
@onready var card_7 = $Card7
@onready var card_8 = $Card8
@onready var card_9 = $Card9
@onready var card_10 = $Card10
@onready var card_11 = $Card11
@onready var card_12 = $Card12
@onready var card_13 = $Card13
@onready var card_14 = $Card14
@onready var card_15 = $Card15
@onready var card_16 = $Card16
@onready var card_17 = $Card17
@onready var card_18 = $Card18
@onready var card_19 = $Card19
@onready var card_20 = $Card20
@onready var card_21 = $Card21
@onready var card_22 = $Card22
@onready var card_23 = $Card23
@onready var card_24 = $Card24
@onready var card_25 = $Card25
@onready var card_26 = $Card26
@onready var card_27 = $Card27
@onready var card_28 = $Card28
@onready var card_29 = $Card29
@onready var card_30 = $Card30
@onready var card_31 = $Card31
@onready var card_32 = $Card32
@onready var card_33 = $Card33
@onready var card_34 = $Card34
@onready var card_35 = $Card35
@onready var card_36 = $Card36
@onready var burntimer = $burntimer



@onready var towercontent = [card_1, card_2, card_3, card_4,
							card_5, card_6, card_7, card_8, 
							card_9, card_10, card_11, card_12, 
							card_13, card_14, card_15, card_16, 
							card_17, card_18, card_19, card_20, 
							card_21, card_22, card_23, card_24, 
							card_25, card_26, card_27, card_28, 
							card_29, card_30, card_31, card_32, 
							card_33, card_34, card_35, card_36]

@onready var row1 = 							 [card_1]
@onready var row2 = 						[card_2, card_3]
@onready var row3 = 					[card_4, card_5, card_6]
@onready var row4 = 				[card_7, card_8, card_9, card_10]
@onready var row5 = 			[card_11, card_12, card_13, card_14, card_15]
@onready var row6 = 		[card_16, card_17, card_18, card_19, card_20, card_21]
@onready var row7 = 	[card_22, card_23, card_24, card_25, card_26, card_27, card_28]
@onready var row8 = [card_29, card_30, card_31, card_32, card_33, card_34, card_35, card_36]

@onready var rows =[row1, row2, row3, row4, row5, row6, row7, row8]


@export var deckselection:int = 0
var shuffleddeck = []


# Called when the node enters the scene tree for the first time.
func _ready():
	coordinate_Tower()
	shuffle_Deck()
	deal_Deck()
	deck.z_index = -1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass




func shuffle_Deck():
	shuffleddeck = Game_Dealer.deckcontents[deckselection]
	shuffleddeck.shuffle()
	shuffleddeck.shuffle()

func deal_Deck():
	var card = 0
	while card < 36:
		towercontent[card].card = shuffleddeck[card]
		towercontent[card].hide_Card()
		towercontent[card].set_Card(shuffleddeck[card])
		card +=1

func reveal_Row(row):

	if !spare_there:
		good_save = true

	match row:
		1:
			for x in row2:
				x.reveal_Card()
		2:
			for x in row3:
				x.reveal_Card()
		3:
			for x in row4:
				x.reveal_Card()
		4:
			for x in row5:
				x.reveal_Card()
		5:
			for x in row6:
				x.reveal_Card()
		6:
			for x in row7:
				x.reveal_Card()
		7:
			for x in row8:
				x.reveal_Card()

func _on_reveal_pressed():
	reveal_Row(turn)
	calc_burn(turn)
	activescore = calc_score(turn)
	turn +=1
	if activescore != 0:
		Game_Dealer.rowgood.emit()
	else:
		pass
	row_done.emit()

func calc_score(row) -> int:
	var rowscore = 0
	if burnt:
		return 0
	else:
		for x in rows[row]:
			if x.card == 8:
				rowscore = rowscore
			else:
				rowscore += x.card
		return rowscore

func calc_burn(row):
	var address = 0
	var target1:Card 
	var target2:Card
	
	match row:
		0:
			burnt = false
		1:
			burnt = false
		2:
			for card:Card in row2:
				target1 = rows[row][card.tower_coordinates[1]]
				target2 =  rows[row][card.tower_coordinates[1]+1]
				
				if card.card == target1.card:
					if target1.name == card_1.name:
						await card_1.spare_used
						card_1.burn()
					else:
						target1.burn()
					print(target1.name)
					calc_save(target1,row3,row)
				elif card.card == target2.card:
					if target2.name == card_1.name:
						await card_1.spare_used
						card_1.burn()
					else:
						target2.burn()
					print(target2.name)
					calc_save(target2,row3,row)
				


		3:
			for card in row3:
				target1 = rows[row][card.tower_coordinates[1]]
				target2 =  rows[row][card.tower_coordinates[1]+1]
				
				if card.card == target1.card:
					if target1.name == card_1.name:
						await card_1.spare_used
						card_1.burn()
					else:
						target1.burn()
					print(target1.name)
					calc_save(target1,row4,row)
				elif card.card == target2.card:
					if target2.name == card_1.name:
						await card_1.spare_used
						card_1.burn()
					else:
						target2.burn()
					print(target2.name)
					calc_save(target2,row4,row)
				

	
		4:
			for card in row4:
				target1 = rows[row][card.tower_coordinates[1]]
				target2 =  rows[row][card.tower_coordinates[1]+1]
				
				if card.card == target1.card:
					if target1.name == card_1.name:
						await card_1.spare_used
						card_1.burn()
					else:
						target1.burn()
					print(target1.name)
					calc_save(target1,row5,row)
				elif card.card == target2.card:
					if target2.name == card_1.name:
						await card_1.spare_used
						card_1.burn()
					else:
						target2.burn()
					print(target2.name)
					calc_save(target2,row5,row)

		5:
			for card in row5:
				target1 = rows[row][card.tower_coordinates[1]]
				target2 =  rows[row][card.tower_coordinates[1]+1]
				
				if card.card == target1.card:
					if target1.name == card_1.name:
						await card_1.spare_used
						card_1.burn()
					else:
						target1.burn()
					print(target1.name)
					calc_save(target1,row6,row)
				elif card.card == target2.card:
					if target2.name == card_1.name:
						await card_1.spare_used
						card_1.burn()
					else:
						target2.burn()
					print(target2.name)
					calc_save(target2,row6,row)
				

		6:
			for card in row6:
				target1 = rows[row][card.tower_coordinates[1]]
				target2 =  rows[row][card.tower_coordinates[1]+1]
				
				if card.card == target1.card:
					if target1.name == card_1.name:
						await card_1.spare_used
						card_1.burn()
					else:
						target1.burn()
					print(target1.name)
					calc_save(target1,row7,row)
				elif card.card == target2.card:
					if target2.name == card_1.name:
						await card_1.spare_used
						card_1.burn()
					else:
						target2.burn()
					print(target2.name)
					calc_save(target2,row7,row)


		7:
			for card in row7:
				target1 = rows[row][card.tower_coordinates[1]]
				target2 =  rows[row][card.tower_coordinates[1]+1]
				if card.card == target1.card:
					if target1.name == card_1.name:
						await card_1.spare_used
						card_1.burn()
					else:
						target1.burn()
					print(target1.name)
					calc_save(target1,row8,row)
				elif card.card == target2.card:
					if target2.name == card_1.name:
						await card_1.spare_used
						card_1.burn()
					else:
						target2.burn()
					print(target2.name)
					calc_save(target2,row8,row)

func calc_save(card_id:Card, row, row_num):
	var crd = card_1.card
	
	for x:Card in row:
		if x.card == 8:
			heroicAct(row,x)

			burnt = false
			return true
	if spare_there == true:
		spare_there = false
		good_save = true
		rows[row_num][card_id.tower_coordinates[1]] = card_1
		card_1.tower_coordinates = card_id.tower_coordinates
		card_id.cardback__bg.visible = true
		card_id.card = crd
		card_1.use_Spare(card_id)
		calc_burn(row_num)
		burnt = false
		return true
	else:
		burnt = true
		await get_tree().create_timer(1.5).timeout
		end_Round()
		return false

func coordinate_Tower():
	var row_address = 0
	for row in rows:
		var address = 0
		for card:Card in row:
			card.tower_coordinates[0] = row_address 
			card.tower_coordinates[1] = address 
			address += 1
		row_address += 1

func heroicAct(row, card:Card):
	card._on_savetimer_timeout()
	for x:Card in row:
		if x.card != 8:
			x.savetimer.start()

func end_Round():
	Game_Dealer.round_end.emit()
	await get_tree().create_timer(2.5).timeout
	deck.z_index = 20
	deck.pickup_Deck()
	await get_tree().create_timer(1).timeout
	for card in towercontent:
		card.hide_Card()
	await get_tree().create_timer(.75).timeout
	for card in towercontent:
		card.go_Deck()
	await get_tree().create_timer(1).timeout
	for card in towercontent:
		card.go_center()
	deck.go_center()
	await get_tree().create_timer(1).timeout
	for card in towercontent:
		card.shuffle_anim()
	await get_tree().create_timer(1.5).timeout
	deck.ready_deck()
	card_1.tower_coordinates = [0,0]
	for card:Card in towercontent:
		card.ready_deck()
		card.z_index = card.z_cache 
		if card.tower_coordinates[1] == 0:
			card.tower_coordinates = [0,.5]
	reset_Rows()
	await get_tree().create_timer(1.5).timeout
	deck.z_index = 0
	for card:Card in towercontent:
		card.distribute()
		if card.tower_coordinates[1] == .5:
			card.tower_coordinates = [0,0]
	deck.z_index = -1

func reset_Rows():
	row1 = 							 [card_1]
	row2 = 						[card_2, card_3]
	row3 = 					[card_4, card_5, card_6]
	row4 = 				[card_7, card_8, card_9, card_10]
	row5 = 			[card_11, card_12, card_13, card_14, card_15]
	row6 = 		[card_16, card_17, card_18, card_19, card_20, card_21]
	row7 = 	[card_22, card_23, card_24, card_25, card_26, card_27, card_28]
	row8 = [card_29, card_30, card_31, card_32, card_33, card_34, card_35, card_36]

func collect_Deck():
	pass
	
	
	
