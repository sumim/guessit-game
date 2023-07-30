"
A GIDealerTest is a test class for testing the behavior of GIDealer
"
Class {
	#name : #GIDealerTest,
	#superclass : #TestCase,
	#category : #'GuessIt-Tests'
}

{ #category : #tests }
GIDealerTest >> test01dealRandomly [
	| dealer deal1 deal2 |
	dealer := GIDealer seed: 1.
	
	deal1 := dealer deal. "=> { hand1 -> #(4 5 8 9). hand2 -> #(2 3 6 7). restCard -> Card(1) } "
	deal2 := dealer deal.
	
	self assert: deal1 hand1 cards equals: (#(4 5 8 9) collect: [ :num | GICard number: num ]).
	self assert: deal1 hand2 cards equals: (#(2 3 6 7) collect: [ :num | GICard number: num ]).
	self assert: deal1 restCard equals: (GICard number: 1).
	
	self deny: deal1 hand1 cards equals: deal2 hand1 cards.
	self deny: deal1 hand2 cards equals: deal2 hand2 cards.
	self deny: deal1 restCard equals: deal2 restCard
]
