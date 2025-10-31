Class {
	#name : #NaveMorph,
	#superclass : #Morph,
	#instVars : [
		'x',
		'y'
	],
	#category : #Juego
}

{ #category : #shooting }
NaveMorph >> disparar [
	"comment stating purpose of message"

	Transcript show: 'Pew'; cr.
	
]

{ #category : #initialization }
NaveMorph >> initialize [
	"Aqui inicializamos la posicion de la nave y sus valores"

	super initialize.
	x:= 200.
	y:= 400.
	self bounds: (x @ y extent: 50 @ 30).  "posicion y tamaño de la nave"
	self color: Color red.
	self handlesKeyboard: true.   "Activa la recepcion de entradas a traves del teclado"
	self takeKeyboardFocus.  "Esta linea sirva para que los eventos por teclado vaya unicamente a esta clase"
]

{ #category : #events }
NaveMorph >> keyDown: anEvent [
	"Este metodo se ejecuta cada vez que se presiona una tecla"

	| tecla |
	tecla:= anEvent keyValue. 
	tecla = Character arrowLeft ifTrue: [ self moverIzquierda ].
	tecla = Character arrowRight ifTrue: [ self moverDerecha  ].
	tecla = Character arrowUp ifTrue: [ self disparar ].
]

{ #category : #movement }
NaveMorph >> moverDerecha [
	"metodo para que la nave se mueva a izquierda"

	self position: self position + (10 @ 0).
]

{ #category : #movement }
NaveMorph >> moverIzquierda [
	"metodo para que la nave se mueva a izquierda"

	self position: self position - (10 @ 0).
]

{ #category : #accesing }
NaveMorph >> x [
	"Posicion x"

	^x
]

{ #category : #accesing }
NaveMorph >> x: unValor [ 
	"Asignacion a x"

	x:= unValor
]

{ #category : #accesing }
NaveMorph >> y [
	"Posicion y"

	^y
]

{ #category : #accesing }
NaveMorph >> y: unValor [ 
	"Asignacion a y"

	y:= unValor
]
