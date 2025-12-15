Class {
	#name : 'FactoryMachineSolver',
	#superclass : 'Object',
	#category : 'AoC2025-Day10',
	#package : 'AoC2025-Day10'
}

{ #category : 'as yet unclassified' }
FactoryMachineSolver class >> solve: input [
    ^ self new solveInput: input
]

{ #category : 'tests' }
FactoryMachineSolver class >> testExample [
    | input result |
    input := '[.##.] (3) (1,3) (2) (2,3) (0,2) (0,1) {3,5,4,7}
[...#.] (0,2,3,4) (2,3) (0,4) (0,1,2) (1,2,3,4) {7,5,12,7,2}
[.###.#] (0,1,2,3,4) (0,3,4) (0,1,2,4,5) (1,2) {10,11,11,5,10,5}'.
    
    result := self solve: input.
    Transcript show: 'Total presses: ', result asString; cr.
    ^ result

]

{ #category : 'as yet unclassified' }
FactoryMachineSolver >> branchAndBound: buttons target: target solution: sol current: cur buttonIdx: idx cost: cost best: best [
    | allMet overshot button maxPresses remaining|
    
    "Check if solution is complete"
    allMet := true.
    overshot := false.
    1 to: target size do: [ :i |
        (cur at: i) > (target at: i) ifTrue: [ overshot := true ].
        (cur at: i) < (target at: i) ifTrue: [ allMet := false ].
    ].
    
    "Prune if overshoot"
    overshot ifTrue: [ ^ self ].
    
    "Prune if cost already exceeds best"
    cost >= (best at: #cost) ifTrue: [ ^ self ].
    
    "Check if we found a better solution"
    allMet ifTrue: [
        cost < (best at: #cost) ifTrue: [
            best at: #solution put: sol copy.
            best at: #cost put: cost.
        ].
        ^ self.
    ].
    
    "If we've considered all buttons, stop"
    idx > buttons size ifTrue: [ ^ self ].
    
    "Calculate upper bound on presses for this button"
    
    button := buttons at: idx.
    
    "Find max needed for any counter this button affects"
    maxPresses := 0.
    button do: [ :counterIdx |
        | needed |
        needed := (target at: counterIdx + 1) - (cur at: counterIdx + 1).
        needed > 0 ifTrue: [
            maxPresses := maxPresses max: needed.
        ].
    ].
    
    "Try not pressing this button (move to next)"
    self branchAndBound: buttons target: target solution: sol current: cur 
         buttonIdx: idx + 1 cost: cost best: best.
    
    "Try pressing this button 1 to maxPresses times"
    1 to: (maxPresses min: 300) do: [ :presses |
        | newCur valid |
        newCur := cur copy.
        valid := true.
        
        "Apply button presses"
        button do: [ :counterIdx |
            newCur at: counterIdx + 1 put: ((newCur at: counterIdx + 1) + presses).
            (newCur at: counterIdx + 1) > (target at: counterIdx + 1) ifTrue: [ valid := false ].
        ].
        
        "Only recurse if still valid"
        valid ifTrue: [
            sol at: idx put: presses.
            self branchAndBound: buttons target: target solution: sol current: newCur 
                 buttonIdx: idx + 1 cost: cost + presses best: best.
            sol at: idx put: 0.
        ].
    ]
]

{ #category : 'as yet unclassified' }
FactoryMachineSolver >> gaussianElimination: matrix rows: n cols: m [
    | solution variables |
    
    variables := m - 1. "Last column is the augmented part"
    
    "Forward elimination"
    1 to: (n min: variables) do: [ :col |
        | pivotRow maxVal |
        
        "Find pivot"
        pivotRow := col.
        maxVal := ((matrix at: col) at: col) abs.
        col + 1 to: n do: [ :row |
            | val |
            val := ((matrix at: row) at: col) abs.
            val > maxVal ifTrue: [
                maxVal := val.
                pivotRow := row.
            ].
        ].
        
        "Swap rows if needed"
        pivotRow ~= col ifTrue: [
            | temp |
            temp := matrix at: col.
            matrix at: col put: (matrix at: pivotRow).
            matrix at: pivotRow put: temp.
        ].
        
        "Eliminate below"
        col + 1 to: n do: [ :row |
            | factor rowData pivotRowData |
            rowData := matrix at: row.
            pivotRowData := matrix at: col.
            (pivotRowData at: col) = 0 ifFalse: [
                factor := (rowData at: col) / (pivotRowData at: col).
                col to: m do: [ :c |
                    rowData at: c put: 
                        ((rowData at: c) - (factor * (pivotRowData at: c))).
                ].
            ].
        ].
    ].
    
    "Back substitution"
    solution := Array new: variables withAll: 0.
    variables to: 1 by: -1 do: [ :i |
        | sum rowData |
        i <= n ifTrue: [
            rowData := matrix at: i.
            sum := rowData at: m.
            i + 1 to: variables do: [ :j |
                sum := sum - ((rowData at: j) * (solution at: j)).
            ].
            (rowData at: i) ~= 0 ifTrue: [
                solution at: i put: (sum / (rowData at: i)).
            ].
        ].
    ].
    
    ^ solution collect: [ :x | x rounded ]

]

{ #category : 'as yet unclassified' }
FactoryMachineSolver >> olveInput: input [

	| lines totalPresses |
	lines := input lines reject: [ :line | line isEmpty ].
	totalPresses := 0.

	lines doWithIndex: [ :line :idx |
			| parsed buttons joltages solution presses valid |
			parsed := self parseMachine: line.
			buttons := parsed first.
			joltages := parsed second.

			joltages ifNotEmpty: [
					solution := self solveMachine: buttons target: joltages.
					valid := self
						         verifySolution: solution
						         buttons: buttons
						         target: joltages.
					presses := solution sum.
					totalPresses := totalPresses + presses.
					Transcript
						show:
							'Machine ' , idx asString , ': ' , presses asString
							, ' presses';
						show: (valid
								 ifTrue: [ ' ✓' ]
								 ifFalse: [ ' ✗ INVALID' ]);
						cr ] ].

	Transcript
		show: '===================';
		cr.
	Transcript
		show: 'TOTAL: ' , totalPresses asString;
		cr.
	^ totalPresses
]

{ #category : 'parsing' }
FactoryMachineSolver >> parseMachine: line [
    | buttons joltages buttonStart joltageStart |
    
    "Extract buttons - everything in parentheses"
    buttons := OrderedCollection new.
    buttonStart := 1.
    [ buttonStart := line indexOf: $( startingAt: buttonStart.
      buttonStart > 0 ] whileTrue: [
        | buttonEnd buttonStr indices |
        buttonEnd := line indexOf: $) startingAt: buttonStart.
        buttonStr := line copyFrom: buttonStart + 1 to: buttonEnd - 1.
        indices := (buttonStr substrings: ',') collect: [ :s | s asInteger ].
        buttons add: indices asArray.
        buttonStart := buttonEnd + 1.
    ].
    
    "Extract joltages - everything in curly braces"
    joltageStart := line indexOf: ${ startingAt: 1.
    joltageStart > 0 ifTrue: [
        | joltageEnd joltageStr |
        joltageEnd := line indexOf: $} startingAt: joltageStart.
        joltageStr := line copyFrom: joltageStart + 1 to: joltageEnd - 1.
        joltages := (joltageStr substrings: ',') collect: [ :s | s asInteger ].
    ] ifFalse: [
        joltages := #().
    ].
    
    ^ Array with: buttons with: joltages
]

{ #category : 'as yet unclassified' }
FactoryMachineSolver >> searchSolution: buttons target: target current: current solution: solution buttonIdx: btnIdx totalPresses: total maxPresses: maxP best: bestBlock [

	| allSatisfied button maxPress newCurrent |
	"Check if we've found a solution"
	allSatisfied := true.
	1 to: target size do: [ :i |
			(current at: i) < (target at: i) ifTrue: [ allSatisfied := false ].
			(current at: i) > (target at: i) ifTrue: [ "Overshoot - prune"
				^ self ] ].

	allSatisfied ifTrue: [
			bestBlock value: solution value: total.
			^ self ].

	"Pruning"
	total >= maxP ifTrue: [ ^ self ].
	btnIdx > buttons size ifTrue: [ ^ self ].

	"Try not pressing this button"
	self
		searchSolution: buttons
		target: target
		current: current
		solution: solution
		buttonIdx: btnIdx + 1
		totalPresses: total
		maxPresses: maxP
		best: bestBlock.

	"Try pressing this button 1-N times"

	button := buttons at: btnIdx.
	maxPress := maxP - total min: 20. "Limit presses per button"

	1 to: maxPress do: [ :presses |
			newCurrent := current copy.
			button do: [ :counterIdx |
					newCurrent
						at: counterIdx + 1
						put: (newCurrent at: counterIdx + 1) + presses ].

			"Only continue if not overshooting"
			((1 to: target size) allSatisfy: [ :i |
				 (newCurrent at: i) <= (target at: i) ]) ifTrue: [
					solution at: btnIdx put: presses.
					self
						searchSolution: buttons
						target: target
						current: newCurrent
						solution: solution
						buttonIdx: btnIdx + 1
						totalPresses: total + presses
						maxPresses: maxP
						best: bestBlock.
					solution at: btnIdx put: 0 ] ]
]

{ #category : 'as yet unclassified' }
FactoryMachineSolver >> solveGreedy: buttons target: target [

	| solution current remaining maxIter iter |
	solution := Array new: buttons size withAll: 0.
	current := Array new: target size withAll: 0.
	remaining := target copy.
	maxIter := 10000.
	iter := 0.

	[ remaining anySatisfy: [ :x | x > 0 ] ] whileTrue: [
			| bestButton bestScore |
			iter := iter + 1.
			iter > maxIter ifTrue: [ ^ solution ]. "Give up if too many iterations"

			bestButton := nil.
			bestScore := -1.

			"Find button that helps most without overshooting"
			buttons doWithIndex: [ :button :idx |
					| score canUse |
					canUse := true.
					score := 0.

					button do: [ :counterIdx |
							| counter |
							counter := counterIdx + 1.
							(current at: counter) >= (target at: counter)
								ifTrue: [ canUse := false ]
								ifFalse: [ score := score + 1 ] ].

					(canUse and: [ score > bestScore ]) ifTrue: [
							bestButton := idx.
							bestScore := score ] ].

			bestButton ifNil: [ ^ solution ]. "Can't make progress"

			"Press the best button"
			solution at: bestButton put: (solution at: bestButton) + 1.
			(buttons at: bestButton) do: [ :counterIdx |
				current at: counterIdx + 1 put: (current at: counterIdx + 1) + 1 ].

			"Update remaining"
			1 to: target size do: [ :i |
			remaining at: i put: ((target at: i) - (current at: i) max: 0) ] ].

	^ solution
]

{ #category : 'as yet unclassified' }
FactoryMachineSolver >> solveInput: input [
    | lines totalPresses |
    
    lines := input lines reject: [ :line | line isEmpty ].
    totalPresses := 0.
    
    lines doWithIndex: [ :line :idx |
        | parsed buttons joltages solution presses |
        parsed := self parseMachine: line.
        buttons := parsed first.
        joltages := parsed second.
        
        joltages ifNotEmpty: [
            Transcript show: 'Solving machine ', idx asString, '...'; cr.
            solution := self solveMachine: buttons target: joltages.
            presses := solution sum.
            totalPresses := totalPresses + presses.
            Transcript show: '  Result: ', presses asString, ' presses'; cr.
        ].
    ].

^totalPresses .
]

{ #category : 'as yet unclassified' }
FactoryMachineSolver >> solveMachine: buttons target: target [
    | best |
    best := Dictionary new at: #solution put: nil; at: #cost put: Float infinity; yourself.
    
    self branchAndBound: buttons 
         target: target 
         solution: (Array new: buttons size withAll: 0)
         current: (Array new: target size withAll: 0)
         buttonIdx: 1
         cost: 0
         best: best.
    
    ^ (best at: #solution) ifNil: [ Array new: buttons size withAll: 0 ]
]

{ #category : 'as yet unclassified' }
FactoryMachineSolver >> solveSmallProblem: buttons target: target [
    | maxPresses bestSolution bestTotal |
    
    maxPresses := (target sum * 2) min: 100. "Upper bound on button presses"
    bestSolution := nil.
    bestTotal := Float infinity.
    
    "Try to find solution with DFS and pruning"
    self searchSolution: buttons 
         target: target 
         current: (Array new: target size withAll: 0)
         solution: (Array new: buttons size withAll: 0)
         buttonIdx: 1
         totalPresses: 0
         maxPresses: maxPresses
         best: [ :sol :total |
             total < bestTotal ifTrue: [
                 bestSolution := sol copy.
                 bestTotal := total.
             ]
         ].
    
    ^ bestSolution ifNil: [ self solveGreedy: buttons target: target ]
]

{ #category : 'as yet unclassified' }
FactoryMachineSolver >> verifySolution: solution buttons: buttons target: target [
    | result |
    result := Array new: target size withAll: 0.
    
    solution doWithIndex: [ :presses :btnIdx |
        | button |
        presses < 0 ifTrue: [ ^ false ]. "Negative presses are invalid"
        button := buttons at: btnIdx.
        button do: [ :counterIdx |
            result at: counterIdx + 1 put: ((result at: counterIdx + 1) + presses).
        ].
    ].
    
    ^ result = target
]
