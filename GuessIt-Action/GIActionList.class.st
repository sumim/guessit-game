Class {
	#name : #GIActionList,
	#superclass : #Object,
	#instVars : [
		'askActions',
		'guessActions'
	],
	#category : #'GuessIt-Action'
}

{ #category : #'instance creation' }
GIActionList class >> availableActionsWithHand: hand prevAction: prevAction [
	"手番プレイヤーの手札と直前の行動から
	選択可能な行動の一覧を生成して返す"

	| askActions guessActions |
	askActions := GICard allCards asSet collect: [ :card | GIAskAction -> card ].
	guessActions := Set new.

	prevAction ifNotNil: [
		askActions remove: prevAction.
		guessActions addAll:
			((GICard allCards difference: hand cards) collect: [ :card | GIGuessAction -> card ]) ].

	^ self new setAskActions: askActions guessActions: guessActions; yourself
]

{ #category : #accessing }
GIActionList >> allActions [
	^ askActions, guessActions
]

{ #category : #accessing }
GIActionList >> askActions [
	"質問の一覧を返す"
	^ askActions
]

{ #category : #accessing }
GIActionList >> guessActions [
	"推測の一覧を返す"
	^ guessActions
]

{ #category : #testing }
GIActionList >> includes: action [
	"指定された行動が一覧に含まれるか返す"
	^ self allActions includes: action
]

{ #category : #printing }
GIActionList >> printOn: stream [
	"行動の一覧を表現する文字列を与えられたストリームに追加する"
	stream print: self allActions
]

{ #category : #initialization }
GIActionList >> setAskActions: newAskActions guessActions: newGuessActions [
	"行動の一覧を初期化する"
	askActions := newAskActions.
	guessActions := newGuessActions
]
