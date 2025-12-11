Class {
	#name : 'AoCDay11Test',
	#superclass : 'AoCBaseTest',
	#category : 'AoC2025-Tests',
	#package : 'AoC2025-Tests'
}

{ #category : 'setup' }
AoCDay11Test >> setUp [
	super setUp.
	self day: '11'.
	self path: FileLocator home / 'Projects' / 'adventofcode2025' asString.

	inst := AoCDay11 new.
]

{ #category : 'executing' }
AoCDay11Test >> testPart1WithRealData [
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

	self assert: res equals: 670.

]

{ #category : 'executing' }
AoCDay11Test >> testPart1WithSample [

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

	self assert: res equals: 5
]

{ #category : 'executing' }
AoCDay11Test >> testPart2WithRealData [
| lines res duration |

	lines := self
		readInputFileAsLines: 'input1.txt'
		for: self day
		onPath: self path.
		
	duration := [ res := inst part2: lines ] timeToRun.

	Transcript
		show: 'part2WithRealData: ';
		show: duration asMilliSeconds printString;
		show: ' ms; ';
		show: 'Answer: ';
		show: res;
		cr.

	self assert: res equals: 0.

]

{ #category : 'executing' }
AoCDay11Test >> testPart2WithSample [
| lines res duration |

	lines := self
		readInputFileAsLines: 'input0.txt'
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

	self assert: res equals: 0.

]
