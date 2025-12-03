"
Day03 of Advent of Code 2025.
"
Class {
	#name : 'AoCDay03',
	#superclass : 'AoCBase',
	#category : 'AoC2025',
	#package : 'AoC2025'
}

{ #category : 'as yet unclassified' }
AoCDay03 >> largestIn: seq between: start and: end [

	| largest largestPos |
	largest := (seq copyFrom: start to: end) max.
	largestPos := seq indexOf: largest startingAt: start.

	^ {
		  largest.
		  largestPos }
]

{ #category : 'running' }
AoCDay03 >> part1: lines [

	| banks tops |
	banks := lines collect: [ :line |
		         line asArray collect: [ :ch | ch asString asInteger ] ].


	tops := banks collect: [ :bank |
			        | res largest largestPos secondLargest |
			        res := self largestIn: bank between: 1 and: bank size - 1.
			        largest := res first.
			        largestPos := res second.
			        secondLargest := (bank
				                          copyFrom: largestPos + 1
				                          to: bank size) max.

			        res := largest asString , secondLargest asString.
			        res asInteger ].

	^ tops sum
]

{ #category : 'running' }
AoCDay03 >> part2: lines [

	| banks tops |
	banks := lines collect: [ :line |
		         line asArray collect: [ :ch | ch asString asInteger ] ].


	tops := banks collect: [ :bank |
			        | numbers pos res |
			        numbers := OrderedCollection new.
			        pos := 0.
			        1 to: 12 do: [ :i |
					        | val |
					        res := self
						               largestIn: bank
						               between: pos + 1
						               and: bank size - (12 - i).

					        val := res first.
					        pos := res second.
					        numbers add: val ].

			        res := '' join: numbers.
			        res asInteger ].

	^ tops sum
]
