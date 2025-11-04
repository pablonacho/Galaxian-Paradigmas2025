Class {
	#name : #NaveEnemiga,
	#superclass : #Morph,
	#category : #Juego
}

{ #category : #initialize }
NaveEnemiga >> initialize [
	super initialize.
	self extent: 40@25.
	self color: Color green.

]
