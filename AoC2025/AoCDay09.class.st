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

	rectangles := points uniquePairs collect: [ :pair |
		              Rectangle point: pair first point: pair second ].

	areas := (rectangles collect: [ :r | r inclusiveArea ]) sorted: [ :a :b |
		         a >= b ].

	^ areas first
]

{ #category : 'running' }
AoCDay09 >> part2: lines [

	| rectangles points areas bounds containedRectangles |
	points := lines collect: [ :line |
			          | chunks |
			          chunks := (line splitOn: ',') collect: [ :c |
				                    c asString asInteger ].
			          chunks first @ chunks second ].

	bounds := PathShape vertices: points.

	Transcript
		show: 'bounds';
		show: bounds bounds;
		cr.

	rectangles := points uniquePairs collect: [ :pair |
		              Rectangle point: pair first point: pair second ].

	containedRectangles := rectangles select: [ :r |
		                       r corners allSatisfy: [ :c |
			                       bounds containsPoint: c ] ].

	areas := (containedRectangles collect: [ :r | r inclusiveArea ])
		         sorted: [ :a :b | a >= b ].

	^ areas first
]
