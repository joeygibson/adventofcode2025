"
Day12 of Advent of Code 2025.
"
Class {
	#name : 'AoCDay12',
	#superclass : 'AoCBase',
	#category : 'AoC2025',
	#package : 'AoC2025'
}

{ #category : 'running' }
AoCDay12 >> part1: sections [

	| shapes regions |
	shapes := (sections allButLast collect: [ :str |
			           | id area |
			           id := str first asString asInteger.
			           area := str count: [ :c | c = $# ].
			           id -> area ]) asDictionary.

	regions := ((sections last splitOn: String lf) select: [ :line |
		            line isNotEmpty ]) select: [ :line |
			           | w h chunks dims maxArea heurArea |
			           chunks := line splitOn: ':'.
			           dims := (chunks first trimBoth splitOn: 'x') collect: [
				                   :d | d asString asInteger ].

			           w := dims first.
			           h := dims second.

			           maxArea := w * h.

			           heurArea := 0.

			           ((chunks second trimBoth splitOn: ' ') collect: [ :each |
				            each asString asInteger ]) withIndexDo: [ :curr :index |
				           heurArea := heurArea + ((shapes at: index - 1) * curr) ].
			           self halt.
			           heurArea <= maxArea ].

	^ regions size
]
