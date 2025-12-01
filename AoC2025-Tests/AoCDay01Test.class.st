Class {
	#name : 'AoCDay01Test',
	#superclass : 'AoCBaseTest',
	#category : 'AoC2025-Tests',
	#package : 'AoC2025-Tests'
}

{ #category : 'setup' }
AoCDay01Test >> setUp [
	super setUp.
	self day: '01'.
	self path: FileLocator home / 'Projects' / 'adventofcode2025' asString.

	inst := AoCDay01 new.
]

{ #category : 'executing' }
AoCDay01Test >> testPart1WithRealData [
|lines res|

	lines := self
		         readInputFileAsLines: 'input1.txt'
		         for: self day
		         onPath: self path.

	res := inst part1: lines.

	self assert: res equals: 1031.
		
]

{ #category : 'executing' }
AoCDay01Test >> testPart1WithSample [
|lines res|

	lines := self
		         readInputFileAsLines: 'input0.txt'
		         for: self day
		         onPath: self path.

	res := inst part1: lines.

	self assert: res equals: 3.
		
]

{ #category : 'executing' }
AoCDay01Test >> testPart2WithRealData [
|lines res|

	lines := self
		         readInputFileAsLines: 'input1.txt'
		         for: self day
		         onPath: self path.

	res := inst part2: lines.

	self assert: res equals: 5831.
		
]

{ #category : 'executing' }
AoCDay01Test >> testPart2WithSample [
|lines res|

	lines := self
		         readInputFileAsLines: 'input0.txt'
		         for: self day
		         onPath: self path.

	res := inst part2: lines.

	self assert: res equals: 6.
		
]
