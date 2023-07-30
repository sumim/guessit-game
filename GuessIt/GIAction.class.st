Class {
	#name : #GIAction,
	#superclass : #Object,
	#instVars : [
		'card'
	],
	#category : #'GuessIt-Action'
}

{ #category : #'instance creation' }
GIAction class >> -> card [
	^ self new setCard: card; yourself
]

{ #category : #comparing }
GIAction >> = other [
	"質問が同じか返す"
	^ (other isMemberOf: self class)
		and: [ other command == self command 
			and: [ other card = self card ] ]
]

{ #category : #accessing }
GIAction >> card [
	"質問したカードを返す"
	^ card
]

{ #category : #accessing }
GIAction >> command [
	self subclassResponsibility
]

{ #category : #comparing }
GIAction >> hash [
	^ self command hash + self card hash 
]

{ #category : #printing }
GIAction >> printOn: stream [
	"質問を表現する文字列を与えられたストリームに追加する"
	stream
		print: self command;
		nextPutAll: ' -> ';
		print: self card number
]

{ #category : #initialization }
GIAction >> setCard: newCard [
	"質問を初期化する"
	card := newCard
]
