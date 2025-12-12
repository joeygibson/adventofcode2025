"
Day11 of Advent of Code 2025.
"
Class {
	#name : 'AoCDay11',
	#superclass : 'AoCBase',
	#instVars : [
		'nodes',
		'memo'
	],
	#category : 'AoC2025',
	#package : 'AoC2025'
}

{ #category : 'as yet unclassified' }
AoCDay11 >> buildNodes: lines [

	nodes := Dictionary new.

	lines do: [ :line |
			| chunks src srcName |
			chunks := line splitOn: ':'.

			srcName := chunks first.

			src := nodes at: srcName ifAbsentPut: OrderedCollection new.

			(chunks second trimBoth splitOn: ' ') do: [ :dest |
					src add: dest.
					(nodes includesKey: dest) ifFalse: [
						nodes at: dest put: OrderedCollection new ] ] ]
]

{ #category : 'running' }
AoCDay11 >> part1: lines [

	self buildNodes: lines.

	^ self
		  traverse: 'you'
		  to: 'out'
		  visited: Set new
		  scores: Dictionary new
]

{ #category : 'running' }
AoCDay11 >> part2: lines [

	| svrDac svrFft dacFft fftDac fftOut dacOut |
	self buildNodes: lines.

	svrDac := self
		          traverse: 'svr'
		          to: 'dac'
		          visited: Set new
		          scores: Dictionary new.
	svrFft := self
		          traverse: 'svr'
		          to: 'fft'
		          visited: Set new
		          scores: Dictionary new.
	dacFft := self
		          traverse: 'dac'
		          to: 'fft'
		          visited: Set new
		          scores: Dictionary new.
	fftDac := self
		          traverse: 'fft'
		          to: 'dac'
		          visited: Set new
		          scores: Dictionary new.
	fftOut := self
		          traverse: 'fft'
		          to: 'out'
		          visited: Set new
		          scores: Dictionary new.
	dacOut := self
		          traverse: 'dac'
		          to: 'out'
		          visited: Set new
		          scores: Dictionary new.


	^ svrDac * dacFft * fftOut + (svrFft * fftDac * dacOut)
]

{ #category : 'as yet unclassified' }
AoCDay11 >> traverse: current to: target visited: visited scores: scores [
	|total|
	
	current = target ifTrue: [ ^1 ].
	
	((visited includes: current) or: current = 'out') ifTrue: [ ^0 ].
	
	(scores includesKey: current) ifTrue: [ ^scores at: current ].
	
	visited add: current.
	
	total := ((nodes at: current ) collect: [ :node |
		self traverse: node to: target visited: visited scores: scores
		 ]) sum.
	
	visited remove: current.
	
	scores at: current put: total.
	
	^total
]
