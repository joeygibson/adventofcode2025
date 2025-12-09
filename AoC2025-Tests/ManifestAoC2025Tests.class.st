"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : 'ManifestAoC2025Tests',
	#superclass : 'PackageManifest',
	#category : 'AoC2025-Tests-Manifest',
	#package : 'AoC2025-Tests',
	#tag : 'Manifest'
}

{ #category : 'code-critics' }
ManifestAoC2025Tests class >> ruleTempsReadBeforeWrittenRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#AoCDay08Test #testPart1WithSample #false)) #'2025-12-08T22:37:55.7781-05:00') #(#(#RGMethodDefinition #(#AoCDay08Test #testPart1WithRealData #false)) #'2025-12-08T22:39:09.222094-05:00') )
]
