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
	|unAlien|
	
	super initialize.
	self bounds: (0@0 extent: 600@400).
	self color: Color black.
	
	nave:= NaveMorph new.
	self addMorph: nave.
	nave position: 300@300.
	
	unAlien := AlienMorph new.
	unAlien position: 100@100.
	self addMorph: unAlien.
	
	
	
	self on: #keyDown send: #keyDown to: self.
	self takeKeyboardFocus.
	self startStepping.
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

{ #category : #'stepping and presenter' }
JuegoMorph >> step [ 	
	| disparos aliens |
	
	"Obtenemos colecciones de los disparos y aliens actuales en el tablero"
	disparos := self submorphs select: [:m | m isKindOf: DisparoMorph].
	aliens := self submorphs select: [:m | m isKindOf: AlienMorph].

	disparos do: [:unDisparo |
		aliens do: [:unAlien |
			"Chequeamos colisión"
			(unDisparo bounds intersects: unAlien bounds) ifTrue: [
				"Efecto de colisión: borrar ambos y (opcional) sumar puntos"
				unDisparo delete.
				unAlien delete.
				
				"Aquí podrían agregar sonido o sumar score"
			]
		]
	]
]

{ #category : #'model - stepping' }
JuegoMorph >> stepTime [ 
"Cada cuanto se chequean las colisiones"
	^50
]
