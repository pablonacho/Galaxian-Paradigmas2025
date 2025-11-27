Class {
	#name : #EstrellaMorph,
	#superclass : #Morph,
	#category : #Juego
}

{ #category : #drawing }
EstrellaMorph >> drawOn: aCanvas [
    aCanvas fillRectangle: self bounds color: self color.

]

{ #category : #initialization }
EstrellaMorph >> initialize [
    super initialize.
	 self bounds width.
    self color: Color white.
    self beTransparent.
	 self startStepping.
]

{ #category : #initialization }
EstrellaMorph >> step [ 	
	(20 atRandom = 1) ifTrue: [
        self color = Color transparent
            ifTrue: [ 
                "Encender: Volvemos a poner un color visible aleatorio"
                self color: {Color white. Color lightGray. Color veryLightGray} atRandom.
            ]
            ifFalse: [ 
                "Apagar: La hacemos transparente"
                self color: Color transparent.
            ]
    ].
]

{ #category : #initialization }
EstrellaMorph >> stepTime [ 
	^200 atRandom + 100
]
