Class {
	#name : #AlienMorph,
	#superclass : #Morph,
	#category : #Juego
}

{ #category : #initialization }
AlienMorph >> initialize [
	super initialize.
	self color: Color green.
	self extent: 30@30.
]
