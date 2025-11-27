Class {
	#name : #DisparoEnemigoMorph,
	#superclass : #Morph,
	#category : #Juego
}

{ #category : #initialization }
DisparoEnemigoMorph >> initialize [ 
	super initialize.
	self color: Color orange.
	self extent: 5@10.
]

{ #category : #'stepping and presenter' }
DisparoEnemigoMorph >> step [
	self position: self position + (0 @ 10).
	
	self owner ifNotNil: [
		(self top > self owner bounds bottom) ifTrue: [ self delete ]
	].
]

{ #category : #'model - stepping' }
DisparoEnemigoMorph >> stepTime [ 	
	^20.
]
