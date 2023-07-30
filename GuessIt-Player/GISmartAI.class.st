Class {
	#name : #GISmartAI,
	#superclass : #GIRandomAI,
	#instVars : [
		'restCards',
		'bluffCards',
		'maybeCard'
	],
	#category : #'GuessIt-Player'
}

{ #category : #accessing }
GISmartAI >> ask: askActions [
	^ (restCards intersection: (askActions collect: #card))
		ifNotEmpty: [ :filteredCard | GIAskAction ->  (filteredCard atRandom: random) ]
		ifEmpty: [ askActions atRandom: random ]
]

{ #category : #accessing }
GISmartAI >> bluffCards [
	^ bluffCards
]

{ #category : #accessing }
GISmartAI >> guessWithMaybeCard [
	^ restCards size = 1
		ifTrue: [ GIGuessAction -> restCards anyOne ]
		ifFalse: [ maybeCard ifNotNil: [ GIGuessAction -> maybeCard ] ]
]

{ #category : #initialization }
GISmartAI >> initState [
	restCards := GICard allCards asSet difference: hand cards.
	bluffCards := hand cards asSet.
	maybeCard := nil
]

{ #category : #accessing }
GISmartAI >> mayBluff [
	| bluff |
	bluff := nil.
	bluffCards
		ifNotEmpty: [
			| bluffTh |
			bluffTh := (5 - bluffCards size) / 20.
			random next <= bluffTh
				ifTrue: [ bluff := GIAskAction ->  (bluffCards atRandom: random) ] ].
	^ bluff
]

{ #category : #accessing }
GISmartAI >> mayGuess: guessActions [
	| guess |
	guess := nil.
	guessActions
		ifNotEmpty: [restCards
			ifNotEmpty: [
				| guessTh |
				guessTh := 1 / restCards size.
				random next <= guessTh
					ifTrue: [ guess := GIGuessAction ->  (restCards atRandom: random) ] ]
			ifEmpty: [
				"相手のブラフと判断したカードがブラフではなく、
				しかし相手がそのカードを推測しなかった場合、
				伏せられたカードの候補がなくなることがある
				この場合はランダムに推測する"
				guess := guessActions atRandom: random ] ].
	^ guess
]

{ #category : #accessing }
GISmartAI >> maybeCard [
	^ maybeCard
]

{ #category : #updating }
GISmartAI >> playerAsked: player action: action hit: isHitOrNot [
	"プレイヤーが質問したときに実行される"
	
	"自分が質問したときは、	
	1. ブラフならブラフに使えるカードから除外	
	2. 質問なら伏せられたカードの候補から除外	
	   そしてヒットしなかったら相手の手札にないので	
	   次に推測するカードとする	
	そうでない場合、	
	1. まず質問されたカードはブラフに使えなくなる	
	2. そしてヒットしなかった場合それは	
	   a. 相手のブラフ（相手の手札にある）	
	   b. 伏せられたカード	
	   のいずれかなので、確率で次の手を考える"
	
	player == self
		ifTrue: [ (bluffCards includes: action card)
			ifTrue: [ bluffCards remove: action card ]
			ifFalse: [
				restCards remove: action card ifAbsent: [].
				isHitOrNot ifFalse: [ maybeCard := action card ] ] ]
		ifFalse: [
			bluffCards remove: action card ifAbsent: [].
			isHitOrNot ifFalse: [
				(restCards includes: action card)
					ifTrue: [
						| notBluffTh |
						notBluffTh := 1 / restCards size.
						random next <= notBluffTh
							ifTrue: [ maybeCard := action card ]
							ifFalse: [ restCards remove: action card ifAbsent: [] ]]]]
]

{ #category : #updating }
GISmartAI >> playerGuessed: player action: action hit: isHitOrNot [
	"プレイヤーが推測したときに実行される"
	"同じゲームをできるように初期化しておく"
	self initState
]

{ #category : #accessing }
GISmartAI >> restCards [
	^ restCards
]

{ #category : #accessing }
GISmartAI >> selectActionWith: availableActions [
	"AIに行動を選択させて返す
	以下のアルゴリズムで選択する：
	1. 伏せられたカードの候補が1枚、
	　　もしくは次に推測するカードがあるなら推測する
	2. そうでない場合、推測可能なら確率で推測する
	3. 推測しない場合、可能なら確率でブラフする
	4. ブラフしない場合、単に質問する"
	
	| selected |
	selected := self guessWithMaybeCard
		ifNil: [ (self mayGuess: availableActions guessActions)
			ifNil: [ self mayBluff
				ifNil: [ self ask: availableActions askActions ] ] ].
	self assert: [ availableActions includes: selected ].
	^ selected
]

{ #category : #initialization }
GISmartAI >> setSeed: newRandomState [
	super setSeed: newRandomState.
	self initState
]
