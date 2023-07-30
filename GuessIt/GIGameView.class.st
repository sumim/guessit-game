Class {
	#name : #GIGameView,
	#superclass : #GIGameObserver,
	#instVars : [
		'terminal'
	],
	#category : #'GuessIt-Game'
}

{ #category : #'instance creation' }
GIGameView class >> terminal: terminal [
	^ self new setTerminal: terminal; yourself
]

{ #category : #updating }
GIGameView >> playerAsked: player action: action hit: isHitOrNot [
	"プレイヤーの質問内容と結果を表示する"
	self terminal cr; print: player name, ': ',  action printString.
	self terminal print: (isHitOrNot ifTrue: [ 'Hit.' ] ifFalse: [ 'Miss.' ])
]

{ #category : #updating }
GIGameView >> playerGuessed: player action: action hit: isHitOrNot [
	"プレイヤーの推測内容と結果を表示する"
	self terminal cr; print: player name, ': ', action printString.
	self terminal print: (isHitOrNot ifTrue: [ 'Hit.' ] ifFalse: [ 'Miss.' ])
]

{ #category : #initialization }
GIGameView >> setTerminal: newTerminal [
	terminal := newTerminal
]

{ #category : #accessing }
GIGameView >> terminal [
	^ terminal
]
