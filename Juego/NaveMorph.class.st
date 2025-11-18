Class {
	#name : #NaveMorph,
	#superclass : #Morph,
	#instVars : [
		'imagen'
	],
	#category : #Juego
}

{ #category : #'as yet unclassified' }
NaveMorph >> disparar [
	| disparo |
	disparo := DisparoMorph new.
	
	"Ubicamos el disparo en el centro de la nave"
	disparo center: self center.
	disparo top: self top - 10.
	
	"Agregamos el disparo al Juego (owner es el JuegoMorph que contiene a la nave)"
	self owner addMorph: disparo.
]

{ #category : #drawing }
NaveMorph >> drawOn: aCanvas [
    aCanvas drawImage: imagen at: self bounds origin.
]

{ #category : #accessing }
NaveMorph >> imagen [
	^ imagen
]

{ #category : #accessing }
NaveMorph >> imagen: anObject [
	imagen := anObject
]

{ #category : #initialization }
NaveMorph >> initialize [ 
	super initialize.
	
	self loadImage.
	
 	self handlesKeyboard: true.
   self takeKeyboardFocus.
]

{ #category : #'as yet unclassified' }
NaveMorph >> loadImage [
    | original |
    original := Form fromFileNamed: 'NavePrincipal.png'.
    imagen := original scaledToSize: 50@50.
    self extent: imagen extent.

]

{ #category : #movement }
NaveMorph >> moverDerecha [
	"metodo para que la nave se mueva a derecha"

	self position: self position + (10 @ 0).
								
	self owner ifNotNil: [ (self right > self owner bounds right )
									ifTrue: [ self right: self owner bounds right  ] ]
	
]

{ #category : #movement }
NaveMorph >> moverIzquierda [
	"metodo para que la nave se mueva a izquierda"

	self position: self position - (10 @ 0).
	
	self owner ifNotNil: [ (self left  < self owner bounds left )
									ifTrue: [ self left: self owner bounds left ] ]
	
		
]
