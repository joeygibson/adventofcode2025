Class {
	#name : 'AoCDay09Test',
	#superclass : 'AoCBaseTest',
	#category : 'AoC2025-Tests',
	#package : 'AoC2025-Tests'
}

{ #category : 'setup' }
AoCDay09Test >> setUp [
	super setUp.
	self day: '09'.
	self path: FileLocator home / 'Projects' / 'adventofcode2025' asString.

	inst := AoCDay09 new.
]

{ #category : 'executing' }
AoCDay09Test >> testPart1WithRealData [

	| lines res duration |
	lines := self
		         readInputFileAsLines: 'input1.txt'
		         for: self day
		         onPath: self path.

	duration := [ res := inst part1: lines ] timeToRun.

	Transcript
		show: 'part1WithRealData: ';
		show: duration asMilliSeconds printString;
		show: ' ms';
		cr.

	self assert: res equals: 4750092396
]

{ #category : 'executing' }
AoCDay09Test >> testPart1WithSample [

	| lines res duration |
	lines := self
		         readInputFileAsLines: 'input0.txt'
		         for: self day
		         onPath: self path.

	duration := [ res := inst part1: lines ] timeToRun.

	Transcript
		show: 'part1WithSample: ';
		show: duration asMilliSeconds printString;
		show: ' ms';
		cr.

	self assert: res equals: 50
]

{ #category : 'executing' }
AoCDay09Test >> testPart2WithRealData [
| lines res duration |

	lines := self
		readInputFileAsLines: 'input1.txt'
		for: self day
		onPath: self path.
		
	duration := [ res := inst part2: lines ] timeToRun.

	Transcript
		show: 'part2WithRealData: ';
		show: duration asMilliSeconds printString;
		show: ' ms';
		cr.

	self assert: res equals: 0.

]

{ #category : 'executing' }
AoCDay09Test >> testPart2WithSample [
| lines res duration |

	lines := self
		readInputFileAsLines: 'input0.txt'
		for: self day
		onPath: self path.
		
	duration := [ res := inst part2: lines ] timeToRun.

	Transcript
		show: 'part2WithSample: ';
		show: duration asMilliSeconds printString;
		show: ' ms';
		cr.

	self assert: res equals: 0.

]
