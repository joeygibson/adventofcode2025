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

{ #category : 'as yet unclassified' }
AoCDay11 >> countPathsFrom: start to: target [
	"Entry point to count all simple paths from start to target without mandatory nodes."

	memo := Dictionary new. "Initialize memoization cache for each top-level call"
	^ self
		  countPathsFrom: start
		  to: target
		  visited: Set new
		  mandatoryNodesToFind: Set new
]

{ #category : 'as yet unclassified' }
AoCDay11 >> countPathsFrom: start to: target includingNodes: mandatoryNodes [
	"Counts all simple paths from start to target that include all specified mandatoryNodes, filtering during traversal."

	memo := Dictionary new. "Initialize memoization cache for each top-level call"
	^ self
		  countPathsFrom: start
		  to: target
		  visited: Set new
		  mandatoryNodesToFind: mandatoryNodes asSet
]

{ #category : 'as yet unclassified' }
AoCDay11 >> countPathsFrom: current to: target visited: aVisitedSet mandatoryNodesToFind: aMandatoryNodesToFind [

	| newVisitedSet updatedMandatoryNodesToFind totalPaths cacheKey |
	"Create a canonical cache key from the current state.""We use canonicalKey for sets to ensure consistent hashing and equality."
	cacheKey := {
		            current.
		            aMandatoryNodesToFind canonicalKey.
		            aVisitedSet canonicalKey }.

	"Check memoization cache"
	(memo includesKey: cacheKey) ifTrue: [ ^ memo at: cacheKey ].

	"If the current node has already been visited in this path, it means we've found a cycle.
    This path is not simple, so we return 0."
	(aVisitedSet includes: current) ifTrue: [
			memo at: cacheKey put: 0. "Cache this result"
			^ 0 ].

	"Create a copy of the set of mandatory nodes that still need to be found for this branch.
    If the current node is one of them, remove it from this branch's 'to-find' set."
	updatedMandatoryNodesToFind := aMandatoryNodesToFind copy.
	(updatedMandatoryNodesToFind includes: current) ifTrue: [
		updatedMandatoryNodesToFind remove: current ].

	"If we've reached the target node, we've potentially found a complete path.
    It's only a valid path if all mandatory nodes have also been found along this path."
	current = target ifTrue: [
			totalPaths := updatedMandatoryNodesToFind isEmpty
				              ifTrue: [ "All mandatory nodes found, count this path"
				              1 ]
				              ifFalse: [ 0 ]. "Mandatory nodes still missing, this path is invalid"
			memo at: cacheKey put: totalPaths. "Cache this result"
			^ totalPaths ].

	"Mark the current node as visited for this branch to prevent cycles in subsequent steps.
    We create a copy of the visitedSet for this branch."
	newVisitedSet := aVisitedSet copy.
	newVisitedSet add: current.

	totalPaths := 0.
	"Iterate over all neighbors of the current node."
	(nodes at: current ifAbsent: [ #(  ) ]) do: [ :neighbor | "Recursively count paths from the neighbor to the target.
        Crucially, pass a fresh COPY of both the visitedSet and the mandatoryNodesToFind set
        to ensure each recursive branch has its own independent state."
			totalPaths := totalPaths + (self
				               countPathsFrom: neighbor
				               to: target
				               visited: newVisitedSet copy
				               mandatoryNodesToFind:
				               updatedMandatoryNodesToFind copy) ].

	"Store the computed result in the memoization cache before returning"
	memo at: cacheKey put: totalPaths.
	^ totalPaths
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

{ #category : 'running' }
AoCDay11 >> part2: lines [

	| svrDac svrFft dacFft fftDac fftOut dacOut |
	self buildNodes: lines.

	^ self
		  countPathsFrom: 'svr'
		  to: 'out'
		  includingNodes: #( 'dac' 'fft' )


	"svrDac := self countPathsFrom: 'svr' to: 'dac'.
self halt.
	svrFft := self countPathsFrom: 'svr' to: 'fft'.
	dacFft := self countPathsFrom: 'dac' to: 'fft'.
	fftDac := self countPathsFrom: 'fft' to: 'dac'.
	fftOut := self countPathsFrom: 'fft' to: 'out'.
	dacOut := self countPathsFrom: 'dac' to: 'out'.

	^ svrDac  * dacFft  * fftOut 
	  + (svrFft  * fftDac  * dacOut )"
]
