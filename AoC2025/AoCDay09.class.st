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
AoCDay09 >> onSegment: p middle: q end: r [
    ^ (q x between: p x and: r x)
       and: [q y between: p y and: r y]

]

{ #category : 'as yet unclassified' }
AoCDay09 >> orientationOf: p with: q and: r [
    | val |
    val := (q y - p y) * (r x - q x)
           - (q x - p x) * (r y - q y).
    ^ val sign  "=> -1 counterclockwise, 0 collinear, 1 clockwise"

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

	| rectangles points areas bounds containedRectangles vertices edges |
	points := lines collect: [ :line |
			          | chunks |
			          chunks := (line splitOn: ',') collect: [ :c |
				                    c asString asInteger ].
			          chunks first @ chunks second ].

	vertices := points copy asOrderedCollection.
	vertices add: points first.

	bounds := PathShape vertices: vertices.
	edges := OrderedCollection new.
	bounds segmentsDo: [ :a :b |
			edges add: {
					a.
					b } ].

	rectangles := points uniquePairs collect: [ :pair |
		              Rectangle point: pair first point: pair second ].

	containedRectangles := rectangles select: [ :r |
			                       self
				                       rectIntersectsPolygon: r
				                       polygonEdges: edges
				                       polygonContains: [ :p |
				                       self polygon: vertices containsPoint: p ] ].
	areas := (containedRectangles collect: [ :r | r inclusiveArea ])
		         sorted: [ :a :b | a >= b ].

	self halt.
	^ areas first
]

{ #category : 'as yet unclassified' }
AoCDay09 >> polygon: vertices containsPoint: p [
    "vertices is an OrderedCollection of Points describing a simple polygon.
     Return true if p is inside or on the boundary (ray‑casting / pnpoly style)."
    | inside j n vi vj |
    inside := false.
    n := vertices size.
    j := n.
    1 to: n do: [:i |
        vi := vertices at: i.
        vj := vertices at: j.
        (((vi y > p y) ~= (vj y > p y))
            and: [p x < (vj x - vi x) * (p y - vi y) / (vj y - vi y) + vi x])
            ifTrue: [inside := inside not].
        j := i ].
    ^ inside

]

{ #category : 'as yet unclassified' }
AoCDay09 >> rectIntersectsPolygon: r polygonEdges: edges polygonContains: polygonContainsBlock [
    | rectCorners rectEdges |

    rectCorners := { r origin.
                     r corner.
                     r left @ r bottom.
                     r right @ r top }.

    "1) Any polygon vertex inside rect?"
    (edges anySatisfy: [:e | r containsPoint: e first]) ifTrue: [ ^ true ].

    "2) Any rect corner inside polygon?"
    (rectCorners anySatisfy: [:c | polygonContainsBlock value: c]) ifTrue: [ ^ true ].

    "3) Any edge intersection?"
    rectEdges := {
        { rectCorners first. rectCorners third }.  "left"
        { rectCorners first. rectCorners fourth }. "top"
        { rectCorners second. rectCorners third }. "bottom"
        { rectCorners second. rectCorners fourth } "right"
    }.

    rectEdges do: [:re |
        edges do: [:pe |
            (self segmentsIntersectP1: re first p2: re second
                               p3: pe first p4: pe second)
                ifTrue: [ ^ true ] ] ].

    ^ false

]

{ #category : 'as yet unclassified' }
AoCDay09 >> segmentsIntersectP1: p1 p2: p2 p3: p3 p4: p4 [
    | o1 o2 o3 o4 |
    o1 := self orientationOf: p1 with: p2 and: p3.
    o2 := self orientationOf: p1 with: p2 and: p4.
    o3 := self orientationOf: p3 with: p4 and: p1.
    o4 := self orientationOf: p3 with: p4 and: p2.

    "General case"
    (o1 ~= o2 and: [o3 ~= o4]) ifTrue: [^ true].

    "Collinear overlap cases"
    (o1 = 0 and: [self onSegment: p1 middle: p3 end: p2]) ifTrue: [^ true].
    (o2 = 0 and: [self onSegment: p1 middle: p4 end: p2]) ifTrue: [^ true].
    (o3 = 0 and: [self onSegment: p3 middle: p1 end: p4]) ifTrue: [^ true].
    (o4 = 0 and: [self onSegment: p3 middle: p2 end: p4]) ifTrue: [^ true].

    ^ false

]
