Class {
	#name : 'AoCDay07Test',
	#superclass : 'AoCBaseTest',
	#category : 'AoC2025-Tests',
	#package : 'AoC2025-Tests'
}

{ #category : 'setup' }
AoCDay07Test >> setUp [
	super setUp.
	self day: '07'.
	self path: FileLocator home / 'Projects' / 'adventofcode2025' asString.

	inst := AoCDay07 new.
]

{ #category : 'executing' }
AoCDay07Test >> testPart1WithRealData [
|lines res|

	lines := self
		         readInputFileAsLines: 'input1.txt'
		         for: self day
		         onPath: self path.

	res := inst part1: lines.

	self assert: res equals: 1499.
		
]

{ #category : 'executing' }
AoCDay07Test >> testPart1WithSample [

	| lines res |
	lines := self
		         readInputFileAsLines: 'input0.txt'
		         for: self day
		         onPath: self path.

	res := inst part1: lines.

	self assert: res equals: 21.
]

{ #category : 'executing' }
AoCDay07Test >> testPart2WithRealData [

	| lines res |
	lines := self
		         readInputFileAsLines: 'input1.txt'
		         for: self day
		         onPath: self path.

	res := inst part2: lines.

	self assert: res equals: 24743903847942
]

{ #category : 'executing' }
AoCDay07Test >> testPart2WithSample [

	| lines res |
	lines := self
		         readInputFileAsLines: 'input0.txt'
		         for: self day
		         onPath: self path.
	
	self increaseTimeout: 300.
	res := inst part2: lines.

	self assert: res equals: 40
]
