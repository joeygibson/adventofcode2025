Class {
	#name : 'TachyonBeam',
	#superclass : 'Object',
	#instVars : [
		'coord',
		'live'
	],
	#category : 'AoC2025-Day07',
	#package : 'AoC2025-Day07'
}

{ #category : 'accessing' }
TachyonBeam class >> at: aPoint [

	^ self new
		  coord: aPoint;
		  live: true
]

{ #category : 'accessing' }
TachyonBeam >> coord [

	^ coord
]

{ #category : 'accessing' }
TachyonBeam >> coord: anObject [

	coord := anObject
]

{ #category : 'accessing' }
TachyonBeam >> live [

	^ live
]

{ #category : 'accessing' }
TachyonBeam >> live: anObject [

	live := anObject
]

{ #category : 'printing' }
TachyonBeam >> printOn: aStream [

	aStream
		nextPutAll: 'TachyonBeam(';
		nextPutAll: 'coord: ';
		nextPutAll: self coord asString;
		nextPutAll: ', live: ';
		nextPutAll: self live asString;
		nextPutAll: ')'
]
