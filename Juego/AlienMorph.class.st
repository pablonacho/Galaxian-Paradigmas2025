Class {
	#name : #AlienMorph,
	#superclass : #Morph,
	#instVars : [
		'imagen',
		'atacando',
		'offsetOriginal',
		'retornando'
	],
	#category : #Juego
}

{ #category : #accessing }
AlienMorph >> atacar [
	atacando:=true.
]

{ #category : #accessing }
AlienMorph >> atacar: unBooleano [
    atacando := unBooleano
]

{ #category : #actions }
AlienMorph >> disparar [
	| disparo |
	disparo := DisparoEnemigoMorph new.
	
	
	disparo center: self center.
	disparo top: self bottom + 5.
	
	self owner addMorph: disparo.
]

{ #category : #drawing }
AlienMorph >> drawOn: aCanvas [
    aCanvas drawImage: imagen at: self bounds origin.
]

{ #category : #accessing }
AlienMorph >> estaAtacando [
	^atacando.
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
	atacando := false.
	retornando:= false.
	self loadImage.
]

{ #category : #figures }
AlienMorph >> loadImage [
    | original |
    original := Form fromFileNamed: 'naveEnemiga.png'.
    imagen := original scaledToSize: 50@50.
    self extent: imagen extent.

]

{ #category : #accessing }
AlienMorph >> offsetOriginal [
	^offsetOriginal 
]

{ #category : #accessing }
AlienMorph >> offsetOriginal: unPunto [
	offsetOriginal := unPunto
]

{ #category : #accessing }
AlienMorph >> retornando [
	^retornando
]

{ #category : #accessing }
AlienMorph >> retornando: unBooleano [
    retornando := unBooleano
]
