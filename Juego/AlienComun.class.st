Class {
	#name : #AlienComun,
	#superclass : #AlienMorph,
	#category : #Juego
}

{ #category : #image }
AlienComun >> nombreImagen [ 
	^ 'alienComun.png'.
]

{ #category : #movement }
AlienComun >> realizarMovimientoDeAtaqueHacia: unaNave [
	self position: self position + (0@7).
    
    (self center x < unaNave center x) 
        ifTrue: [ self position: self position + (3@0) ]
        ifFalse: [ self position: self position - (3@0) ].
]
