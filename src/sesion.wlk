import silla.*
import barman.*
import ingredientes.*
import coctelera.*
import tragos.*
import wollok.game.*
import menu.*

object config{
	
	var property sesion = null
	
	method config(){

		keyboard.right().onPressDo({barman.derecha()})
		keyboard.left().onPressDo({barman.izquierda()})
		keyboard.up().onPressDo({barman.seleccionar()})
		keyboard.down().onPressDo({coctelera.limpiarConSonido()})
		
		
		keyboard.num1().onPressDo({barman.entregar(self.sesion().sillas().get(0))})
		keyboard.num2().onPressDo({barman.entregar(self.sesion().sillas().get(1))})
		keyboard.num3().onPressDo({barman.entregar(self.sesion().sillas().get(2))})
		keyboard.num4().onPressDo({barman.entregar(self.sesion().sillas().get(3))})
		keyboard.num5().onPressDo({coctelera.limpiar()})
		
		keyboard.space().onPressDo({carta.toggle()})
		
	}
	
	method iniciar(sesion_){
		self.sesion(sesion_)
		self.config()
		configSonido.musicaFondo()
	}
	
	method configMenuPrincipal(){
		keyboard.up().onPressDo({selector.arriba()})
		keyboard.down().onPressDo({selector.abajo()})
		keyboard.right().onPressDo({selector.seleccionado().aceptar()})
		
	}
	method configVolver(){
		keyboard.left().onPressDo({volverMenuPrincipal.aceptar()})
	}
	
}

object configSonido{
	
	const musicaDeFondo = game.sound("audio/fondo1.mp3")
	
	method musicaFondo(){
		musicaDeFondo.shouldLoop(true)
		game.schedule(500, { musicaDeFondo.play()} )
		musicaDeFondo.volume(0.5)
	}
	
	method musicaFondoStop(){musicaDeFondo.stop()}
	
	method efectoBotella(){game.sound("audio/botellas.mp3").play()}
	
	method efectoPropina(){game.sound("audio/propina1.mp3").play()}

	method entrega(){game.sound("audio/entregaTrago1.mp3").play()}
	
	method win(){game.sound("audio/win.mp3").play()}
	
	method loser(){game.sound("audio/loser.mp3").play()}
	
	method limpiar(){game.sound("audio/limpiar.mp3").play()}
	
	method servir(){game.sound("audio/servir.mp3").play()}
				
}

object dialogo{
	
	method tiempoFuera(c){game.say(c, "¡Me cansé de esperar!")}
	
	method faltaMucho(c){game.say(c, "¿Falta mucho?")}
	
	method rico(c){game.say(c, 'Está rico!')}
	
	method noPedi(c){game.say(c, 'Esto no es lo que pedí.')}
	
	method satisfaccion1(c){game.say(c, "Deja que desear.")}
	
	method satisfaccion2(c){game.say(c, "Estuvo bien pero puede estar mejor")}
	
	method satisfaccion3(c){game.say(c, "Sos lo más. Excelente trago")}
	
	method tragoMal(c){game.say(c, "Es muy feo!")}
	
	method sillaVacia(s){ game.say(s, 'Esta silla está vacía')}
	
	method contelera(cot){game.say(cot, 'Te pasaste')}
				
	
	
}

class Sesion {
	var property tiempoRestante = self.tiempoInicial()
	const property sillas = []
	const property ingredientes = [limon, naranja, tomate, cola, whisky, vodka, fernulo, ron]
	
	const property position = game.at(2, game.height() - 5)
	method text() = tiempoRestante.toString()
	
	method iniciar() {
		self.crearSillas()
		
		self.sillas().forEach({ silla => self.iniciarSilla(silla) })
		self.ingredientes().forEach({ ingr => game.addVisual(ingr) })
		
		game.addVisual(barman)
		game.addVisual(propinero)
		game.addVisual(propina)
		game.addVisual(coctelera)
		
		game.onTick(1000, "controlReloj", { self.controlReloj() })
	}
	
	method terminar() {
		
		game.removeTickEvent("controlReloj")
		
		sillas.forEach({ silla => silla.terminar() })

		configSonido.musicaFondoStop()
		
		game.removeVisual(barman)
		
		game.addVisual(cartelFinal)
		textoFinal.dineroObjetivo(self.propinaObjetivo())
		game.addVisual(textoFinal)
	}
	
	method iniciarSilla(silla) {
		game.addVisual(silla)
		silla.iniciar()
	}
	
	method crearSillas()
	
	method propinaObjetivo()
	
	method tiempoInicial() = 60
	
	method controlReloj() {
		self.tiempoRestante(self.tiempoRestante() - 1)
		
		if(self.tiempoRestante() <= 0 or self.objetivoCumplido()){
			if(self.objetivoCumplido()){
				configSonido.win()
				self.terminar()				
			}
			else{
				configSonido.loser()
				self.terminar()
			}
		}
	}
	
	method objetivoCumplido() = self.propinaObjetivo() <= propinero.dinero()	
}

class SesionFacil inherits Sesion {
	
	override method propinaObjetivo() = 100
	
	override method crearSillas() {
		self.sillas().addAll([
			new SillaFria(position = game.at(16, 20)),
			new SillaTibia(position = game.at(32, 20)),
			new SillaTibia(position = game.at(48, 20)),
			new SillaCaliente(position = game.at(64, 20))
		])
	}
}

class SesionNormal inherits Sesion {
	
	override method propinaObjetivo() = 16000
	
	override method crearSillas() {
		self.sillas().addAll([
			new SillaFria(position = game.at(16, 20)),
			new SillaCaliente(position = game.at(30, 20)),
			new SillaTibia(position = game.at(44, 20)),
			new SillaCaliente(position = game.at(58, 20))
		])
	}
}

class SesionDificil inherits Sesion {
	
	override method propinaObjetivo() = 22000
	
	override method crearSillas() {
		self.sillas().addAll([
			new SillaTibia(position = game.at(16, 20)),
			new SillaCaliente(position = game.at(30, 20)),
			new SillaTibia(position = game.at(44, 20)),
			new SillaCaliente(position = game.at(58, 20))
		])
	}
}

class SesionParaTest inherits Sesion {
	
	override method propinaObjetivo() = 22000
	
	override method crearSillas() {
		self.sillas().addAll([
			new SillaParaTest(position = game.at(16, 20)),
			new SillaParaTest(position = game.at(30, 20)),
			new SillaParaTest(position = game.at(44, 20)),
			new SillaParaTest(position = game.at(58, 20))
		])
	}
}


object cartelFinal {
	const property position = game.at(30, 35)
	const property image = 'cartelFinal.png'
}

object textoFinal {
	var property dineroObjetivo
	const property position = game.at(47, 38)
	
	method text() = 'Obtuviste $' + propinero.dinero().toString() + 
					' de un objetivo de $' + self.dineroObjetivo() + '. ' + 
					self.textoResultado()
	
	method textoResultado() = if (self.dineroObjetivo() <= propinero.dinero()) '¡Ganaste!' else '¡Perdiste!'
}



