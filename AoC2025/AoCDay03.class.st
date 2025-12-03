"
Day03 of Advent of Code 2025.
"
Class {
	#name : 'AoCDay03',
	#superclass : 'AoCBase',
	#category : 'AoC2025',
	#package : 'AoC2025'
}

{ #category : 'running' }
AoCDay03 >> part1: lines [

	| banks tops |
	banks := lines collect: [ :line |
		         line asArray collect: [ :ch | ch asString asInteger ] ].


	tops := banks collect: [ :bank |
			        | largest largestPos secondLargest res |
			        largest := bank max.
			        largestPos := bank indexOf: largest.

			        largestPos = bank size ifTrue: [
					        largest := bank allButLast max.
					        largestPos := bank indexOf: largest ].

			        secondLargest := (bank
				                          copyFrom: largestPos + 1
				                          to: bank size) max.

			        res := largest asString , secondLargest asString.
			        res asInteger ].

	^ tops sum
]
