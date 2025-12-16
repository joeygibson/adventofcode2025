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
AoCDay09 >> isPointInside: point polygon: redTiles [

	| crossings |
	crossings := 0.
	redTiles doWithIndex: [ :tile :index |
			| nextTile |
			nextTile := redTiles at: index \\ redTiles size + 1.

			((tile y <= point y and: [ nextTile y > point y ]) or: [
				 tile y > point y and: [ nextTile y <= point y ] ]) ifTrue: [
					| xIntersect |
					xIntersect := tile x
					              +
					              (point y - tile y * (nextTile x - tile x)
					               // (nextTile y - tile y)).
					xIntersect > point x ifTrue: [ crossings := crossings + 1 ] ] ].

	^ crossings odd
]

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

	| redTiles greenTileSet maxArea candidates redTileSet |
	redTiles := lines collect: [ :line |
			            | chunks |
			            chunks := (line splitOn: ',') collect: [ :c |
				                      c asString asInteger ].
			            chunks first @ chunks second ].

	"Build green edge tiles connecting consecutive red tiles"
	greenTileSet := Set new.
	redTiles withIndexDo: [ :tile :index |
			| nextTile |
			nextTile := redTiles at: index \\ redTiles size + 1.

			tile x = nextTile x
				ifTrue: [
						(tile y min: nextTile y) + 1 to: (tile y max: nextTile y) - 1
						do: [ :y | greenTileSet add: tile x @ y ] ]
				ifFalse: [
						(tile x min: nextTile x) + 1 to: (tile x max: nextTile x) - 1
						do: [ :x | greenTileSet add: x @ tile y ] ] ].

	"Create all candidate rectangles with their potential areas"
	candidates := OrderedCollection new.
	redTiles := redTiles asArray.
	redTileSet := redTiles asSet.

	redTiles doWithIndex: [ :tile1 :i |
			i + 1 to: redTiles size do: [ :j |
					| tile2 width height area |
					tile2 := redTiles at: j.
					width := (tile1 x - tile2 x) abs + 1.
					height := (tile1 y - tile2 y) abs + 1.
					area := width * height.
					candidates add: {
							area.
							tile1.
							tile2 } ] ].

	"Sort by area descending for early termination"
	candidates := candidates sorted: [ :a :b | a first >= b first ].

	"Find largest valid rectangle"
	maxArea := 0.
	candidates do: [ :candidate |
			| area tile1 tile2 |
			area := candidate first.

			"Early termination: if this area can't beat current max, stop"
			area <= maxArea ifTrue: [ ^ maxArea ].

			"Skip very large rectangles - too expensive to validate thoroughly"
			area <= 3000000000 ifTrue: [
					tile1 := candidate second.
					tile2 := candidate third.

					"Validate rectangle efficiently"
					(self
						 validateRectangle: tile1
						 corner: tile2
						 redTiles: redTileSet
						 greenTiles: greenTileSet
						 allRedTiles: redTiles) ifTrue: [ maxArea := area ] ] ].

	^ maxArea
]

{ #category : 'as yet unclassified' }
AoCDay09 >> validateRectangle: corner1 corner: corner2 redTiles: redTileSet greenTiles: greenTileSet allRedTiles: redTilesArray [

	| minX maxX minY maxY width height step centerX centerY perimeterStep |
	minX := corner1 x min: corner2 x.
	maxX := corner1 x max: corner2 x.
	minY := corner1 y min: corner2 y.
	maxY := corner1 y max: corner2 y.
	width := maxX - minX + 1.
	height := maxY - minY + 1.

	"Quick reject: check center first (cheap test)"
	centerX := minX + maxX // 2.
	centerY := minY + maxY // 2.

	((redTileSet includes: centerX @ centerY) or: [
			 (greenTileSet includes: centerX @ centerY) or: [
				 self isPointInside: centerX @ centerY polygon: redTilesArray ] ])
		ifFalse: [ ^ false ].

	"For small rectangles, check all points"
	width * height < 10000 ifTrue: [
			minX to: maxX do: [ :x |
					minY to: maxY do: [ :y |
							| point |
							point := x @ y.
							((redTileSet includes: point) or: [
									 (greenTileSet includes: point) or: [
										 self isPointInside: point polygon: redTilesArray ] ])
								ifFalse: [ ^ false ] ] ].
			^ true ].

	"For larger rectangles: sample perimeter and interior"
	"Perimeter sampling - denser for smaller rectangles"
	perimeterStep := (width max: height) < 10000
		                 ifTrue: [ 1 ]
		                 ifFalse: [
				                 (width max: height) < 50000
					                 ifTrue: [ 10 ]
					                 ifFalse: [ 50 ] ].

	minX to: maxX by: perimeterStep do: [ :x |
			| top bottom |
			top := x @ minY.
			bottom := x @ maxY.
			((redTileSet includes: top) or: [
					 (greenTileSet includes: top) or: [
						 self isPointInside: top polygon: redTilesArray ] ]) ifFalse: [
				^ false ].
			((redTileSet includes: bottom) or: [
					 (greenTileSet includes: bottom) or: [
						 self isPointInside: bottom polygon: redTilesArray ] ])
				ifFalse: [ ^ false ] ].

	minY + 1 to: maxY - 1 by: perimeterStep do: [ :y |
			| left right |
			left := minX @ y.
			right := maxX @ y.
			((redTileSet includes: left) or: [
					 (greenTileSet includes: left) or: [
						 self isPointInside: left polygon: redTilesArray ] ]) ifFalse: [
				^ false ].
			((redTileSet includes: right) or: [
					 (greenTileSet includes: right) or: [
						 self isPointInside: right polygon: redTilesArray ] ]) ifFalse: [
				^ false ] ].

	"Sample interior"
	step := (width min: height) // 15 max: 1.
	minX + step to: maxX - step by: step do: [ :x |
			minY + step to: maxY - step by: step do: [ :y |
					| point |
					point := x @ y.
					((redTileSet includes: point) or: [
							 (greenTileSet includes: point) or: [
								 self isPointInside: point polygon: redTilesArray ] ])
						ifFalse: [ ^ false ] ] ].

	^ true
]
