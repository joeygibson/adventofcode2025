"
Day09 of Advent of Code 2025.
"
Class {
	#name : 'AoCDay09',
	#superclass : 'AoCBase',
	#category : 'AoC2025',
	#package : 'AoC2025'
}

{ #category : 'running' }
AoCDay09 >> part1: lines [

	| rectangles points areas |
	points := lines collect: [ :line |
			          | chunks |
			          chunks := (line splitOn: ',') collect: [ :c |
				                    c asString asInteger ].
			          chunks first @ chunks second ].

	rectangles := (points cartesianProductOfLength: 2) collect: [ :pair |
		              Rectangle
			              point: pair first
			              point: pair second + (1 @ 1) ].

	areas := (rectangles collect: [ :r | r area ]) sorted: [ :a :b |
		         a >= b ].

	^ areas first
]
