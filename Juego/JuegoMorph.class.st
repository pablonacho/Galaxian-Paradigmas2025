Class {
	#name : #JuegoMorph,
	#superclass : #Morph,
	#instVars : [
		'nave',
		'enemigos',
		'direccion',
		'alienIzquierdoGuia',
		'alienDerechoGuia',
		'estrellas',
		'puntaje',
		'etiquetaPuntaje'
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
JuegoMorph >> crearEnemigos [
    | offsetX e posRelativa |
    enemigos := OrderedCollection new.
    offsetX := 120.

    1 to: 6 do: [:col |
        1 to: 4 do: [:fila |
            e := AlienMorph new.
            
            "Calculamos su posición relativa (su asiento)"
            posRelativa := ((col * 60) + offsetX) @ (fila * 50).
            
            "Se la guardamos al alien"
            e offsetOriginal: posRelativa.
            
            "Lo ubicamos en pantalla (Relativo a la ventana del juego)"
            e position: (self position + posRelativa).
            
            self addMorph: e.
            enemigos add: e.
        ].
    ].
]

{ #category : #initialization }
JuegoMorph >> crearEstrellas [
    | cantidad ancho alto |
    estrellas := OrderedCollection new.

    cantidad := 50.
    ancho := self bounds width.
    alto := self bounds height.

    1 to: cantidad do: [:i |
        | e x y brillo tamaño |

        e := EstrellaMorph new.

        x := (Random new nextInt: ancho).
        y := (Random new nextInt: alto).

        tamaño := #(1 2 2 3) atRandom.
        brillo := { Color white. Color veryLightGray. Color lightGray } atRandom.


        e extent: tamaño @ tamaño.
        e color: brillo.
        e position: x@y.

        self addMorphBack: e.
        estrellas add: e.
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
	
	puntaje := 0.
   etiquetaPuntaje := StringMorph new contents: 'Puntaje: 0'.
   etiquetaPuntaje color: Color white; position: 10@10.
   self addMorph: etiquetaPuntaje.
	
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
	self crearEstrellas.
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

{ #category : #movement }
JuegoMorph >> moverEnemigos [

   | enFormacion bordeDerecho bordeIzquierdo lider |

    enFormacion := enemigos select: [:e | e estaAtacando not].
    lider := enFormacion ifNotEmpty: [ enFormacion first ] ifEmpty: [ nil ].

    
    (enFormacion notEmpty and: [100 atRandom < 3]) ifTrue: [
        enFormacion atRandom atacar: true.
    ].

    enemigos do: [:e |
        e estaAtacando ifTrue: [
            
            
            e retornando ifTrue: [
                lider ifNotNil: [
                    | destino |
                    destino := lider position - lider offsetOriginal + e offsetOriginal.
                    
                    "Vuelo suave"
                    (e position dist: destino) > 5 
                        ifTrue: [ e position: e position + ((destino - e position) * 0.15) ]
                        ifFalse: [ 
                            "Llegó: Se sienta, apaga ataque y apaga retorno"
                            e position: destino.
                            e atacar: false.
                            e retornando: false. 
                        ]
                ]
            ]
            
            ifFalse: [
               
                e position: e position + (0@7).
                
               
                (e center x < nave center x) 
                    ifTrue: [ e position: e position + (3@0) ]
                    ifFalse: [ e position: e position - (3@0) ].
                    
               
                (e top > self bounds bottom) ifTrue: [
                    e position: (e position x @ (self bounds top - 50)).
                    e retornando: true. " <--- Aquí activamos la memoria"
                ].
            ].
        ].
    ].
    enFormacion ifEmpty: [ ^ self ].

    enFormacion do: [:e | e position: e position + (direccion @ 0) ].

    bordeDerecho := (enFormacion collect: [:e | e right]) max.
    bordeIzquierdo := (enFormacion collect: [:e | e left]) min.

    (bordeDerecho >= (self bounds right - 10) and: [direccion > 0]) ifTrue: [ direccion := -2 ].
    (bordeIzquierdo <= (self bounds left + 10) and: [direccion < 0]) ifTrue: [ direccion := 2 ].
]

{ #category : #movement }
JuegoMorph >> moverEstrellas [
    | alto |
    alto := self bounds height.

    estrellas do: [:e |
        e position: e position + (0@1).   "velocidad vertical"

        "Cuando salen de la pantalla, vuelven arriba"
        (e position y > alto) ifTrue: [
            e position: (e position x @ 0).
        ].
    ].

]

{ #category : #initialization }
JuegoMorph >> reiniciarJuego [
    self stopStepping.
    self submorphs do: [:m | 
        ((m isKindOf: AlienMorph) or: [m isKindOf: DisparoMorph]) ifTrue: [ m delete ] 
    ].
    enemigos removeAll.
    puntaje := 0.
    etiquetaPuntaje contents: 'Puntaje: 0'.
    
    "Reiniciar Nave también relativo al juego"
    nave position: (self position + (310@310)). 
    
    direccion := 2.
    self crearEnemigos. "Ahora usará las coordenadas relativas correctas"
    self startStepping.
    self takeKeyboardFocus.
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
				
				unDisparo delete.
				unAlien delete.
				
				enemigos remove: unAlien ifAbsent: []. "Sacarlo de la lista lógica"
            	puntaje := puntaje + 10.
            etiquetaPuntaje contents: 'Puntaje: ', puntaje asString.
			]
		]
	].

	self moverEnemigos.
	self moverEstrellas.
	
	enemigos isEmpty ifTrue: [
        self stopStepping. "Pausar el juego"
        
        (UIManager default confirm: '¡FELICITACIONES! Has ganado. ¿Jugar de nuevo?')
            ifTrue: [ self reiniciarJuego ]
            ifFalse: [ self delete ].
            
        ^ self "Salimos para no seguir procesando"
    ].
	

enemigos do: [:unAlien |
        (unAlien bounds intersects: nave bounds) ifTrue: [
            self stopStepping. "Pausar juego"
            
            (UIManager default confirm: '¡GAME OVER! ¿Quieres jugar de nuevo?')
                ifTrue: [ self reiniciarJuego ]
                ifFalse: [ self delete ]. "Cierra la ventana"
            ^ self "Salir del método step para evitar errores"
        ]
    ].
]

{ #category : #'model - stepping' }
JuegoMorph >> stepTime [ 
"Cada cuanto se chequean las colisiones"
	^50
]
