Class {
	#name : #AlienJefe,
	#superclass : #AlienMorph,
	#category : #Juego
}

{ #category : #image }
AlienJefe >> nombreImagen [
	^'alienJefe.png'
]

{ #category : #movement }
AlienJefe >> realizarMovimientoDeAtaqueHacia: unaNave [
	self position: self position + (0@4).
    
    (self center x < unaNave center x) 
        ifTrue: [ self position: self position + (8@0) ]
        ifFalse: [ self position: self position - (8@0) ].
]
