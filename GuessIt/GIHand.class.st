Class {
	#name : #GIHand,
	#superclass : #Object,
	#instVars : [
		'cards'
	],
	#category : #'GuessIt-Card'
}

{ #category : #'instance creation' }
GIHand class >> cards: cards [
	^ self new setCards: cards; yourself
]

{ #category : #accessing }
GIHand >> cards [
	"手札のカード一覧を返す"
	^ cards
]

{ #category : #accessing }
GIHand >> has: card [
	"手札に指定されたカードがあるか返す"
	^ self cards includes: card
]

{ #category : #printing }
GIHand >> printOn: stream [
	stream print: (self cards collect: #number)
]

{ #category : #initialization }
GIHand >> setCards: newCards [
	"手札を初期化する
	カードのリストが不正な場合はAssertionFailure"
	self assert: [ newCards size = 4].
	self assert: [ newCards asSet size = 4 ].
	
	cards := newCards sort
]
