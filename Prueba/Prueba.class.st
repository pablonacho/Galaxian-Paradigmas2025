Class {
	#name : #Prueba,
	#superclass : #Object,
	#instVars : [
		'Nombre'
	],
	#category : #Prueba
}

{ #category : #accessing }
Prueba >> nombre [
	^ Nombre
]

{ #category : #accessing }
Prueba >> nombre: anObject [
	Nombre := anObject
]
