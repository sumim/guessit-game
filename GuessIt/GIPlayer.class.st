Class {
	#name : #GIPlayer,
	#superclass : #Object,
	#instVars : [
		'name',
		'hand'
	],
	#category : #'GuessIt-Player'
}

{ #category : #examples }
GIPlayer class >> example01manualHuman [
	"self example01manualHuman"
	| dealer deal hand1 hand2  human randomAI availableActions action |
	dealer := GIDealer seed: 1.
	deal := dealer deal. "=> { hand1 -> #(4 5 8 9). hand2 -> #(2 3 6 7). restCard -> Card(1) } "
	hand1 := deal hand1.
	hand2 := deal hand2.
	
	human := GIHumanPlayer name: 'human' hand: hand1.
	randomAI := GIRandomAI name: 'random' hand: hand2 seed: 1.
	
	action := nil.
	
	Transcript class allInstances ifEmpty: [ Transcript open ].

	availableActions := GIActionList availableActionsWithHand: hand1 prevAction: action.
	action := human selectActionWith: availableActions.
	Transcript cr; crShow: human name, ' select: ', action printString.
	
	availableActions := GIActionList availableActionsWithHand: hand2 prevAction: action.
	[ (action := randomAI selectActionWith: availableActions) command == #ask ] whileFalse.
	Transcript cr; crShow: randomAI name, ' select: ', action printString.
	
	availableActions := GIActionList availableActionsWithHand: hand1 prevAction: action.
	action := human selectActionWith: availableActions.
	Transcript cr; crShow: human name, ' select: ', action printString.
]

{ #category : #examples }
GIPlayer class >> example02autoHuman [
	"self example02autoHuman"
	| dealer deal hand1 hand2 terminal human randomAI availableActions action |
	dealer := GIDealer seed: 1.
	deal := dealer deal. "=> { hand1 -> #(4 5 8 9). hand2 -> #(2 3 6 7). restCard -> Card(1) } "
	hand1 := deal hand1.
	hand2 := deal hand2.
	
	terminal := GITerminal in: 'ask 2\guess 1' withCRs readStream.
	human := GIHumanPlayer name: 'human' hand: hand1 terminal: terminal.
	
	randomAI := GIRandomAI name: 'random' hand: hand2.
	
	action := nil.
	
	Transcript class allInstances ifEmpty: [ Transcript open ].

	availableActions := GIActionList availableActionsWithHand: hand1 prevAction: action.
	action := human selectActionWith: availableActions.
	Transcript cr; crShow: human name, ' select: ', action printString.
	
	availableActions := GIActionList availableActionsWithHand: hand2 prevAction: action.
	[ (action := randomAI selectActionWith: availableActions) command == #ask ] whileFalse.
	Transcript cr; crShow: randomAI name, ' select: ', action printString.
	
	availableActions := GIActionList availableActionsWithHand: hand1 prevAction: action.
	action := human selectActionWith: availableActions.
	Transcript cr; crShow: human name, ' select: ', action printString.
]

{ #category : #'instance creation' }
GIPlayer class >> name: newName hand: hand [
	^ self new setName: newName hand: hand; yourself
]

{ #category : #accessing }
GIPlayer >> name [
	"プレイヤーの名前を返す"
	^ name
]

{ #category : #accessing }
GIPlayer >> selectActionWith: availableActions [
	"プレイヤーに行動を選択させて返す"
	self subclassResponsibility 
]

{ #category : #initialization }
GIPlayer >> setName: newName hand: newHand [
	"プレイヤーを初期化する"
	name := newName.
	hand := newHand
]
