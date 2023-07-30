"
A GIDealTest is a test class for testing the behavior of GIDeal
"
Class {
	#name : #GIDealTest,
	#superclass : #TestCase,
	#category : #'GuessIt-Tests'
}

{ #category : #tests }
GIDealTest >> test01validation [
	| hand1 hand2 restCard |
	hand1 := GIHand cards: ((1 to: 4) collect: [ :num | GICard number: num ]).
	hand2 := GIHand cards: ((4 to: 7) collect: [ :num | GICard number: num ]).
	restCard := GICard number: 9.
	self should: [ GIDeal hand1: hand1 hand2: hand2 restCard: restCard ] raise: AssertionFailure
]
