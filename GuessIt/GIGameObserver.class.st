Class {
	#name : #GIGameObserver,
	#superclass : #Object,
	#category : #'GuessIt-Game'
}

{ #category : #observing }
GIGameObserver >> playerAsked: player action: action hit: isHitOrNot [
	"プレイヤーが質問したときに実行される"
	self subclassResponsibility 
]

{ #category : #observing }
GIGameObserver >> playerGuessed: player action: action hit: isHitOrNot [
	"プレイヤーが推測したときに実行される"

	self subclassResponsibility
]
