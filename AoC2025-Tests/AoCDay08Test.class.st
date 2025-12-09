Class {
	#name : 'AoCDay08Test',
	#superclass : 'AoCBaseTest',
	#category : 'AoC2025-Tests',
	#package : 'AoC2025-Tests'
}

{ #category : 'setup' }
AoCDay08Test >> setUp [
	super setUp.
	self day: '08'.
	self path: FileLocator home / 'Projects' / 'adventofcode2025' asString.

	inst := AoCDay08 new.
]

{ #category : 'executing' }
AoCDay08Test >> testPart1WithRealData [

	| lines res duration|
	lines := self
		         readInputFileAsLines: 'input1.txt'
		         for: self day
		         onPath: self path.

	duration := [ res := inst part1: lines iterations: 1000. ] timeToRun.

	Transcript
		show: 'testPart1WithRealData: ';
		show: duration asMilliSeconds printString;
		show: ' ms';
		cr.	
	

	self assert: res equals: 75582
]

{ #category : 'executing' }
AoCDay08Test >> testPart1WithSample [

	| lines res duration|
	lines := self
		         readInputFileAsLines: 'input0.txt'
		         for: self day
		         onPath: self path.

	duration := [ res := inst part1: lines iterations: 10. ] timeToRun.

	Transcript
		show: 'testPart1WithSample: ';
		show: duration asMilliSeconds printString;
		show: ' ms';
		cr.	

	self assert: res equals: 40
]

{ #category : 'executing' }
AoCDay08Test >> testPart2WithRealData [

	| lines res duration |
	lines := self
		         readInputFileAsLines: 'input1.txt'
		         for: self day
		         onPath: self path.

	duration := [ res := inst part2: lines ] timeToRun.

	Transcript
		show: 'testPart2WithRealData: ';
		show: duration asMilliSeconds printString;
		show: ' ms';
		cr.

	self assert: res equals: 59039696
]

{ #category : 'executing' }
AoCDay08Test >> testPart2WithSample [

	| lines res duration|
	lines := self
		         readInputFileAsLines: 'input0.txt'
		         for: self day
		         onPath: self path.

	duration := [ res := inst part2: lines. ] timeToRun.

	Transcript
		show: 'testPart2WithSample: ';
		show: duration asMilliSeconds printString;
		show: ' ms';
		cr.		

	self assert: res equals: 25272
]
