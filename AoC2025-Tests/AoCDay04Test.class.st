Class {
	#name : 'AoCDay04Test',
	#superclass : 'AoCBaseTest',
	#category : 'AoC2025-Tests',
	#package : 'AoC2025-Tests'
}

{ #category : 'setup' }
AoCDay04Test >> setUp [
	super setUp.
	self day: '04'.
	self path: FileLocator home / 'Projects' / 'adventofcode2025' asString.

	inst := AoCDay04 new.
]

{ #category : 'executing' }
AoCDay04Test >> testPart1WithRealData [
|lines res|

	lines := self
		         readInputFileAsLines: 'input1.txt'
		         for: self day
		         onPath: self path.

	res := inst part1: lines.

	self assert: res equals: 1433.
		
]

{ #category : 'executing' }
AoCDay04Test >> testPart1WithSample [

	| lines res |
	lines := self
		         readInputFileAsLines: 'input0.txt'
		         for: self day
		         onPath: self path.

	res := inst part1: lines.

	self assert: res equals: 13
]

{ #category : 'executing' }
AoCDay04Test >> testPart2WithRealData [
|lines res|

	lines := self
		         readInputFileAsLines: 'input1.txt'
		         for: self day
		         onPath: self path.

	res := inst part2: lines.

	self assert: res equals: 8616.
		
]

{ #category : 'executing' }
AoCDay04Test >> testPart2WithSample [

	| lines res |
	lines := self
		         readInputFileAsLines: 'input0.txt'
		         for: self day
		         onPath: self path.

	res := inst part2: lines.

	self assert: res equals: 43
]
