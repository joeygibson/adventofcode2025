"
Day01 of Advent of Code 2025.
"
Class {
	#name : 'AoCDay01',
	#superclass : 'AoCBase',
	#instVars : [
		'index',
		'zeroCount'
	],
	#category : 'AoC2025',
	#package : 'AoC2025'
}

{ #category : 'adding' }
AoCDay01 >> addAZero [
	self zeroCount: self zeroCount + 1.
]

{ #category : 'accessing' }
AoCDay01 >> index [

	^ index
]

{ #category : 'accessing' }
AoCDay01 >> index: anObject [

	index := anObject
]

{ #category : 'as yet unclassified' }
AoCDay01 >> normalizeClicks: clicks [

	^ clicks \\ 100.
]

{ #category : 'parsing' }
AoCDay01 >> parseLines: lines [
	^ lines collect: [ :line | 
		{ line first.
			line allButFirst asInteger }
		 ]
]

{ #category : 'running' }
AoCDay01 >> part1: lines [

	| instructions |
	self index: 50.
	self zeroCount: 0.

	instructions := self parseLines: lines.

	instructions do: [ :line |
			| dir clicks newIndex|
			dir := line first.
			clicks := self normalizeClicks: (line second).
			
			dir = $L ifTrue: [ clicks := clicks negated ].
			newIndex := (self index + clicks).
			
			newIndex < 0 ifTrue: [ newIndex := newIndex + 100 ].
			newIndex > 99 ifTrue: [ newIndex := newIndex - 100 ].
			
			self index: newIndex.
			self index = 0 ifTrue: [ self addAZero ].
			
		].

	^ self zeroCount
]

{ #category : 'as yet unclassified' }
AoCDay01 >> part2: lines [

	| instructions zeros current |
	current := 50.
	zeros := 0.

	instructions := self parseLines: lines.

	instructions do: [ :line |
			| dir clicks roundTrips remainingClicks tmp |
			dir := line first.
			clicks := line second.

			roundTrips := clicks // 100.
			remainingClicks := clicks \\ 100.

			zeros := zeros + roundTrips.

			dir = $L ifTrue: [ remainingClicks := remainingClicks negated ].

			tmp := current + remainingClicks.
			
			tmp < 0
				ifTrue: [
						tmp := tmp + 100.
						current ~= 0 ifTrue: [ zeros := zeros + 1 ] ]
				ifFalse: [
						tmp > 99
							ifTrue: [
									tmp := tmp - 100.
									current ~= 0 ifTrue: [ zeros := zeros + 1 ] ]
							ifFalse: [ tmp = 0 ifTrue: [ zeros := zeros + 1 ] ] ].



			current := tmp ].




	^ zeros
]

{ #category : 'accessing' }
AoCDay01 >> zeroCount [

	^ zeroCount
]

{ #category : 'accessing' }
AoCDay01 >> zeroCount: anObject [

	zeroCount := anObject
]
