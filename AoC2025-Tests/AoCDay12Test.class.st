Class {
	#name : 'AoCDay12Test',
	#superclass : 'AoCBaseTest',
	#category : 'AoC2025-Tests',
	#package : 'AoC2025-Tests'
}

{ #category : 'setup' }
AoCDay12Test >> setUp [
	super setUp.
	self day: '12'.
	self path: FileLocator home / 'Projects' / 'adventofcode2025' asString.

	inst := AoCDay12 new.
]

{ #category : 'executing' }
AoCDay12Test >> testPart1WithRealData [

	| lines res duration |
	lines := self
		         readInputFileAsSections: 'input1.txt'
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

	self assert: res equals: 454
]

{ #category : 'executing' }
AoCDay12Test >> testPart1WithSample [

	| lines res duration |
	lines := self
		         readInputFileAsSections: 'input0.txt'
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

	self assert: res equals: 3
]
