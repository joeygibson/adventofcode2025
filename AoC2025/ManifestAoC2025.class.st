"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : 'ManifestAoC2025',
	#superclass : 'PackageManifest',
	#category : 'AoC2025-Manifest',
	#package : 'AoC2025',
	#tag : 'Manifest'
}

{ #category : 'code-critics' }
ManifestAoC2025 class >> ruleTempsReadBeforeWrittenRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#AoCDay08 #part2:iterations: #false)) #'2025-12-08T14:12:01.832696-05:00') )
]
