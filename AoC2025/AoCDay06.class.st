"
Day06 of Advent of Code 2025.
"
Class {
	#name : 'AoCDay06',
	#superclass : 'AoCBase',
	#category : 'AoC2025',
	#package : 'AoC2025'
}

{ #category : 'as yet unclassified' }
AoCDay06 >> extractOperators: line [

	| symbols gaps lastIndex |
	symbols := OrderedCollection new.
	gaps := OrderedCollection new.

	lastIndex := nil.

	1 to: line size do: [ :i |
			| ch |
			ch := line at: i.
			ch = Character space ifFalse: [
					symbols add: ch.
					lastIndex ifNotNil: [ gaps add: i - lastIndex - 1 ].
					lastIndex := i ] ].

	"spaces after final symbol"
	lastIndex ifNotNil: [ gaps add: line size - lastIndex + 1 ].

	symbols := symbols collect: [ :c | c asString ].

	^ symbols with: gaps collect: [ :s :g |
			  {
				  s.
				  g } ]
]

{ #category : 'running' }
AoCDay06 >> part1: lines [

	| grid ops res |
	grid := self parseToGridAsIntegers:
		        (lines allButLast collect: [ :line | line extractAllNumbers ]).

	ops := '[*+]' asRegex
		       matchesIn: lines last
		       collect: [ :c | c asString ].

	res := ops collectWithIndex: [ :op :i |
			       | startVal |
			       startVal := op = '+'
				                   ifTrue: [ 0 ]
				                   ifFalse: [ 1 ].

			       (grid atColumn: i) inject: startVal into: [ :acc :num |
					       op = '+'
						       ifTrue: [ acc + num ]
						       ifFalse: [ acc * num ] ] ].

	^ res sum
]

{ #category : 'running' }
AoCDay06 >> part2: lines [

	| grid rawGrid opsAndGaps total start columns |
	opsAndGaps := self extractOperators: lines last.

	rawGrid := lines allButLast collect: [ :line |
		           line asArray collect: [ :c | c asString ] ].

	grid := self parseToGridAsStrings: rawGrid.

	total := 0.
	start := 1.
	columns := grid columns.

	opsAndGaps do: [ :opAndGap |
			| op gap cols val initVal |
			op := opAndGap first.
			gap := opAndGap second.

			cols := columns copyFrom: start to: start + gap - 1.

			initVal := op = '+'
				           ifTrue: [ 0 ]
				           ifFalse: [ 1 ].

			val := cols inject: initVal into: [ :acc :col |
					       | num |
					       num := ('' join: col) asInteger.

					       op = '+'
						       ifTrue: [ acc + num ]
						       ifFalse: [ acc * num ] ].
			start := start + gap + 1.

			total := total + val ].

	^ total
]
