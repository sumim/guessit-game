Class {
	#name : #GIExitAction,
	#superclass : #GIAction,
	#category : #'GuessIt-Action'
}

{ #category : #accessing }
GIExitAction >> command [
	^ #exit
]

{ #category : #initialization }
GIExitAction >> initialize [
	card := GICard number: 1
]
