Class {
	#name : #ExplosionMorph,
	#superclass : #EllipseMorph,
	#category : #Juego
}

{ #category : #initialization }
ExplosionMorph >> initialize [ 	
	super initialize.
		self color: Color orange.
		self extent: 10@10.
		self startStepping.
		
]

{ #category : #'stepping and presenter' }
ExplosionMorph >> step [ 
	self extent: self extent + (8@8).
	self center: self center.
	self color: (self color alpha:(self color alpha - 0.15)).
	self color alpha <= 0.1 ifTrue:[self delete].
]

{ #category : #'model - stepping' }
ExplosionMorph >> stepTime [ 
	^30
	
]
