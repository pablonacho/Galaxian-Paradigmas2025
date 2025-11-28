Class {
	#name : #DisparoMorph,
	#superclass : #ProyectilMorph,
	#category : #Juego
}

{ #category : #initialization }
DisparoMorph >> initialize [
	super initialize.
	self color: Color yellow.
	
]

{ #category : #accessing }
DisparoMorph >> velocidad [
	^ 0 @ -10
]
