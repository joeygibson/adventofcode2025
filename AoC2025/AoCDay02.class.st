"
Day02 of Advent of Code 2025.
"
Class {
	#name : 'AoCDay02',
	#superclass : 'AoCBase',
	#category : 'AoC2025',
	#package : 'AoC2025'
}

{ #category : 'as yet unclassified' }
AoCDay02 >> generateRanges: lines [

	^ (lines first splitOn: ',') collect: [ :str |
			  | numbers start end |
			  numbers := (str copyReplaceAll: '-' with: ' ') extractAllNumbers.
			  start := numbers first.
			  end := numbers second.

			  start to: end ]
]

{ #category : 'testing' }
AoCDay02 >> isInvalid: id [

	| str |
	str := id asString.

	1 to: str size // 2 do: [ :i |
			| chunks sub |
			sub := str copyFrom: 1 to: i.
			chunks := str splitOn: sub.

			(chunks allSatisfy: [ :chunk | chunk isEmptyOrNil ]) ifTrue: [
				^ true ] ].

	^ false
]

{ #category : 'running' }
AoCDay02 >> part1: lines [

	| invalidIds ranges |
	ranges := self generateRanges: lines.

	invalidIds := ranges flatCollect: [ :range | self validateIds: range ].

	^ invalidIds asSet sum
]

{ #category : 'running' }
AoCDay02 >> part2: lines [

	| invalidIds ranges |
	ranges := self generateRanges: lines.

	invalidIds := ranges flatCollect: [ :range |
		              self validateIds2: range ].

	^ invalidIds asSet sum
]

{ #category : 'as yet unclassified' }
AoCDay02 >> validateIds2: ids [

	^ ids select: [ :id | self isInvalid: id ]
]

{ #category : 'as yet unclassified' }
AoCDay02 >> validateIds: ids [

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
