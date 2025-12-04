"
Day04 of Advent of Code 2025.
"
Class {
	#name : 'AoCDay04',
	#superclass : 'AoCBase',
	#category : 'AoC2025',
	#package : 'AoC2025'
}

{ #category : 'as yet unclassified' }
AoCDay04 >> findPaperRolls: grid [

	| keys |
	keys := OrderedCollection new.

	1 to: grid width do: [ :x |
			1 to: grid height do: [ :y |
			(grid at: x @ y) = '@' ifTrue: [ keys add: x @ y ] ] ].

	^ keys
]

{ #category : 'running' }
AoCDay04 >> part1: lines [

	| grid rolls accessibleRolls width height |
	grid := self parseToGridAsStrings: lines.
	width := grid width.
	height := grid height.

	rolls := self findPaperRolls: grid.

	accessibleRolls := rolls select: [ :roll |
			                   | neighbors |
			                   neighbors := roll eightNeighbors select: [
					                                :neighbor |
					                                (neighbor
						                                 isWithinWidth: width
						                                 height: height) and: [
						                                (grid at: neighbor) = '@' ] ].

			                   neighbors size < 4 ].

	^ accessibleRolls size
]
