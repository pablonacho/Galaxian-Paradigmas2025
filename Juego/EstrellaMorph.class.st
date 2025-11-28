Class {
	#name : #EstrellaMorph,
	#superclass : #EfectoVisualMorph,
	#category : #Juego
}

{ #category : #initialization }
EstrellaMorph >> initialize [
    super initialize.
    self color: Color white.
    self beTransparent.
	 
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
