Class {
	#name : 'AoCDay03Test',
	#superclass : 'AoCBaseTest',
	#category : 'AoC2025-Tests',
	#package : 'AoC2025-Tests'
}

{ #category : 'setup' }
AoCDay03Test >> setUp [
	super setUp.
	self day: '03'.
	self path: FileLocator home / 'Projects' / 'adventofcode2025' asString.

	inst := AoCDay03 new.
]

{ #category : 'executing' }
AoCDay03Test >> testPart1WithRealData [
|lines res|

	lines := self
		         readInputFileAsLines: 'input1.txt'
		         for: self day
		         onPath: self path.

	res := inst part1: lines.

	self assert: res equals: 17158.
		
]

{ #category : 'executing' }
AoCDay03Test >> testPart1WithSample [

	| lines res |
	lines := self
		         readInputFileAsLines: 'input0.txt'
		         for: self day
		         onPath: self path.

	res := inst part1: lines.

	self assert: res equals: 357
]

{ #category : 'executing' }
AoCDay03Test >> testPart2WithRealData [
|lines res|

	lines := self
		         readInputFileAsLines: 'input1.txt'
		         for: self day
		         onPath: self path.

	res := inst part2: lines.

	self assert: res equals: 0.
		
]

{ #category : 'executing' }
AoCDay03Test >> testPart2WithSample [
|lines res|

	lines := self
		         readInputFileAsLines: 'input0.txt'
		         for: self day
		         onPath: self path.

	res := inst part2: lines.

	self assert: res equals: 0.
		
]
