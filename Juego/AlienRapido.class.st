Class {
	#name : #AlienRapido,
	#superclass : #AlienMorph,
	#category : #Juego
}

{ #category : #image }
AlienRapido >> nombreImagen [ 
	^'alienRapido.png'.
]

{ #category : #movement }
AlienRapido >> realizarMovimientoDeAtaqueHacia: unaNave [
	  self position: self position + (0@15). 
    
    (self center x < unaNave center x) 
        ifTrue: [ self position: self position + (6@0) ]
        ifFalse: [ self position: self position - (6@0) ].
]
