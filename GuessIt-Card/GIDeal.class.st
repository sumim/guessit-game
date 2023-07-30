Class {
	#name : #GIDeal,
	#superclass : #Object,
	#instVars : [
		'hand1',
		'hand2',
		'restCard'
	],
	#category : #'GuessIt-Card'
}

{ #category : #examples }
GIDeal class >> example [
	| hand1 hand2  restCard deal |
	hand1 := GIHand cards: (#(1 5 7 8) collect: [ :num | GICard number: num ]).
	hand2 := GIHand cards: (#(2 4 6 9) collect: [ :num | GICard number: num ]).
	restCard := GICard number: 3.
	deal := GIDeal hand1: hand1 hand2: hand2 restCard: restCard.
	
	Transcript class allInstances ifEmpty: [ Transcript open ].
	Transcript crShow: deal hand1 printString.
	Transcript crShow: deal hand2 printString.
	Transcript crShow: deal restCard printString
]

{ #category : #'instance creation' }
GIDeal class >> hand1: hand1 hand2: hand2 restCard: restCard [
	^ self new setHand1: hand1 hand2: hand2 restCard: restCard; yourself
]

{ #category : #accessing }
GIDeal >> hand1 [
	"先手の手札を返す"
	^ hand1
]

{ #category : #accessing }
GIDeal >> hand2 [
	"後手の手札を返す"
	^ hand2
]

{ #category : #printing }
GIDeal >> printOn: stream [
	stream
		nextPutAll: '{ hand1 -> ';
		print: hand1;
		nextPutAll: '. hand2 -> ';
		print: hand2;
		nextPutAll: '. restCard -> ';
		print: restCard;
		nextPutAll: ' }'
]

{ #category : #accessing }
GIDeal >> restCard [
	"残ったカードを返す"
	^ restCard
]

{ #category : #initialization }
GIDeal >> setHand1: newHand1 hand2: newHand2 restCard: newRestCard [
	"ディールを初期化する
	手札や残ったカードが不正な場合はAssertionFailure"
	
	| usedCardSet allCardSet |
	usedCardSet := (newHand1 cards , newHand2 cards, { newRestCard }) asSet.
	allCardSet := GICard allCards asSet.
	self assert: [ usedCardSet = allCardSet ].
	
	hand1 := newHand1.
	hand2 := newHand2.
	restCard := newRestCard
	
]
