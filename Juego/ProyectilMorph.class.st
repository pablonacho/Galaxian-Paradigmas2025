Class {
	#name : #ProyectilMorph,
	#superclass : #EllipseMorph,
	#category : #Juego
}

{ #category : #initialization }
ProyectilMorph >> initialize [ 
	super initialize.
	self extent: 5@10. "tamano que van a tener las balas"
]

{ #category : #'stepping and presenter' }
ProyectilMorph >> step [ 	
		"cada hijo tiene su propia velocidad de bala"
	self position: self position + self velocidad.
	
	"verificacion de bordes"
	self owner ifNotNil: [
			
		(self bounds intersects: self owner bounds) ifFalse: [ self delete ].
		].
]

{ #category : #'model - stepping' }
ProyectilMorph >> stepTime [ 
	^20
]

{ #category : #accessing }
ProyectilMorph >> velocidad [
^self subclassResponsibility
]
