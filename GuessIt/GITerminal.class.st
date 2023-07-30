Class {
	#name : #GITerminal,
	#superclass : #Object,
	#instVars : [
		'inTerminal',
		'outTerminal'
	],
	#category : #'GuessIt-Terminal'
}

{ #category : #'instance creation' }
GITerminal class >> in: inTerminal [
	^ super new setIn: inTerminal out: nil; yourself
]

{ #category : #'instance creation' }
GITerminal class >> in: inTerminal out: outTerminal [
	^ super new setIn: inTerminal out: outTerminal; yourself
]

{ #category : #'instance creation' }
GITerminal class >> new [
	^ super new setIn: nil out: nil; yourself
]

{ #category : #'instance creation' }
GITerminal class >> out: outTerminal [
	^ super new setIn: nil out: outTerminal; yourself
]

{ #category : #'stop conditions' }
GITerminal >> cr [
	(self outTerminal respondsTo: #cr) ifTrue: [ self outTerminal cr ].
	(self outTerminal respondsTo: #endEntry) ifTrue: [ self outTerminal endEntry ]
]

{ #category : #accessing }
GITerminal >> inTerminal [
	^ inTerminal
]

{ #category : #'ui requests' }
GITerminal >> infrom: msgStr [
	self inTerminal isStream
		ifTrue: [ self outTerminal cr; print:  msgStr ]
		ifFalse: [ self inTerminal inform: msgStr ]
]

{ #category : #accessing }
GITerminal >> outTerminal [
	^ outTerminal
]

{ #category : #'ui requests' }
GITerminal >> print: something [
	self outTerminal cr; nextPutAll: something asString.
	(self outTerminal respondsTo: #endEntry) ifTrue: [ self outTerminal endEntry ]
]

{ #category : #'ui requests' }
GITerminal >> request: msgStr [
	| inStrOrNil |
	self inTerminal isStream
		ifTrue: [
			self cr; print: msgStr.
			inStrOrNil := self inTerminal nextLine ]
		ifFalse: [ inStrOrNil := self inTerminal request: msgStr ].
	^ inStrOrNil
]

{ #category : #initialization }
GITerminal >> setIn: newInTerminal out: newOutTerminal [
	inTerminal := newInTerminal ifNil: [ UIManager default ].
	outTerminal := newOutTerminal ifNil: [ Transcript ]
]
