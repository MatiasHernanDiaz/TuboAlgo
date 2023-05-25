import silla.*
import barman.*
import ingredientes.*
import coctelera.*

import wollok.game.*

object config{
	
	var property sesion = null
	
	method config(){

		keyboard.right().onPressDo({barman.derecha()})
		keyboard.left().onPressDo({barman.izquierda()})
		keyboard.up().onPressDo({barman.seleccionar()})
		keyboard.down().onPressDo({coctelera.limpiar()})
		
		
		keyboard.num1().onPressDo({barman.entregar(self.sesion().sillas().get(0))})
		keyboard.num2().onPressDo({barman.entregar(self.sesion().sillas().get(1))})
		keyboard.num3().onPressDo({barman.entregar(self.sesion().sillas().get(2))})
		keyboard.num4().onPressDo({barman.entregar(self.sesion().sillas().get(3))})
		keyboard.num5().onPressDo({coctelera.limpiar()})
		
	}
	
	method iniciar(sesion_){
		self.sesion(sesion_)
		self.config()
		configSonido.musicaFondo()
	}
	
	
	
	
}

object configSonido{
	
	const musicaDeFondo = game.sound("audio/fondo1.mp3")
	
	method musicaFondo(){
		musicaDeFondo.shouldLoop(true)
		game.schedule(500, { musicaDeFondo.play()} )
		musicaDeFondo.volume(0.5)
	}
	
	method musicaFondoStop(){
		musicaDeFondo.stop()
	}
	
	method efectoBotella(){
		game.sound("audio/botellas.mp3").play()
	}
	
	method efectoPropina(){
		game.sound("audio/propina1.mp3").play()
	}
	
	method entrega(){game.sound("audio/entregaTrago.mp3").play()}
				
	
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
	const property ingredientes = [fernet, coca, campari, naranja, limon]
	
	const property position = game.at(2, game.height() - 5)
	method text() = tiempoRestante.toString()
	
	method iniciar() {
		self.crearSillas()
		
		self.sillas().forEach({ silla => self.iniciarSilla(silla) })
		self.ingredientes().forEach({ ingr => game.addVisual(ingr) })
		
		game.addVisual(barman)
		game.addVisual(propinero)
		game.addVisual(coctelera)
		
		game.onTick(1000, "controlReloj", { self.controlReloj() })
	}
	
	method terminar() {
		
		game.removeTickEvent("controlReloj")
		
		sillas.forEach({ silla => silla.terminar() })
		
		configSonido.musicaFondoStop()
		
		//config.resetearTeclado()
		
		game.removeVisual(barman)
		
		game.addVisual(new FinalSesion(objetivo = self.propinaObjetivo()))
		
		
	}
	
	method iniciarSilla(silla) {
		game.addVisual(silla)
		silla.iniciar()
	}
	
	method crearSillas()
	
	method propinaObjetivo()
	
	method tiempoInicial() = 30
	
	method controlReloj() {
		self.tiempoRestante(self.tiempoRestante() - 1)
		
		if(self.tiempoRestante() <= 0 or self.objetivoCumplido())
			self.terminar()
	}
	
	method objetivoCumplido()= self.propinaObjetivo() <= propinero.dinero()
	
	
}

class SesionFacil inherits Sesion {
	
	override method propinaObjetivo() = 10000
	
	override method crearSillas() {
		self.sillas().addAll([
			new SillaFria(position = game.at(16, 20), evento = 'e1'),
			new SillaTibia(position = game.at(32, 20), evento = 'e2'),
			new SillaTibia(position = game.at(48, 20), evento = 'e3'),
			new SillaCaliente(position = game.at(64, 20), evento = 'e4')
		])
	}
}

class SesionNormal inherits Sesion {
	
	override method propinaObjetivo() = 16000
	
	override method crearSillas() {
		self.sillas().addAll([
			new SillaFria(position = game.at(16, 19), evento = 'e1'),
			new SillaCaliente(position = game.at(30, 19), evento = 'e2'),
			new SillaTibia(position = game.at(44, 19), evento = 'e3'),
			new SillaCaliente(position = game.at(58, 19), evento = 'e4')
		])
	}
}

class SesionDificil inherits Sesion {
	
	override method propinaObjetivo() = 22000
	
	override method crearSillas() {
		self.sillas().addAll([
			new SillaTibia(position = game.at(16, 19), evento = 'e1'),
			new SillaCaliente(position = game.at(30, 19), evento = 'e2'),
			new SillaTibia(position = game.at(44, 19), evento = 'e3'),
			new SillaCaliente(position = game.at(58, 19), evento = 'e4')
		])
	}
}

class SesionParaTest inherits Sesion {
	
	override method propinaObjetivo() = 22000
	
	override method crearSillas() {
		self.sillas().addAll([
			new SillaParaTest(position = game.at(16, 19), evento = 'e1'),
			new SillaParaTest(position = game.at(30, 19), evento = 'e2'),
			new SillaParaTest(position = game.at(44, 19), evento = 'e3'),
			new SillaParaTest(position = game.at(58, 19), evento = 'e4')
		])
	}
}


class FinalSesion {
	const property objetivo
	const property position = game.center()
	
	
	method text() = 'Juego terminado. Obtuviste ' + propinero.dinero().toString() + ' de un objetivo de ' + self.objetivo()
	
	
}

