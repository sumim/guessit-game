Class {
	#name : #GIGuessAction,
	#superclass : #GIAction,
	#category : #'GuessIt-Action'
}

{ #category : #accessing }
GIGuessAction >> command [
	^ #guess
]

{ #category : #testing }
GIGuessAction >> isHitOn: targetCard [
	"推測したカードがターゲットである残りのカードと一致するか返す"
	^ self card = targetCard
]
