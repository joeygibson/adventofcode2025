"
Day09 of Advent of Code 2025.
"
Class {
	#name : 'AoCDay09',
	#superclass : 'AoCBase',
	#category : 'AoC2025',
	#package : 'AoC2025'
}

{ #category : 'as yet unclassified' }
AoCDay09 >> allPairsOf: aCollection [
    | pairs |
    pairs := OrderedCollection new.
    1 to: aCollection size do: [:i |
        (i + 1) to: aCollection size do: [:j |
            pairs add: { (aCollection at: i). (aCollection at: j) } ] ].
    ^ pairs
]

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

{ #category : 'running' }
AoCDay09 >> part2: lines [

	| rectangles points areas bounds containedRectangles |
	points := lines collect: [ :line |
			          | chunks |
			          chunks := (line splitOn: ',') collect: [ :c |
				                    c asString asInteger ].
			          chunks first @ chunks second ].

	bounds := PathShape vertices: points.

	rectangles := (points cartesianProductOfLength: 2) collect: [ :pair |
		              Rectangle point: pair first point: pair second ].

	containedRectangles := rectangles select: [ :r |
		                       r corners allSatisfy: [ :c |
			                       bounds containsPoint: c ] ].

	areas := (containedRectangles collect: [ :r | r area ]) sorted: [ :a :b |
		         a >= b ].

	^ areas first
]
