Class {
	#name : #EfectoVisualMorph,
	#superclass : #EllipseMorph,
	#category : #Juego
}

{ #category : #initialization }
EfectoVisualMorph >> initialize [ 	
	super initialize.
	self startStepping.
]

{ #category : #'stepping and presenter' }
EfectoVisualMorph >> step [
	^ self subclassResponsibility 
]

{ #category : #'model - stepping' }
EfectoVisualMorph >> stepTime [ 
	^self subclassResponsibility 
]
