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

	| redTiles greenTiles allGreenTiles maxArea minX maxX minY maxY |
	redTiles := lines collect: [ :line |
			            | chunks |
			            chunks := (line splitOn: ',') collect: [ :c |
				                      c asString asInteger ].
			            chunks first @ chunks second ].


	"Build green tiles connecting consecutive red tiles"
	greenTiles := Set new.
	redTiles withIndexDo: [ :tile :index |
			| nextTile |
			nextTile := redTiles at: index \\ redTiles size + 1.

			"Add green tiles in straight line between current and next"
			tile x = nextTile x
				ifTrue: [ "Same column - vertical line"
						(tile y min: nextTile y) + 1 to: (tile y max: nextTile y) - 1
						do: [ :y | greenTiles add: tile x @ y ] ]
				ifFalse: [ "Same row - horizontal line"
						(tile x min: nextTile x) + 1 to: (tile x max: nextTile x) - 1
						do: [ :x | greenTiles add: x @ tile y ] ] ].

	"Find tiles inside the loop using point-in-polygon (ray casting)"
	allGreenTiles := greenTiles copy.

	minX := (redTiles collect: #x) min.
	maxX := (redTiles collect: #x) max.
	minY := (redTiles collect: #y) min.
	maxY := (redTiles collect: #y) max.

	minY to: maxY do: [ :y |
			minX to: maxX do: [ :x |
					| point isInside crossings |
					point := x @ y.

					"Skip if already red or green"
					((redTiles includes: point) or: [ greenTiles includes: point ])
						ifFalse: [ "Ray casting algorithm - count crossings to the right"
								crossings := 0.
								redTiles doWithIndex: [ :tile :index |
										| nextTile |
										nextTile := redTiles at: index \\ redTiles size + 1.

										"Check if edge crosses ray from point going right"
										((tile y <= y and: [ nextTile y > y ]) or: [
											 tile y > y and: [ nextTile y <= y ] ]) ifTrue: [
												| xIntersect |
												xIntersect := tile x
												              +
												              (y - tile y * (nextTile x - tile x)
												               // (nextTile y - tile y)).
												xIntersect > x ifTrue: [ crossings := crossings + 1 ] ] ].

								"Odd number of crossings means inside"
								crossings odd ifTrue: [ allGreenTiles add: point ] ] ] ].

	"Find largest rectangle with red corners containing only red or green tiles"
	maxArea := 0.
	redTiles doWithIndex: [ :tile1 :i |
			i + 1 to: redTiles size do: [ :j |
					| tile2 width height area valid |
					tile2 := redTiles at: j.

					"Calculate rectangle dimensions"
					width := (tile1 x - tile2 x) abs + 1.
					height := (tile1 y - tile2 y) abs + 1.
					area := width * height.

					"Check if all tiles in rectangle are red or green"
					valid := true.
					(tile1 x min: tile2 x) to: (tile1 x max: tile2 x) do: [ :x |
							valid ifTrue: [
									(tile1 y min: tile2 y) to: (tile1 y max: tile2 y) do: [ :y |
											| point |
											point := x @ y.
											((redTiles includes: point) or: [
												 allGreenTiles includes: point ]) ifFalse: [
												valid := false ] ] ] ].

					valid ifTrue: [ maxArea := maxArea max: area ] ] ].

	^ maxArea
]
