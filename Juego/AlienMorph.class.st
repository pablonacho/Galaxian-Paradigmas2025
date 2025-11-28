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

{ #category : #initialization }
AlienMorph >> initialize [
	super initialize.
	atacando := false.
	retornando:= false.
	self loadImage.
]

{ #category : #figures }
AlienMorph >> loadImage [
    | original nombre |
    nombre := self nombreImagen.
	original := Form fromFileNamed: nombre.
	imagen := original scaledToSize: 30@30.
	self extent: imagen extent.
]

{ #category : #image }
AlienMorph >> nombreImagen [ 
	^self subclassResponsibility 
]

{ #category : #accessing }
AlienMorph >> offsetOriginal [
	^offsetOriginal 
]

{ #category : #accessing }
AlienMorph >> offsetOriginal: unPunto [
	offsetOriginal := unPunto
]

{ #category : #movement }
AlienMorph >> realizarMovimientoDeAtaqueHacia: unaNave [
	^self subclassResponsibility 
]

{ #category : #accessing }
AlienMorph >> retornando [
	^retornando
]

{ #category : #accessing }
AlienMorph >> retornando: unBooleano [
    retornando := unBooleano
]
