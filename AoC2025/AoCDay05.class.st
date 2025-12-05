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

{ #category : 'running' }
AoCDay05 >> part2: lines [
	"Adapted from this Python code https://www.reddit.com/r/adventofcode/comments/1pemdwd/2025_day_5_solutions/nsgkgci/"
	| ranges blankLinePos combinedRanges newCombinedRanges |
	blankLinePos := lines asOrderedCollection position: [ :line |
		                line trimmed isEmpty ].

	ranges := (lines first: blankLinePos - 1) collect: [ :line |
			          | numbers |
			          numbers := line splitOn: '-'.
			          OrderedCollection
				          with: numbers first asInteger
				          with: numbers second asInteger ].

	combinedRanges := OrderedCollection new.

	ranges do: [ :newRange |
			| newRangeCopy |
			newCombinedRanges := OrderedCollection new.
			newRangeCopy := newRange.

			combinedRanges do: [ :range |
					(range last < newRange first or: range first > newRange last)
						ifTrue: [ newCombinedRanges add: range ]
						ifFalse: [
								newRangeCopy := OrderedCollection
									                with: (range first min: newRangeCopy first)
									                with: (range last max: newRangeCopy last) ] ].

			newCombinedRanges add: newRangeCopy.
			combinedRanges := newCombinedRanges copy ].

	^ combinedRanges
		  inject: 0
		  into: [ :acc :range | acc + (range last - range first + 1) ]
]
