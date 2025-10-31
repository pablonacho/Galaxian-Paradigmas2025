Class {
	#name : #Persona,
	#superclass : #Object,
	#instVars : [
		'Nombre'
	],
	#category : #Juego
}

{ #category : #accessing }
Persona >> nombre [
	^ Nombre
]

{ #category : #accessing }
Persona >> nombre: anObject [
	Nombre := anObject
]
