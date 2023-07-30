Class {
	#name : #GIHumanPlayer,
	#superclass : #GIPlayer,
	#instVars : [
		'terminal'
	],
	#category : #'GuessIt-Player'
}

{ #category : #'instance creation' }
GIHumanPlayer class >> name: newName hand: hand [ 
	^ (super name: newName hand: hand) setTerminal: nil; yourself
]

{ #category : #'instance creation' }
GIHumanPlayer class >> name: newName hand: hand terminal: terminal [
	^ (self name: newName hand: hand) setTerminal: terminal; yourself
]

{ #category : #accessing }
GIHumanPlayer >> informHelp: availableActions [
	| askArgs |
	askArgs := (availableActions askActions asArray collect: [ :action | action card number ]) sort.
	^ String streamContents: [ :ss |
		| guessArgs |
		ss
			nextPutAll: 'Your hand: ';
			print: hand; cr;
			nextPutAll: 'Available commands:'; cr;
			nextPutAll: '- ask '; print: askArgs.
		guessArgs := (availableActions guessActions asArray collect: [ :action | action card number ]) sort.
		guessArgs ifNotEmpty: [
			ss cr; nextPutAll: '- guess '; print: guessArgs ].
		ss cr; nextPutAll: '- exit' ]
]

{ #category : #'ui requests' }
GIHumanPlayer >> perseCommand: command args: args [
	| card |
	command == #exit ifTrue: [ ^ GIExitAction new ].
	(#(ask guess) includes: command)
		ifFalse: [ self terminal inform: 'Unknown Command: ', command. ^ nil ].
	args ifEmpty: [ self terminal inform: 'Card is not specified.'. ^ nil ].
	[ card := GICard number: args first asInteger ] on: Error do: [ :ex | self terminal inform: ex printString. ^ nil ].
	^ (command == #ask ifTrue: [ GIAskAction ] ifFalse: [ GIGuessAction ]) -> card


]

{ #category : #'ui requests' }
GIHumanPlayer >> requestCommand: msgStr [
	| inputStr |
	inputStr := self terminal request: msgStr.
	^ inputStr ifNil: [ #(exit ()) ] ifNotNil: [
		| args |
		"self terminal cr; print: self name, '> ', inputStr."
		args := inputStr substrings.
		args
			ifEmpty: [ #() ]
			ifNotEmpty: [
				| command |
				command := args first asLowercase asSymbol.
				{ command. args allButFirst } ] ]
]

{ #category : #accessing }
GIHumanPlayer >> selectActionWith: availableActions [
	"人のプレイヤーに行動を選択させて返す"
	[	| commandArgs |
		commandArgs := self requestCommand: (self informHelp: availableActions).
		commandArgs
			ifEmpty: [ self terminal inform: 'Empty Command.'. ] 
			ifNotEmpty: [ | command args action |
				command := commandArgs first.
				args := commandArgs second.
				action := self perseCommand: command args: args.
				action
					ifNil: [ self terminal infrom: 'Parse Error.'. ] 
					ifNotNil: [
						(availableActions includes: action)
							ifFalse: [
								action command == #exit ifTrue: [ ^ nil ].
								self terminal infrom: 'Unavailable action: ', action printString ]
							ifTrue: [ ^ action ] ] ]
	] repeat
]

{ #category : #initialization }
GIHumanPlayer >> setTerminal: newTerminal [
	terminal := newTerminal ifNil: [ GITerminal new ]
]

{ #category : #accessing }
GIHumanPlayer >> terminal [
	^ terminal 
]
