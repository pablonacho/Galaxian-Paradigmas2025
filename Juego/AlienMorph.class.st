Class {
	#name : #AlienMorph,
	#superclass : #Morph,
	#instVars : [
		'imagen'
	],
	#category : #Juego
}

{ #category : #drawing }
AlienMorph >> drawOn: aCanvas [
    aCanvas drawImage: imagen at: self bounds origin.
]

{ #category : #accessing }
AlienMorph >> imagen [
	^ imagen
]

{ #category : #accessing }
AlienMorph >> imagen: anObject [
	imagen := anObject
]

{ #category : #initialization }
AlienMorph >> initialize [
	super initialize.
	self loadImage.
]

{ #category : #'as yet unclassified' }
AlienMorph >> loadImage [
    | original |
    original := Form fromFileNamed: 'naveEnemiga.png'.
    imagen := original scaledToSize: 50@50.
    self extent: imagen extent.

]
