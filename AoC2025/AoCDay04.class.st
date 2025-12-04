"
Day04 of Advent of Code 2025.
"
Class {
	#name : 'AoCDay04',
	#superclass : 'AoCBase',
	#instVars : [
		'grid',
		'width',
		'height'
	],
	#category : 'AoC2025',
	#package : 'AoC2025'
}

{ #category : 'as yet unclassified' }
AoCDay04 >> findRemovableRolls: rolls [

	^ rolls select: [ :roll |
			  | neighbors |
			  neighbors := roll eightNeighbors select: [ :neighbor |
					               (neighbor isWithinWidth: width height: height)
						               and: [ (grid at: neighbor) = '@' ] ].

			  neighbors size < 4 ]
]

{ #category : 'running' }
AoCDay04 >> part1: lines [

	| rolls removableRolls |
	grid := self parseToGridAsStrings: lines.
	width := grid width.
	height := grid height.

	rolls := grid selectKeysForValuesMatching: [ :cell | cell = '@' ].

	removableRolls := self findRemovableRolls: rolls.

	^ removableRolls size
]

{ #category : 'running' }
AoCDay04 >> part2: lines [

	| rolls removableRolls removedCount |
	grid := self parseToGridAsStrings: lines.
	width := grid width.
	height := grid height.
	removedCount := 0.

	rolls := grid selectKeysForValuesMatching: [ :cell | cell = '@' ].

	removableRolls := self findRemovableRolls: rolls.

	[ removableRolls isNotEmpty ] whileTrue: [
			removedCount := removedCount + removableRolls size.

			self removeRolls: removableRolls.

			rolls := grid selectKeysForValuesMatching: [ :cell | cell = '@' ].
			removableRolls := self findRemovableRolls: rolls ].

	^ removedCount
]

{ #category : 'removing' }
AoCDay04 >> removeRolls: rolls [

	rolls do: [ :roll | grid at: roll put: 'X' ]
]
