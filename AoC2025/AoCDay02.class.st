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

	| ids invalidIds |
	ids := (lines first copyReplaceAll: '-' with: ' ') extractAllNumbers.

	invalidIds := self validateIds: ids.
	
	^invalidIds sum.
]

{ #category : 'as yet unclassified' }
AoCDay02 >> validateIds: ids [

	| mods |
	mods := { 11. 101. 10101. 1010101. 101010101 }.

	^ ids select: [ :id | mods anySatisfy: [ :mod | id \\ mod = 0 ] ]
]
