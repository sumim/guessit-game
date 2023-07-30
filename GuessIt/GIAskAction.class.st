Class {
	#name : #GIAskAction,
	#superclass : #GIAction,
	#category : #'GuessIt-Action'
}

{ #category : #accessing }
GIAskAction >> command [
	^ #ask
]

{ #category : #testing }
GIAskAction >> isHitIn: hand [
	"質問したカードが手札にあるか返す"
	^ hand has: self card
]
