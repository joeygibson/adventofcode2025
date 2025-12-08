"
Day08 of Advent of Code 2025.
"
Class {
	#name : 'AoCDay08',
	#superclass : 'AoCBase',
	#category : 'AoC2025',
	#package : 'AoC2025'
}

{ #category : 'running' }
AoCDay08 >> part1: lines iterations: iterations [

	| boxes combos distances circuits sortedCircuits |
	boxes := lines collect: [ :line |
		         (line splitOn: ',') collect: [ :num | num asInteger ] ].
	circuits := Set withAll:
		            (boxes collect: [ :point | Set with: point ]).

	combos := OrderedCollection new.
	1 to: boxes size do: [ :i |
			i + 1 to: boxes size do: [ :j |
					combos add: {
							(boxes at: i).
							(boxes at: j) } ] ].

	distances := (combos collect: [ :combo |
			              | a b distance |
			              a := combo first.
			              b := combo second.

			              distance := ((a first - b first) squared
			                           + (a second - b second) squared
			                           + (a third - b third) squared) sqrt.
			              {
				              a.
				              b.
				              distance } ]) sorted: [ :a :b | a third <= b third ].

	(distances first: iterations) do: [ :dist |
		self processPair: dist withCircuits: circuits ].

	sortedCircuits := circuits sorted: [ :a :b | a size >= b size ].
	^ (sortedCircuits first: 3)
		  inject: 1
		  into: [ :acc :circuit | acc * circuit size ]
]

{ #category : 'running' }
AoCDay08 >> part2: lines [

	| boxes combos distances circuits penultimate ultimate |
	boxes := lines collect: [ :line |
		         (line splitOn: ',') collect: [ :num | num asInteger ] ].
	circuits := Set withAll:
		            (boxes collect: [ :point | Set with: point ]).

	combos := OrderedCollection new.
	penultimate := nil.
	ultimate := nil.

	1 to: boxes size do: [ :i |
			i + 1 to: boxes size do: [ :j |
					combos add: {
							(boxes at: i).
							(boxes at: j) } ] ].

	distances := (combos collect: [ :combo |
			              | a b distance |
			              a := combo first.
			              b := combo second.

			              distance := ((a first - b first) squared
			                           + (a second - b second) squared
			                           + (a third - b third) squared) sqrt.
			              {
				              a.
				              b.
				              distance } ]) sorted: [ :a :b | a third <= b third ].
	distances do: [ :dist |
			circuits size = 1 ifFalse: [
					penultimate := dist first.
					ultimate := dist second.

					self processPair: dist withCircuits: circuits ] ].

	^ penultimate first * ultimate first
]

{ #category : 'as yet unclassified' }
AoCDay08 >> processPair: pair withCircuits: circuits [

	| a b existingCircuits |
	a := pair first.
	b := pair second.

	existingCircuits := circuits select: [ :circuit |
		                    (circuit includes: a) or: (circuit includes: b) ].

	existingCircuits size = 1
		ifTrue: [
				existingCircuits
					add: a;
					add: b ]
		ifFalse: [
				| combinedCircuit |
				combinedCircuit := existingCircuits
					                   inject: Set new
					                   into: [ :acc :each | acc union: each ].
				circuits removeAll: existingCircuits.
				circuits add: combinedCircuit ]
]
