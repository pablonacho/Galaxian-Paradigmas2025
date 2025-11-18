Class {
	#name : #DisparoMorph,
	#superclass : #Morph,
	#category : #Juego
}

{ #category : #initialization }
DisparoMorph >> initialize [
	super initialize.
	self color: Color yellow.
	self extent: 5@10. "Un disparo pequeño y vertical"
]

{ #category : #'stepping and presenter' }
DisparoMorph >> step [
	self position: self position - (0 @ 10).
	(self position y < 0) ifTrue: [ self delete ].
]

{ #category : #'model - stepping' }
DisparoMorph >> stepTime [ 
	^20
]
