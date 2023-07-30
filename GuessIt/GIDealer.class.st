Class {
	#name : #GIDealer,
	#superclass : #Object,
	#instVars : [
		'randomState',
		'random'
	],
	#category : #'GuessIt-Card'
}

{ #category : #'instance creation' }
GIDealer class >> new [
	^ super new setRandomState: nil; yourself
]

{ #category : #'instance creation' }
GIDealer class >> seed: randomState [
	^ self new setRandomState: randomState; yourself
]

{ #category : #dealing }
GIDealer >> deal [
	"ディーラーにランダムにカードを配らせて
	ディールを生成して返す"
	| shuffledCards hand1 hand2 restCard |
	shuffledCards := GICard allCards asOrderedCollection shuffleBy: random.
	hand1 := GIHand cards: (shuffledCards removeFirst: 4).
	hand2 := GIHand cards: (shuffledCards removeFirst: 4).
	restCard := shuffledCards removeFirst.
	self assert: [ shuffledCards isEmpty ].
	^ GIDeal hand1: hand1 hand2: hand2 restCard: restCard
]

{ #category : #initialization }
GIDealer >> setRandomState: newRandomState [
	"ディーラーを初期化する"
	randomState isNil 
		ifTrue: [ randomState := (random := Random new) seed ]
		ifFalse: [ random := Random seed: (randomState := newRandomState) ]
]
