Class {
	#name : #DisparoEnemigoMorph,
	#superclass : #ProyectilMorph,
	#category : #Juego
}

{ #category : #initialization }
DisparoEnemigoMorph >> initialize [ 
	super initialize.
	self color: Color orange.
	
]

{ #category : #accessing }
DisparoEnemigoMorph >> velocidad [
	^0 @ 10
]
