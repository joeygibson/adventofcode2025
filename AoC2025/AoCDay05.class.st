"
Day05 of Advent of Code 2025.
"
Class {
	#name : 'AoCDay05',
	#superclass : 'AoCBase',
	#category : 'AoC2025',
	#package : 'AoC2025'
}

{ #category : 'as yet unclassified' }
AoCDay05 >> combineRanges: ranges [
	"Adapted from this Python code https://www.reddit.com/r/adventofcode/comments/1pemdwd/2025_day_5_solutions/nsgkgci/"

	| combinedRanges newCombinedRanges |
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
]

{ #category : 'running' }
AoCDay05 >> part1: lines [

	| freshIngredientRanges available blankLinePos freshVeggies combinedRanges |
	blankLinePos := lines asOrderedCollection position: [ :line |
		                line trimmed isEmpty ].

	freshIngredientRanges := (lines first: blankLinePos - 1) collect: [
			                         :line |
			                         | numbers |
			                         numbers := line splitOn: '-'.
			                         OrderedCollection
				                         with: numbers first asInteger
				                         with: numbers second asInteger ].

	combinedRanges := self combineRanges: freshIngredientRanges.

	available := (lines allButFirst: blankLinePos) collect: [ :line |
		             line asInteger ].

	freshVeggies := available select: [ :id |
			                combinedRanges anySatisfy: [ :range |
				                id >= range first and: id <= range last ] ].
	^ freshVeggies size
]

{ #category : 'running' }
AoCDay05 >> part2: lines [

	| ranges blankLinePos combinedRanges |
	blankLinePos := lines asOrderedCollection position: [ :line |
		                line trimmed isEmpty ].

	ranges := (lines first: blankLinePos - 1) collect: [ :line |
			          | numbers |
			          numbers := line splitOn: '-'.
			          OrderedCollection
				          with: numbers first asInteger
				          with: numbers second asInteger ].

	combinedRanges := self combineRanges: ranges.

	^ combinedRanges
		  inject: 0
		  into: [ :acc :range | acc + (range last - range first + 1) ]
]
