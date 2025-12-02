Class {
	#name : 'AoCDay02Test',
	#superclass : 'AoCBaseTest',
	#category : 'AoC2025-Tests',
	#package : 'AoC2025-Tests'
}

{ #category : 'setup' }
AoCDay02Test >> setUp [
	super setUp.
	self day: '02'.
	self path: FileLocator home / 'Projects' / 'adventofcode2025' asString.

	inst := AoCDay02 new.
]

{ #category : 'executing' }
AoCDay02Test >> testPart1WithRealData [
|lines res|

	lines := self
		         readInputFileAsLines: 'input1.txt'
		         for: self day
		         onPath: self path.

	res := inst part1: lines.

	self assert: res equals: 0.
		
]

{ #category : 'executing' }
AoCDay02Test >> testPart1WithSample [

	| lines res |
	lines := self
		         readInputFileAsLines: 'input0.txt'
		         for: self day
		         onPath: self path.

	res := inst part1: lines.

	self assert: res equals: 1227775554
]

{ #category : 'executing' }
AoCDay02Test >> testPart2WithRealData [
|lines res|

	lines := self
		         readInputFileAsLines: 'input1.txt'
		         for: self day
		         onPath: self path.

	res := inst part2: lines.

	self assert: res equals: 0.
		
]

{ #category : 'executing' }
AoCDay02Test >> testPart2WithSample [
|lines res|

	lines := self
		         readInputFileAsLines: 'input0.txt'
		         for: self day
		         onPath: self path.

	res := inst part2: lines.

	self assert: res equals: 0.
		
]
