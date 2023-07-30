"
A GIActionListTest is a test class for testing the behavior of GIActionList
"
Class {
	#name : #GIActionListTest,
	#superclass : #TestCase,
	#category : #'GuessIt-Tests'
}

{ #category : #tests }
GIActionListTest >> test01 [
	| deal allAsks ask1 availableActions allGuesses |
	deal := (GIDealer seed: 1) deal. "=> { hand1 -> #(4 5 8 9). hand2 -> #(2 3 6 7). restCard -> Card(1) } "
	allAsks := (GICard allCards collect: [ :card | GIAskAction -> card ]) asSet.
	ask1 := GIAskAction -> (GICard number: 1).
	
	availableActions := GIActionList availableActionsWithHand: deal hand2 prevAction: nil.
	self assert: availableActions askActions equals: allAsks.
	self assert: availableActions guessActions isEmpty.
	
	availableActions := GIActionList availableActionsWithHand: deal hand2 prevAction: ask1.
	allGuesses := (GICard allCards difference: deal hand2 cards) asSet collect: [ :card | GIGuessAction -> card ].
	self assert: availableActions askActions equals: (allAsks remove: ask1; yourself).
	self assert: availableActions guessActions equals: allGuesses.
]
