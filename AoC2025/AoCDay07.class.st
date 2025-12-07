"
Day07 of Advent of Code 2025.
"
Class {
	#name : 'AoCDay07',
	#superclass : 'AoCBase',
	#category : 'AoC2025',
	#package : 'AoC2025'
}

{ #category : 'running' }
AoCDay07 >> part1: lines [

	| grid start splitters beams splits width height seen |
	grid := self parseToGridAsStrings: lines.
	width := grid width.
	height := grid height.
	start := (grid selectKeysForValuesMatching: [ :each | each = 'S' ])
		         first.
	splitters := grid selectKeysForValuesMatching: [ :each | each = '^' ].
	splits := 0.
	seen := Set new.
	beams := OrderedCollection with: start.

	[ beams isNotEmpty ] whileTrue: [
			| beam |
			beam := beams removeFirst.
			(beam isWithinWidth: width height: height) ifTrue: [
					(seen includes: beam) ifFalse: [
							seen add: beam.

							(grid at: beam) = '^'
								ifTrue: [
										splits := splits + 1.
										beams add: beam + (-1 @ 0).
										beams add: beam + (1 @ 0) ]
								ifFalse: [ beams add: beam + (0 @ 1) ] ] ] ].


	^ splits
]

{ #category : 'running' }
AoCDay07 >> part1a: lines [

	| grid start splitters beams liveBeams splits width height |
	grid := self parseToGridAsStrings: lines.
	width := grid width.
	height := grid height.
	start := (grid selectKeysForValuesMatching: [ :each | each = 'S' ])
		         first.
	splitters := grid selectKeysForValuesMatching: [ :each | each = '^' ].
	splits := 0.

	beams := OrderedCollection with: (TachyonBeam at: start).

	liveBeams := beams select: [ :each | each live ].

	[ liveBeams isNotEmpty ] whileTrue: [
			liveBeams do: [ :beam |
					| nextCoord floorTile |
					nextCoord := beam coord + (0 @ 1).

					(nextCoord isWithinWidth: width height: height)
						ifTrue: [
								floorTile := grid at: nextCoord.
								floorTile = '.'
									ifTrue: [ beam coord: nextCoord ]
									ifFalse: [
											| adjCoord |
											splits := splits + 1.
											beam live: false.

											{ -1. 1 } do: [ :c |
													adjCoord := nextCoord + (c @ 0).

													(beams anySatisfy: [ :each | each coord = adjCoord ])
														ifFalse: [ beams add: (TachyonBeam at: adjCoord) ] ] ] ]
						ifFalse: [ beam live: false ] ].
			liveBeams := beams select: [ :each | each live ] ].

	^ splits
]

{ #category : 'running' }
AoCDay07 >> part2: lines [

	| grid start width height solver |
	grid := self parseToGridAsStrings: lines.
	width := grid width.
	height := grid height.
	start := (grid selectKeysForValuesMatching: [ :each | each = 'S' ])
		         first.

	solver := self memoize: [ :p |
			          p y >= height
				          ifTrue: [ 1 ]
				          ifFalse: [
						          (grid at: p) = '^'
							          ifTrue: [
							          (solver value: p + (-1 @ 0))
							          + (solver value: p + (1 @ 0)) ]
							          ifFalse: [ solver value: p + (0 @ 1) ] ] ].
	^ solver value: start
]

{ #category : 'running' }
AoCDay07 >> part2a: lines [

	| grid start splitters width height timelines |
	timelines := OrderedCollection new.
	grid := self parseToGridAsStrings: lines.
	width := grid width.
	height := grid height.
	start := (grid selectKeysForValuesMatching: [ :each | each = 'S' ])
		         first.
	splitters := grid selectKeysForValuesMatching: [ :each | each = '^' ].


	timelines add: {
			(OrderedCollection with: start).
			Set new }.

	[ timelines isNotEmpty ] whileTrue: [
			timelines do: [ :timelineAndSeen |
					| timeline seen |
					timeline := timelineAndSeen first.
					seen := timelineAndSeen second.

					[ timeline isNotEmpty ] whileTrue: [
							| beam |
							beam := timeline removeFirst.
							(beam isWithinWidth: width height: height) ifTrue: [
									(seen includes: beam) ifFalse: [
											seen add: beam.

											(grid at: beam) = '^'
												ifTrue: [
														| newTimeline newTimelineAndSeen |
														newTimelineAndSeen := timelineAndSeen copy.
														newTimeline := newTimelineAndSeen first.
														newTimeline add: beam + (1 @ 0).
														timelines add: newTimelineAndSeen.

														timeline add: beam + (-1 @ 0) ]
												ifFalse: [ timeline add: beam + (0 @ 1) ] ] ] ] ] ].


	^ timelines size
]
