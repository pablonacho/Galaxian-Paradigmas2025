"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestJuego,
	#superclass : #PackageManifest,
	#category : #'Juego-Manifest'
}

{ #category : #'code-critics' }
ManifestJuego class >> ruleRBStringConcatenationRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#JuegoMorph #step #false)) #'2025-11-27T17:43:05.817427-03:00') )
]
