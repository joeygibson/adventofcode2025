Class {
	#name : 'AoCDay05Test',
	#superclass : 'AoCBaseTest',
	#category : 'AoC2025-Tests',
	#package : 'AoC2025-Tests'
}

{ #category : 'setup' }
AoCDay05Test >> setUp [
	super setUp.
	self day: '05'.
	self path: FileLocator home / 'Projects' / 'adventofcode2025' asString.

	inst := AoCDay05 new.
]

{ #category : 'executing' }
AoCDay05Test >> testPart1WithRealData [
|lines res|

	lines := self
		         readInputFileAsLines: 'input1.txt'
		         for: self day
		         onPath: self path.

	res := inst part1: lines.

	self assert: res equals: 607.
		
]

{ #category : 'executing' }
AoCDay05Test >> testPart1WithSample [

	| lines res |
	lines := self
		         readInputFileAsLines: 'input0.txt'
		         for: self day
		         onPath: self path.

	res := inst part1: lines.

	self assert: res equals: 3
]

{ #category : 'executing' }
AoCDay05Test >> testPart2WithRealData [

	| lines res |
	lines := self
		         readInputFileAsLines: 'input1.txt'
		         for: self day
		         onPath: self path.

	res := inst part2: lines.

	self assert: res equals: 342433357244012
]

{ #category : 'executing' }
AoCDay05Test >> testPart2WithSample [

	| lines res |
	lines := self
		         readInputFileAsLines: 'input0.txt'
		         for: self day
		         onPath: self path.

	res := inst part2: lines.

	self assert: res equals: 14
]
