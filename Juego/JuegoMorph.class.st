Class {
	#name : #JuegoMorph,
	#superclass : #Morph,
	#instVars : [
		'nave'
	],
	#category : #Juego
}

{ #category : #'crear enemigos' }
JuegoMorph >> crearEnemigos [
	| enemigos filas columnas espacioX espacioY |
	filas := 3.
	columnas := 7.
	espacioX := 60.
	espacioY := 50.

	enemigos := OrderedCollection new.
	1 to: filas do: [:fila |
		1 to: columnas do: [:columna |
			| enemigo x y |
			enemigo := NaveEnemiga new.
			self addMorph: enemigo.
			x := (columna * espacioX).
			y := (fila * espacioY).
			enemigo position: x@y.
			enemigos add: enemigo.
		].
	].

]

{ #category : #initialization }
JuegoMorph >> initialize [ 
	"Creamos area de juego"

	super initialize.
	self extent: 600@400.
	self color: Color black.
	nave:= NaveMorph new.
	self addMorph: nave.
	nave position: 300@300.
	self on: #keyDown send: #keyDown to: self.
	self takeKeyboardFocus.
	self crearEnemigos.

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
