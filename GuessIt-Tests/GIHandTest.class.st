"
A GIHandTest is a test class for testing the behavior of GIHand
"
Class {
	#name : #GIHandTest,
	#superclass : #TestCase,
	#category : #'GuessIt-Tests'
}

{ #category : #tests }
GIHandTest >> test01has [
	| hand |
	hand := GIHand cards: ((1 to: 4) collect: [ :num | GICard number: num ]).
	self assert: [ hand has: (GICard number: 1) ].
	self deny: [ hand has: (GICard number: 5) ].
]

{ #category : #tests }
GIHandTest >> test02validation [
	self should: [ GIHand cards: { GICard number: 1. GICard number: 2 } ] raise: AssertionFailure.
	self should: [ GIHand cards: (#(1 2 3 1) collect: [ :num | GICard number: num ]) ] raise: AssertionFailure
]
