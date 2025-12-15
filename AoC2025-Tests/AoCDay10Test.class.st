Class {
	#name : 'AoCDay10Test',
	#superclass : 'AoCBaseTest',
	#category : 'AoC2025-Tests',
	#package : 'AoC2025-Tests'
}

{ #category : 'setup' }
AoCDay10Test >> setUp [
	super setUp.
	self day: '10'.
	self path: FileLocator home / 'Projects' / 'adventofcode2025' asString.

	inst := AoCDay10 new.
]

{ #category : 'executing' }
AoCDay10Test >> testPart1WithRealData [
| lines res duration |

	lines := self
		readInputFileAsLines: 'input1.txt'
		for: self day
		onPath: self path.
		
	duration := [ res := inst part1: lines ] timeToRun.

	Transcript
		show: 'part1WithRealData: ';
		show: duration asMilliSeconds printString;
		show: ' ms; ';
		show: 'Answer: ';
		show: res;
		cr.

	self assert: res equals: 428.

]

{ #category : 'executing' }
AoCDay10Test >> testPart1WithSample [
| lines res duration |

	lines := self
		readInputFileAsLines: 'input0.txt'
		for: self day
		onPath: self path.
		
	duration := [ res := inst part1: lines ] timeToRun.

	Transcript
		show: 'part1WithSample: ';
		show: duration asMilliSeconds printString;
		show: ' ms; ';
		show: 'Answer: ';
		show: res;
		cr.

	self assert: res equals: 7.

]

{ #category : 'executing' }
AoCDay10Test >> testPart2WithRealData [

	| lines res duration |
	lines := self
		         readInputFile: 'input1.txt'
		         for: self day
		         onPath: self path.

	self increaseTimeout: 7200.
	duration := [ res := inst part2: lines ] timeToRun.

	Transcript
		show: 'part2WithRealData: ';
		show: duration asMilliSeconds printString;
		show: ' ms; ';
		show: 'Answer: ';
		show: res;
		cr.

	self assert: res equals: 0
]

{ #category : 'executing' }
AoCDay10Test >> testPart2WithSample [

	| lines res duration |
	lines := self
		         readInputFile: 'input0.txt'
		         for: self day
		         onPath: self path.

	duration := [ res := inst part2: lines ] timeToRun.

	Transcript
		show: 'part2WithSample: ';
		show: duration asMilliSeconds printString;
		show: ' ms; ';
		show: 'Answer: ';
		show: res;
		cr.

	self assert: res equals: 33
]
