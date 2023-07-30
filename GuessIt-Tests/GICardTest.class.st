"
A GICardTest is a test class for testing the behavior of GICard
"
Class {
	#name : #GICardTest,
	#superclass : #TestCase,
	#category : #'GuessIt-Tests'
}

{ #category : #tests }
GICardTest >> test01allCards [
	| allCardNumber |
	allCardNumber := GICard allCards collect: #number.
	self assert: (GICard minNumber to: GICard maxNumber) asArray equals: allCardNumber
]

{ #category : #tests }
GICardTest >> test02compairing [
	| card11 card12 card2 |
	card11 := GICard number: 1.
	card12 := GICard number: 1.
	card2 := GICard number: 2.
	self assert: card11 equals: card12.
	self deny: card11 equals: card2.
	self deny: card12 equals: card2
]

{ #category : #tests }
GICardTest >> test03validation [
	self should: [ GICard number: GICard minNumber - 1 ] raise: AssertionFailure.
	self should: [ GICard number: GICard maxNumber + 1 ] raise: AssertionFailure
]
