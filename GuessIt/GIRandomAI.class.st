Class {
	#name : #GIRandomAI,
	#superclass : #GIPlayer,
	#instVars : [
		'random',
		'seed'
	],
	#category : #'GuessIt-Player'
}

{ #category : #'instance creation' }
GIRandomAI class >> name: newName hand: hand [
	^ (super name: newName hand: hand) setSeed: nil; yourself
]

{ #category : #'instance creation' }
GIRandomAI class >> name: newName hand: hand seed: randomState [
	^ (super name: newName hand: hand) setSeed: randomState; yourself
]

{ #category : #accessing }
GIRandomAI >> selectActionWith: availableActions [
	"プレイヤーに行動を選択させて返す"
	^ availableActions allActions atRandom: random
]

{ #category : #initialization }
GIRandomAI >> setSeed: newRandomState [
	newRandomState
		ifNil: [ seed := (random := Random new) seed ]
		ifNotNil: [ random := Random seed: (seed := newRandomState) ]
]
