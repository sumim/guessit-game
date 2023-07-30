Class {
	#name : #GICard,
	#superclass : #Magnitude,
	#instVars : [
		'number'
	],
	#classVars : [
		'MaxNumber',
		'MinNumber'
	],
	#category : #'GuessIt-Card'
}

{ #category : #'instance creation' }
GICard class >> allCards [
	"すべてのカードを生成して返す"
	^ (MinNumber to: MaxNumber) collect: [ :num | self number: num ]
]

{ #category : #'class initialization' }
GICard class >> initialize [
	"GICard initialize"
	MinNumber := 1.
	MaxNumber := 9
]

{ #category : #accessing }
GICard class >> maxNumber [
	^ MaxNumber
]

{ #category : #accessing }
GICard class >> minNumber [
	^ MinNumber
]

{ #category : #'instance creation' }
GICard class >> number: number [
	^ self new setNumber: number; yourself
]

{ #category : #comparing }
GICard >> < other [
	"カードの大小比較"
	^ self number < other number
]

{ #category : #comparing }
GICard >> = other [
	"カードが同じか返す"
	^ (other isMemberOf: self class) and: [ other number = self number ]
]

{ #category : #comparing }
GICard >> hash [
	"カードのハッシュ値を返す"
	^ self class name hash + number hash
]

{ #category : #accessing }
GICard >> number [
	"カードの数字を返す"
	^ number 
]

{ #category : #printing }
GICard >> printOn: stream [
	"カードを表現する文字列を与えられたストリームに追加する"
	stream nextPutAll: 'Card('; print: number; nextPutAll: ')'
]

{ #category : #initialization }
GICard >> setNumber: newNumber [
	"カードを初期化する
	不正な値の場合はAssertionFailure"
	self assert: [ newNumber between: MinNumber and: MaxNumber ].
	number := newNumber
]
