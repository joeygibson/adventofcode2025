"
Day11 of Advent of Code 2025.
"
Class {
	#name : 'AoCDay11',
	#superclass : 'AoCBase',
	#instVars : [
		'nodes'
	],
	#category : 'AoC2025',
	#package : 'AoC2025'
}

{ #category : 'as yet unclassified' }
AoCDay11 >> countPathsFrom: start to: target [

	^ self countPathsFrom: start to: target visited: Set new.
	
]

{ #category : 'as yet unclassified' }
AoCDay11 >> countPathsFrom: current to: target visited: visited [

	| paths |
	current = target ifTrue: [ ^ 1 ].

	(visited includes: current) ifTrue: [ ^ 0 ].

	visited add: current.

	paths := (nodes at: current ifAbsent: [ #(  ) ]) collect: [ :neighbor |
		         self
			         countPathsFrom: neighbor
			         to: target
			         visited: visited copy ].

	^ paths ifNotEmpty: [ paths sum ] ifEmpty: [ 0 ]
]

{ #category : 'running' }
AoCDay11 >> part1: lines [

	nodes := Dictionary new.

	lines do: [ :line |
			| chunks src srcName |
			chunks := line splitOn: ':'.

			srcName := chunks first.

			src := nodes at: srcName ifAbsentPut: OrderedCollection new.

			(chunks second trimBoth splitOn: ' ') do: [ :dest |
					src add: dest.
					(nodes includesKey: dest) ifFalse: [
						nodes at: dest put: OrderedCollection new ] ] ].

	^ self countPathsFrom: 'you' to: 'out'
]
