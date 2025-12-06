Class {
	#name : 'AoCDay06Test',
	#superclass : 'AoCBaseTest',
	#category : 'AoC2025-Tests',
	#package : 'AoC2025-Tests'
}

{ #category : 'setup' }
AoCDay06Test >> setUp [
	super setUp.
	self day: '06'.
	self path: FileLocator home / 'Projects' / 'adventofcode2025' asString.

	inst := AoCDay06 new.
]

{ #category : 'executing' }
AoCDay06Test >> testPart1WithRealData [

	| lines res |
	lines := self
		         readInputFileAsLines: 'input1.txt'
		         for: self day
		         onPath: self path.

	res := inst part1: lines.

	self assert: res equals: 5227286044585
]

{ #category : 'executing' }
AoCDay06Test >> testPart1WithSample [

	| lines res |
	lines := self
		         readInputFileAsLines: 'input0.txt'
		         for: self day
		         onPath: self path.

	res := inst part1: lines.

	self assert: res equals: 4277556
]

{ #category : 'executing' }
AoCDay06Test >> testPart2WithRealData [
|lines res|

	lines := self
		         readInputFileAsLines: 'input1.txt'
		         for: self day
		         onPath: self path.

	res := inst part2: lines.
	
	self assert: res equals: 10227753257799.
		
]

{ #category : 'executing' }
AoCDay06Test >> testPart2WithSample [

	| lines res |
	lines := self
		         readInputFileAsLines: 'input0.txt'
		         for: self day
		         onPath: self path.

	res := inst part2: lines.

	self assert: res equals: 3263827
]
