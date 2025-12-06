"
Day06 of Advent of Code 2025.
"
Class {
	#name : 'AoCDay06',
	#superclass : 'AoCBase',
	#category : 'AoC2025',
	#package : 'AoC2025'
}

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
