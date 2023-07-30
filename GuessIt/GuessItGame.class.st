Class {
	#name : #GuessItGame,
	#superclass : #Object,
	#instVars : [
		'deal',
		'player1',
		'player2',
		'observers'
	],
	#category : #'GuessIt-Game'
}

{ #category : #examples }
GuessItGame class >> battleAI: repeatCount type1: type1 type2: type2 [
	"self battleAI: 1000 type1: #random type2: #random "
	| winCount1 winCount2 terminal dealer typeDic player1 player2 deal game view  winPlayer winRate1 winRate2 |
	winCount1 := winCount2 := 0.
	terminal := GITerminal new.
	view := GIGameView terminal: terminal.
	dealer := GIDealer new.
	typeDic := { #human -> GIHumanPlayer . #random -> GIRandomAI. #smart -> GISmartAI } as: Dictionary.
	
	1 to: repeatCount do: [ :i |
		deal := GIDealer new deal.
		
		player1 := (typeDic at: type1) name: 'human' hand: deal hand1.
		player2 := (typeDic at: type2) name: 'randam' hand: deal hand2.
		
		game := GuessItGame deal: deal player1: player1 player2: player2.
		
		repeatCount <= 10 ifTrue: [ game addObserver: view ].
		{ type1. player1. type2. player2 } pairsDo: [ :type :player | type == #smart ifTrue: [ game addObserver: player ] ].
		
		winPlayer := game start.
		winPlayer ifNil: [ self inform: 'Game stoped.'. ^ self ].
		Transcript crShow: '[', i printString, '/', repeatCount printString, '] ', winPlayer name, ' win.'.
		winPlayer == player1
			ifTrue: [ winCount1 := winCount1 + 1 ]
			ifFalse: [ winCount2 := winCount2 + 1 ].
		{ type1. player1. type2. player2 } pairsDo: [ :type :player | type == #smart ifTrue: [ game removeObserver: player ] ].
	].
	winRate1 := winCount1 * 100.0 / repeatCount.
	winRate2 := winCount2 * 100.0 / repeatCount.
	Transcript crShow: 'Player1 (', type1, '): ', winRate1 printString, '%'.
	Transcript crShow: 'Player2 (', type2, '): ', winRate2 printString, '%'
]

{ #category : #'instance creation' }
GuessItGame class >> deal: deal player1: player1 player2: player2 [
	^ self new setDeal: deal player1: player1 player2: player2; yourself
]

{ #category : #examples }
GuessItGame class >> example01autoHumanVsAutoHuman [
	"self example01autoHumanVsAutoHuman"
	| dealer deal terminal1 human1 terminal2 human2 terminal game view winPlayer |
	dealer := GIDealer seed: 1.
	deal := dealer deal. "=> { hand1 -> #(4 5 8 9). hand2 -> #(2 3 6 7). restCard -> Card(1) } "
	
	terminal1 := GITerminal in: 'ask 2\guess 1' withCRs readStream.
	human1 := GIHumanPlayer name: 'player1' hand: deal hand1 terminal: terminal1.
	terminal2 := GITerminal in: 'ask 4' readStream.
	human2 := GIHumanPlayer name: 'player2' hand: deal hand2 terminal: terminal2.
	
	terminal := GITerminal new.
	view := GIGameView terminal: terminal.
	game := GuessItGame deal: deal player1: human1 player2: human2.
	game addObserver: view.
	winPlayer := game start.
	winPlayer ifNil: [ self inform: 'Game stoped.'. ^ self ].
	Transcript cr; crShow: winPlayer name, ' win.'	
]

{ #category : #examples }
GuessItGame class >> example02humanVsRandomAI [
	" self example02humanVsRandomAI "
	| dealer deal human randomAI terminal game view winPlayer |
	dealer := GIDealer seed: 1.
	deal := dealer deal. "=> { hand1 -> #(4 5 8 9). hand2 -> #(2 3 6 7). restCard -> Card(1) } "
	
	human := GIHumanPlayer name: 'human' hand: deal hand1.
	randomAI := GIRandomAI name: 'randam' hand: deal hand2.
	
	terminal := GITerminal new.
	view := GIGameView terminal: terminal.
	game := GuessItGame deal: deal player1: human player2: randomAI.
	game addObserver: view.
	winPlayer := game start.
	winPlayer ifNil: [ self inform: 'Game stoped.'. ^ self ].
	Transcript cr; crShow: winPlayer name, ' win.'	
]

{ #category : #examples }
GuessItGame class >> example03repeat1000randomVsRandom [
	"self example03repeat1000randomVsRandom"
	self battleAI: 1000 type1: #random type2: #random
]

{ #category : #examples }
GuessItGame class >> example04repeat1000smartVsRandom [
	"self example04repeat1000smartVsRandom"
	self battleAI: 1000 type1: #smart type2: #random
]

{ #category : #examples }
GuessItGame class >> example05repeat1000randomVsSmart [
	"self example05repeat1000randomVsSmart"
	self battleAI: 1000 type1: #random type2: #smart
]

{ #category : #examples }
GuessItGame class >> example06repeat1000smartVsSmart [
	"self example06repeat1000smartVsSmart"
	self battleAI: 1000 type1: #smart type2: #smart
]

{ #category : #examples }
GuessItGame class >> example07repeat10humanVsSmart [
	"self example07repeat10humanVsSmart"
	self battleAI: 10 type1: #human type2: #smart
]

{ #category : #accessing }
GuessItGame >> addObserver: observer [
	"オブザーバを追加する"
	^ observers add: observer
]

{ #category : #accessing }
GuessItGame >> deal [
	^ deal
]

{ #category : #notifications }
GuessItGame >> notifyAskPlayer: player action: action hit: isHitOrNot [
	observers do: [ :observer | observer playerAsked: player action: action hit: isHitOrNot ]
]

{ #category : #notifications }
GuessItGame >> notifyGuessPlayer: player action: action hit: isHitOrNot [
	observers do: [ :observer | observer playerGuessed: player action: action hit: isHitOrNot ]
]

{ #category : #accessing }
GuessItGame >> player1 [
	^ player1
]

{ #category : #accessing }
GuessItGame >> player2 [
	^ player2
]

{ #category : #accessing }
GuessItGame >> removeObserver: observer [
	"オブザーバを取り除く"
	^ observers remove: observer ifAbsent: []
]

{ #category : #initialization }
GuessItGame >> setDeal: newDeal player1: newPlayer1 player2: newPlayer2 [
	deal := newDeal.
	player1 := newPlayer1.
	player2 := newPlayer2.
	observers := Set new.
]

{ #category : #'game starting' }
GuessItGame >> start [
	| turnPlayer turnHand opponentPlayer opponentHand restCard action winPlayer |
	turnPlayer := self player1.
	turnHand := self deal hand1.
	opponentPlayer := self player2.
	opponentHand := self deal hand2.
	restCard := self deal restCard.
	
	action := nil.
	[	| availableActions isHit |
		availableActions := GIActionList availableActionsWithHand: turnHand prevAction: action.
		action := turnPlayer selectActionWith: availableActions.
		action ifNil: [ self inform: 'Exit game.'. ^ nil ].
		
		action command == #ask
			ifTrue: [
				isHit := action isHitIn: opponentHand.
				self notifyAskPlayer: turnPlayer action: action hit: isHit ]
			ifFalse: [
				isHit := action isHitOn: restCard.
				self notifyGuessPlayer: turnPlayer action: action hit: isHit.
				winPlayer := isHit ifTrue: [ turnPlayer ] ifFalse: [ opponentPlayer ].
				^ winPlayer ].
	
		turnPlayer := opponentPlayer flag: (opponentPlayer := turnPlayer).
		turnHand := opponentHand flag: (opponentHand := turnHand)
	] repeat
]
