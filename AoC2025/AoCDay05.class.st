"
Day05 of Advent of Code 2025.
"
Class {
	#name : 'AoCDay05',
	#superclass : 'AoCBase',
	#category : 'AoC2025',
	#package : 'AoC2025'
}

{ #category : 'running' }
AoCDay05 >> part1: lines [

	| freshIngredientRanges available blankLinePos freshVeggies |
	blankLinePos := lines asOrderedCollection position: [ :line |
		                line trimmed isEmpty ].

	freshIngredientRanges := (lines first: blankLinePos - 1) collect: [
			                         :line |
			                         | numbers |
			                         numbers := line splitOn: '-'.
			                         numbers first asInteger to:
			                         numbers second asInteger ].

	available := (lines allButFirst: blankLinePos) collect: [ :line |
		             line asInteger ].

	freshVeggies := available select: [ :id |
		                freshIngredientRanges anySatisfy: [ :range |
			                range includes: id ] ].
	^ freshVeggies size
]
