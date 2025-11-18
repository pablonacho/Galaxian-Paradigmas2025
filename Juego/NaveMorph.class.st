Class {
	#name : #NaveMorph,
	#superclass : #Morph,
	#category : #Juego
}

{ #category : #initialization }
NaveMorph >> initialize [
    super initialize.
    
    "definimos tamaño"
    self extent: 50@30.
    
    "definimos color"
    self color: Color red.

    "posicion inicial"
    self position: 200@200.

    self handlesKeyboard: true.
    self takeKeyboardFocus.

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
