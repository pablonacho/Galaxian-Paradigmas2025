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
    self bounds: (0@0 extent: 2@2). 
    self color: Color white.
    self beTransparent.

]
