Class {
	#name : 'AoCDay08Test',
	#superclass : 'AoCBaseTest',
	#category : 'AoC2025-Tests',
	#package : 'AoC2025-Tests'
}

{ #category : 'setup' }
AoCDay08Test >> setUp [
	super setUp.
	self day: '08'.
	self path: FileLocator home / 'Projects' / 'adventofcode2025' asString.

	inst := AoCDay08 new.
]

{ #category : 'executing' }
AoCDay08Test >> testPart1WithRealData [

	| lines res |
	lines := self
		         readInputFileAsLines: 'input1.txt'
		         for: self day
		         onPath: self path.

	res := inst part1: lines iterations: 1000.

	self assert: res equals: 75582
]

{ #category : 'executing' }
AoCDay08Test >> testPart1WithSample [

	| lines res |
	lines := self
		         readInputFileAsLines: 'input0.txt'
		         for: self day
		         onPath: self path.

	res := inst part1: lines iterations: 10.

	self assert: res equals: 40
]

{ #category : 'executing' }
AoCDay08Test >> testPart2WithRealData [
|lines res|

	lines := self
		         readInputFileAsLines: 'input1.txt'
		         for: self day
		         onPath: self path.

	res := inst part2: lines.

	self assert: res equals: 0.
		
]

{ #category : 'executing' }
AoCDay08Test >> testPart2WithSample [
|lines res|

	lines := self
		         readInputFileAsLines: 'input0.txt'
		         for: self day
		         onPath: self path.

	res := inst part2: lines.

	self assert: res equals: 0.
		
]
