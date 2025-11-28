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
   ventana extent: 800@600.
	juego takeKeyboardFocus.
   ^ ventana
]

{ #category : #initialization }
JuegoMorph >> crearEnemigos [
    | offsetX e posRelativa debeCrear claseAlien |
    enemigos := OrderedCollection new.
    offsetX := 50. 

    1 to: 6 do: [:fila |
        1 to: 10 do: [:col |
            
            debeCrear := false.

           
            (fila >= 4) ifTrue: [ debeCrear := true ].
            (fila = 3 and: [col between: 2 and: 9]) ifTrue: [ debeCrear := true ].
            (fila = 2 and: [col between: 3 and: 8]) ifTrue: [ debeCrear := true ].
            (fila = 1 and: [col = 4 or: [col = 7]]) ifTrue: [ debeCrear := true ].

            debeCrear ifTrue: [
                
                
                claseAlien := AlienComun.
                
                "Si es fila 2 o 3, usamos el Rapido (rojos)"
                (fila = 2 or: [fila = 3]) ifTrue: [ claseAlien := AlienRapido ].
                
                "Si es fila 1, usamos el Jefe"
                (fila = 1) ifTrue: [ claseAlien := AlienJefe ].
                
                "Instanciamos la clase que elegimos arriba"
                e := claseAlien new.
                
             
                posRelativa := ((col * 60) + offsetX) @ (fila * 50).
                
                e offsetOriginal: posRelativa.
                e position: (self position + posRelativa).
                
              
                
                self addMorph: e.
                enemigos add: e.
            ].
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

        tamaño := #(2 3 4 5) atRandom.
        brillo := { Color white. Color veryLightGray. Color lightGray } atRandom.


        e extent: tamaño @ tamaño.
        e color: brillo.
        e position: x@y.

        self addMorphBack: e.
        estrellas add: e.
    ].

]

{ #category : #actions }
JuegoMorph >> crearExplosion: unPuntoCenral [
	|boom|
	boom:=ExplosionMorph new.
	boom center: unPuntoCenral.
	self addMorph: boom.
]

{ #category : #initialization }
JuegoMorph >> initialize [ 
	"Creamos area de juego"
	
	
	super initialize.
	self bounds: (0@0 extent: 800@600).
	self extent: 800@600.
	self color: Color black.
	
	puntaje := 0.
   etiquetaPuntaje := StringMorph new contents: 'Puntaje: 0'.
   etiquetaPuntaje color: Color white; position: 10@10.
   self addMorph: etiquetaPuntaje.
	
	nave:= NaveMorph new.
	self addMorph: nave.
	nave position: 300@500.
	
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
               
             	e realizarMovimientoDeAtaqueHacia: nave.
                    
               
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

{ #category : #initialization }
JuegoMorph >> reiniciarJuego [
    self stopStepping.
    self submorphs do: [:m | 
        ((m isKindOf: AlienMorph) or: [(m isKindOf: DisparoMorph) or: [m isKindOf: DisparoEnemigoMorph]])
			ifTrue: [ m delete ] 
    ].
    enemigos removeAll.
    puntaje := 0.
    etiquetaPuntaje contents: 'Puntaje: 0'.
 
	(nave owner isNil) ifTrue:[ self addMorph: nave].   
    "Reiniciar Nave también relativo al juego"
    nave position: (self position + (300@500)). 
	    

    direccion := 2.
    self crearEnemigos. "Ahora usará las coordenadas relativas correctas"
    self startStepping.
    self takeKeyboardFocus.
]

{ #category : #'stepping and presenter' }
JuegoMorph >> step [ 	
	| disparos aliens disparosEnemigos atacantes |
	
	"Obtenemos colecciones de los disparos y aliens actuales en el tablero"
	disparos := self submorphs select: [:m | m isKindOf: DisparoMorph].
	aliens := self submorphs select: [:m | m isKindOf: AlienMorph].

	disparos do: [:unDisparo |
		aliens do: [:unAlien |
			"Chequeamos colisión"
			(unDisparo bounds intersects: unAlien bounds) ifTrue: [
				self crearExplosion: unAlien center.
				unDisparo delete.
				unAlien delete.
				
				enemigos remove: unAlien ifAbsent: []. "Sacarlo de la lista lógica"
            	puntaje := puntaje + 10.
            etiquetaPuntaje contents: 'Puntaje: ', puntaje asString.
			]
		]
	].
	(enemigos notEmpty and: [100 atRandom < 3]) ifTrue: [
		enemigos atRandom disparar.
	].

	
	disparosEnemigos := self submorphs select: [:m | m isKindOf: DisparoEnemigoMorph].
	
	disparosEnemigos do: [:balaMala |
		(balaMala bounds intersects: nave bounds) ifTrue: [	balaMala delete. nave delete.
			self crearExplosion: nave center.
			self stopStepping.
			(UIManager default confirm: '¡TE DIERON! Fin del juego. ¿Reiniciar?')
				ifTrue: [ self reiniciarJuego ]
				ifFalse: [ self delete ].
			^ self "Salimos ya"
		]
	].
	atacantes := enemigos select:[:x| x estaAtacando ].
		
	(atacantes notEmpty and:[100 atRandom < 5]) ifTrue:[ atacantes atRandom disparar.
		].

	self moverEnemigos.
	
	
	enemigos isEmpty ifTrue: [
        self stopStepping. "Pausar el juego"
        
        (UIManager default confirm: '¡FELICITACIONES! Has ganado. ¿Jugar de nuevo?')
            ifTrue: [ self reiniciarJuego ]
            ifFalse: [ self delete ].
            
        ^ self "Salimos para no seguir procesando"
    ].
	

enemigos do: [:unAlien |
        (unAlien bounds intersects: nave bounds) ifTrue: [
				self crearExplosion: nave center.
				unAlien delete. nave delete.
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
