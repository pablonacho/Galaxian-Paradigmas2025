Class {
	#name : #JuegoMorph,
	#superclass : #Morph,
	#instVars : [
		'nave',
		'enemigos',
		'direccion',
		'alienIzquierdoGuia',
		'alienDerechoGuia'
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

{ #category : #'as yet unclassified' }
JuegoMorph >> crearEnemigos [
    | offsetX e |

    enemigos := OrderedCollection new.

    offsetX := 120.

    1 to: 6 do: [:col |
        1 to: 4 do: [:fila |
            e := AlienMorph new.
            e position: ((col * 60) + offsetX) @ (fila * 50).
            self addMorph: e.
            enemigos add: e.

            "Asignar guías"
            (col = 1 and: [ fila = 1 ]) ifTrue: [ alienIzquierdoGuia := e ].
            (col = 6 and: [ fila = 1 ]) ifTrue: [ alienDerechoGuia := e ].
        ].
    ].

]

{ #category : #initialization }
JuegoMorph >> initialize [ 
	"Creamos area de juego"
	"|unAlien|"
	
	super initialize.
	self bounds: (0@0 extent: 600@400).
	self extent: 600@400.
	self color: Color black.
	
	nave:= NaveMorph new.
	self addMorph: nave.
	nave position: 300@300.
	
	enemigos := OrderedCollection new.
   alienIzquierdoGuia := nil.
   alienDerechoGuia := nil.
	self crearEnemigos.
	direccion := 2.
	
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

{ #category : #'as yet unclassified' }
JuegoMorph >> moverEnemigos [
    enemigos isEmpty ifTrue: [ ^ self ].

    "Mover todos"
    enemigos do: [:e |
        e position: e position + (direccion @ 0).
    ].

    "Verificar que los guías no sean nil"
    (alienIzquierdoGuia isNil or: [alienDerechoGuia isNil]) ifTrue: [
        ^ self
    ].

    "Rebote derecha"
    (alienDerechoGuia right >= (self bounds right - 10)) ifTrue: [
        direccion := direccion negated.
    ].

    "Rebote izquierda"
    (alienIzquierdoGuia left <= (self bounds left + 10)) ifTrue: [
        direccion := direccion negated.
    ].

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
	].

	self moverEnemigos 
]

{ #category : #'model - stepping' }
JuegoMorph >> stepTime [ 
"Cada cuanto se chequean las colisiones"
	^50
]
