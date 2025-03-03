extends Node2D

class_name Tower

var turn = 1
var burnt = false
var spare_there = true
var activescore = 0
var good_save = false
var reburn = true


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
	shuffle_Deck()
	deal_Deck()

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
	activescore = calc_score(turn-1)
	if activescore != 0:
		Game_Dealer.rowgood.emit()
	else:
		Game_Dealer.gameover.emit()

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


#REWRITE THIS SHYTE IMMEDIATELY
func calc_burn(row):
	var address=0
	if row == 0 or row == 1:
		pass
	else:
		match turn:
			2:
				for x in row3:
					if x == row3[0]:
						if x.card == row2[0].card:
							x.burn()
							if !calc_save(x, row3, 2):
								burnt = true
								if !spare_there and good_save:
									if card_1.card == row2[0].card:
										burntimer.start()
								return
					elif x == row3[len(row3)-1]:
						if x.card == row2[1].card:
							x.burn()
							if !calc_save(x, row3,2):
								burnt = true
								if !spare_there and good_save:
									if card_1.card == row2[1].card:
										burntimer.start()
									return
					else:
						for y in row2:
							if x.card == y.card:
								x.burn()
								if !calc_save(x, row3,2):
									burnt = true
									if !spare_there and good_save:
										if card_1.card == y.card and reburn:
											reburn = false
											burntimer.start()
										return
			3:
				for x in row4:
					if x == row4[0]:
						address += 1
						if x.card == row3[0].card:
							x.burn()
							if !calc_save(x, row4,3):
								burnt = true
								if !spare_there and good_save:
									if card_1.card == row3[0].card and reburn:
										reburn = false
										burntimer.start()
									return
					elif x == row4[len(row4)-1]:
						if x.card == row3[len(row3)-1].card:
							x.burn()
							if !calc_save(x, row4,3):
								burnt = true
								if !spare_there and good_save:
									if ca
									if card_1.card == row3[len(row3)-1].card and reburn:
										reburn = false
										burntimer.start()
									return
					else:
						if row4[address].card == row3[address-1].card or row4[address].card == row3[address].card:
							row4[address].burn()
							if !calc_save(x, row4,3):
								burnt = true
								if !spare_there and good_save:
									if card_1.card == row3[address-1].card or card_1.card == row3[address].card and reburn:
										reburn = false
										burntimer.start()
									return
						address += 1
			4:
				for x in row5:
					if x == row5[0]:
						address += 1
						if x.card == row4[0].card:
							x.burn()
							if !calc_save(x, row5,3):
								burnt = true
								if card_1.card == row4[0].card and reburn:
									reburn = false
									burntimer.start()
								return
					elif x == row5[len(row5)-1]:
						if x.card == row4[len(row4)-1].card:
							if !calc_save(x, row5,3):
								burnt = true
								if !spare_there and good_save:
									if card_1.card == row4[len(row4)-1].card and reburn:
										reburn = false
										burntimer.start()
									return
					else:
						if row5[address].card == row4[address-1].card or row5[address].card == row4[address].card:
							row5[address].burn()
							if !calc_save(x, row5,3):
								burnt = true
								if !spare_there and good_save:
									if card_1.card == row4[address-1].card or card_1.card == row4[address].card and reburn:
										reburn = false
										burntimer.start()
									return
						address += 1
			5:
				for x in row6:
					if x == row6[0]:
						address += 1
						if x.card == row5[0].card:
							x.burn()
							if !calc_save(x, row6,5):
								burnt = true
								if !spare_there and good_save:
									if card_1.card == row5[0].card and reburn:
										reburn = false
										burntimer.start()
									return
					elif x == row6[len(row6)-1]:
						if x.card == row5[len(row5)-1].card:
							x.burn()
							if !calc_save(x, row6,5):
								burnt = true
								if !spare_there and good_save:
									if card_1.card == row5[len(row5)-1].card and reburn:
										reburn = false
										burntimer.start()
									return
					else:
						if row6[address].card == row5[address-1].card or row6[address].card == row5[address].card:
							row6[address].burn()
							if !calc_save(x, row6,5):
								burnt = true
								if !spare_there and good_save:
									if card_1.card == row5[address-1].card or card_1.card == row5[address].card and reburn:
										reburn = false
										burntimer.start()
									return
						address += 1
			6:
				for x in row7:
					if x == row7[0]:
						address += 1
						if x.card == row6[0].card:
							x.burn()
							if !calc_save(x, row7,6):
								burnt = true
								if !spare_there and good_save:
									if card_1.card == row6[0].card and reburn:
										reburn = false
										burntimer.start()
									return
					elif x == row7[len(row7)-1]:
						if x.card == row6[len(row6)-1].card:
							x.burn()
							if !calc_save(x, row7,6):
								burnt = true
								if !spare_there and good_save:
									if card_1.card == row6[len(row6)-1].card and reburn:
										reburn = false
										burntimer.start()
									return
					else:
						if row7[address].card == row6[address-1].card or row7[address].card == row6[address].card:
							row7[address].burn()
							if !calc_save(x, row7,6):
								burnt = true
								if !spare_there and good_save:
									if card_1.card == row6[address-1].card or card_1.card == row6[address].card and reburn:
										reburn = false
										burntimer.start()
									return
						address += 1
			7:
				for x in row8:
					if x == row8[0]:
						address += 1
						if x.card == row7[0].card:
							x.burn()
							if !calc_save(x, row8,7):
								burnt = true
								if !spare_there and good_save:
									if card_1.card == row7[0].card and reburn:
										reburn = false
										burntimer.start()
									return
					elif x == row8[len(row8)-1]:
						if x.card == row7[len(row7)-1].card:
							x.burn()
							if !calc_save(x, row8,7):
								burnt = true
								if !spare_there and good_save:
									if card_1.card == row7[len(row7)-1].card and reburn:
										reburn = false
										burntimer.start()
									return
					else:
						if row8[address].card == row7[address-1].card or row8[address].card == row7[address].card:
							row8[address].burn()
							if !calc_save(x, row8,7):
								burnt = true
								if !spare_there and good_save:
									if card_1.card == row7[address-1].card or card_1.card == row7[address].card and reburn:
										reburn = false
										burntimer.start()
									return
						address += 1
	turn +=1

func calc_save(card_id:Card, row, row_num):
	var crd = card_1.card
	
	for x in row:
		if x.card == 8:
			return true
	if spare_there == true:
		spare_there = false
		good_save = true
		card_id.cardback__bg.visible = true
		card_id.card = crd
		card_1.use_Spare(card_id)
		calc_burn(row_num)
		turn -= 1

		return true
	else:
		return false

func _on_burntimer_timeout():
	card_1.burn()
