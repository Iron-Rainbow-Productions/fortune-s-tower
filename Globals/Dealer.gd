extends Node

@onready var _burnt = false 


@onready var nomoreheroes  = [1,1,1,1,1,1,1,1,1,
					2,2,2,2,2,2,2,2,2,
					3,3,3,3,3,3,3,3,3,
					4,4,4,4,4,4,4,4,4,
					5,5,5,5,5,5,5,5,5,
					6,6,6,6,6,6,6,6,6,
					7,7,7,7,7,7,7,7,7]
@onready var chosenone = [1,1,1,1,1,1,1,1,
					2,2,2,2,2,2,2,2,
					3,3,3,3,3,3,3,3,
					4,4,4,4,4,4,4,4,
					5,5,5,5,5,5,5,5,
					6,6,6,6,6,6,6,6,
					7,7,7,7,7,7,7,7,
					8]
@onready var platinumdeck = [1,1,1,1,1,1,1,
					2,2,2,2,2,2,2,
					3,3,3,3,3,3,3,
					4,4,4,4,4,4,4,
					5,5,5,5,5,5,5,
					6,6,6,6,6,6,6,
					7,7,7,7,7,7,7,
					8,8,8,8]
@onready var diamonddeck = [1,1,1,1,1,1,1,1,
					2,2,2,2,2,2,2,2,
					3,3,3,3,3,3,3,3,
					4,4,4,4,4,4,4,4,
					5,5,5,5,5,5,5,5,
					6,6,6,6,6,6,6,6,
					7,7,7,7,7,7,7,7,
					8,8,8,8]
@onready var rubydeck = [1,1,1,1,1,1,1,1,1,
					2,2,2,2,2,2,2,2,2,
					3,3,3,3,3,3,3,3,3,
					4,4,4,4,4,4,4,4,4,
					5,5,5,5,5,5,5,5,5,
					6,6,6,6,6,6,6,6,6,
					7,7,7,7,7,7,7,7,7,
					8,8,8,8]
@onready var emeralddeck = [1,1,1,1,1,1,1,1,1,1,
					2,2,2,2,2,2,2,2,2,2,
					3,3,3,3,3,3,3,3,3,3,
					4,4,4,4,4,4,4,4,4,4,
					5,5,5,5,5,5,5,5,5,5,
					6,6,6,6,6,6,6,6,6,6,
					7,7,7,7,7,7,7,7,7,7,
					8,8,8,8]

@onready var deckcontents = [emeralddeck, rubydeck, diamonddeck, platinumdeck,
							nomoreheroes, chosenone]

@onready var deckscoremultipliers = [1, 2, 3, 4,
							5, 5]


#Signals

signal rowgood
signal round_end

#Functions

func _ready():
	_connectUp()



func _connectUp():
	round_end.connect(on_round_end)

func on_round_end():
	_burnt = false
	
