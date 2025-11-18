Class {
	#name : #JuegoMorph,
	#superclass : #Morph,
	#instVars : [
		'nave'
	],
	#category : #Juego
}

{ #category : #open }
JuegoMorph class >> open [
    "Crea una ventana y dentro le coloca el morph del juego."
   | ventana juego |
   juego := self new.
   ventana := juego openInWindowLabeled: 'Galaxyan Paradigmas 2025'.
   ventana extent: 600@400.
	juego takeKeyboardFocus.
   ^ ventana
]

{ #category : #initialization }
JuegoMorph >> initialize [ 
	"Creamos area de juego"

	super initialize.
	self bounds: (0@0 extent: 600@400).
	self color: Color black.
	
	nave:= NaveMorph new.
	self addMorph: nave.
	nave position: 300@300.
	
	self on: #keyDown send: #keyDown to: self.
	self takeKeyboardFocus.
]

{ #category : #'event handling' }
JuegoMorph >> keyDown: unEvento [
	"Detecta las entradas por teclado para el movimiento o acciones de la nave"

	| tecla |
	tecla:= unEvento keyCharacter.
	(tecla = $A) ifTrue: [ nave moverIzquierda ].
	(tecla = $D) ifTrue: [ nave moverDerecha  ].
	(tecla = $W) ifTrue: [ nave disparar ].
]
