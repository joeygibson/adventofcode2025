"
Day10 of Advent of Code 2025.
"
Class {
	#name : 'AoCDay10',
	#superclass : 'AoCBase',
	#instVars : [
		'buttons',
		'jolts',
		'ops',
		'patterns'
	],
	#category : 'AoC2025',
	#package : 'AoC2025'
}

{ #category : 'running' }
AoCDay10 >> part1: lines [

	| totalPresses |
	totalPresses := 0.

	lines do: [ :line |
			| chunks target buttons currentLights presses matched |
			chunks := ((line copyUpTo: ${) splitOn: ' ') select: [ :chunk |
				          chunk isNotEmpty ].

			target := 0.

			(chunks first copyFrom: 2 to: chunks first size - 1) doWithIndex: [
					:c
					:i |
					c = $# ifTrue: [ "1-based index"
						target := target + (1 bitShift: i - 1) ] ].

			buttons := chunks allButFirst collect: [ :btn |
				           (btn extractAllNumbers collect: [ :num |
					            1 bitShift: num ]) sum ].

			currentLights := Set with: 0.
			presses := 1.
			matched := false.
			[ matched ] whileFalse: [
					currentLights := (currentLights flatCollect: [ :lights |
						                  buttons collect: [ :btn | lights bitXor: btn ] ])
						                 asSet.

					(currentLights includes: target)
						ifTrue: [
								totalPresses := totalPresses + presses.
								matched := true ]
						ifFalse: [ presses := presses + 1 ] ] ].

	^ totalPresses
]

{ #category : 'running' }
AoCDay10 >> part2: lines [

	^ FactoryMachineSolver solve: lines
]
