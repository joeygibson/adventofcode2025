"
Day01 of Advent of Code 2025.
"
Class {
	#name : 'AoCDay01',
	#superclass : 'AoCBase',
	#category : 'AoC2025',
	#package : 'AoC2025'
}

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

	| instructions zeros current |
	current := 50.
	zeros := 0.

	instructions := self parseLines: lines.

	instructions do: [ :line |
			| dir clicks tmp |
			dir := line first.
			clicks := self normalizeClicks: (line second).

			dir = $L ifTrue: [ clicks := clicks negated ].

			tmp := current + clicks.
			
			tmp < 0
				ifTrue: [ tmp := tmp + 100 ]
				ifFalse: [ tmp > 99 ifTrue: [ tmp := tmp - 100 ] ].

			tmp = 0 ifTrue: [ zeros := zeros + 1 ].

			current := tmp ].

	^ zeros
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
