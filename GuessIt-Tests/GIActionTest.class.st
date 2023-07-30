"
A GIActionTest is a test class for testing the behavior of GIAction
"
Class {
	#name : #GIActionTest,
	#superclass : #TestCase,
	#category : #'GuessIt-Tests'
}

{ #category : #tests }
GIActionTest >> test01askActionIsHitInHand [
	| deal ask |
	deal := (GIDealer seed: 1) deal. "=> { hand1 -> #(4 5 8 9). hand2 -> #(2 3 6 7). restCard -> Card(1) } "
	
	ask := GIAskAction -> (GICard number: 2).
	
	self assert: [ ask isHitIn: deal hand2 ]
]

{ #category : #tests }
GIActionTest >> test02guessActionisHitOnTargetCard [
	| deal guess |
	deal := (GIDealer seed: 1) deal. "=> { hand1 -> #(4 5 8 9). hand2 -> #(2 3 6 7). restCard -> Card(1) } "
	
	guess := GIGuessAction -> (GICard number: 1).
	
	self assert: [ guess isHitOn: deal restCard ]
]
