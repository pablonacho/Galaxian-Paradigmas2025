Class {
	#name : #BarraVidaMorph,
	#superclass : #Morph,
	#instVars : [
		'valorMaximo',
		'valorActual'
	],
	#category : #Juego
}

{ #category : #control }
BarraVidaMorph >> actualizarVida: nuevaVida [
	valorActual := nuevaVida.
	self changed.
]

{ #category : #drawing }
BarraVidaMorph >> drawOn: aCanvas [
	super drawOn: aCanvas.
    
    
    (valorActual notNil and: [valorMaximo notNil]) ifTrue: [
        | anchoVerde |
        anchoVerde := (self width * (valorActual / valorMaximo)) max: 0.
        aCanvas fillRectangle: (self bounds origin extent: anchoVerde @ self height) color: Color green.
    ].
    
   
    aCanvas frameRectangle: self bounds width: 2 color: Color white.
]

{ #category : #initialization }
BarraVidaMorph >> initialize [ 
    super initialize.
    self color: Color red. 
    self extent: 400@20.  
    valorMaximo := 50.
    valorActual := 50.
]
