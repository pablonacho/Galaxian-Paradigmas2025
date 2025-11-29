Class {
	#name : #JefeFinal,
	#superclass : #AlienMorph,
	#instVars : [
		'vida',
		'barraVida',
		'tiempoInvocacion'
	],
	#category : #Juego
}

{ #category : #accessing }
JefeFinal >> barraVida: unaBarra [
  
    barraVida := unaBarra.
    
    barraVida actualizarVida: vida.
]

{ #category : #initialization }
JefeFinal >> initialize [
  super initialize.
  vida := 50. 
  tiempoInvocacion:=100.
]

{ #category : #actions }
JefeFinal >> intentarInvocarNave [
| NavedelJefe |
	tiempoInvocacion := tiempoInvocacion - 1.
	(tiempoInvocacion <= 0) ifTrue: [
   
      tiempoInvocacion := 125. 
        
       NavedelJefe := AlienComun new. 
        
        
       NavedelJefe position: (self center - (15@0)). 
       
       NavedelJefe atacar: true. 
        
       ^ NavedelJefe. 
    ].

    ^ nil.
]

{ #category : #figures }
JefeFinal >> loadImage [ 
| original nombre |
    nombre := self nombreImagen.
    
    (nombre asFileReference exists) ifFalse: [ ^ self ].

    original := Form fromFileNamed: nombre.

    
    original := original mapColor: Color black to: Color transparent.
    
    imagen := original scaledToSize: 100@100.
    self extent: imagen extent.
]

{ #category : #image }
JefeFinal >> nombreImagen [
	^ 'boss.png'
]

{ #category : #movement }
JefeFinal >> realizarMovimientoDeAtaqueHacia: unaNave [
	| oscilacion nuevoX |
    
    
   self position: self position + (0 @ 0.2).
    
    
   (self top > 380) ifTrue: [ self position: (self position x @ 50) ]. 
    
   
   oscilacion := (Time millisecondClockValue / 5.0) sin * 5. 
    
    
   (self center x < unaNave center x) 
        ifTrue: [ self position: self position + (2 @ 0) ]
        ifFalse: [ self position: self position - (2 @ 0) ].
        
   
   self position: self position + (oscilacion @ 0).

	nuevoX := self position x.
   nuevoX := nuevoX max: 0.
   nuevoX := nuevoX min: (self owner width - self width).
	self position: nuevoX @ self position y.
]

{ #category : #control }
JefeFinal >> recibirDaño [
    vida := vida - 1.
	barraVida actualizarVida: vida.
    ^ vida <= 0 
]
