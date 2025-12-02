"
Day02 of Advent of Code 2025.
"
Class {
	#name : 'AoCDay02',
	#superclass : 'AoCBase',
	#category : 'AoC2025',
	#package : 'AoC2025'
}

{ #category : 'running' }
AoCDay02 >> part1: lines [

	| invalidIds ranges |
	ranges := (lines first splitOn: ',') collect: [ :str |
			          | numbers start end |
			          numbers := (str copyReplaceAll: '-' with: ' ')
				                     extractAllNumbers.
			          start := numbers first.
			          end := numbers second.

			          start to: end ].

	invalidIds := ranges flatCollect: [ :range | self validateIds: range ].
	
	^ invalidIds asSet sum
]

{ #category : 'as yet unclassified' }
AoCDay02 >> validateIds: ids [
	"| mods |
	mods := { 11. 101. 10101. 1010101 }.

	^ ids select: [ :id | mods anySatisfy: [ :mod | id \\ mod = 0 ] ]"

	^ ids select: [ :id |
			  | str |
			  str := id asString.

			  str size odd
				  ifTrue: [ false ]
				  ifFalse: [
						  | pivot |
						  pivot := str size // 2.
						  (str first: pivot) = (str allButFirst: pivot) ] ]
]
