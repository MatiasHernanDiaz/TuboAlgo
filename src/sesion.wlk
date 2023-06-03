import config.*
import silla.*
import barman.*
import ingredientes.*
import coctelera.*
import tragos.*
import menu.*
import wollok.game.*


class Sesion {
	var property tiempoRestante = self.tiempoInicial()
	const property sillas = []
	const property ingredientes = [limon, naranja, tomate, cola, whisky, vodka, fernulo, ron]
	
	const property position = game.origin()
	const property image = 'fondo.png'
	
	method iniciar() {
		self.crearSillas()
		
		self.sillas().forEach({ silla => self.iniciarSilla(silla) })
		self.ingredientes().forEach({ ingr => game.addVisual(ingr) })
		propinero.dinero(0)
		
		game.addVisual(barman)
		game.addVisual(propinero)
		game.addVisual(propina)
		game.addVisual(coctelera)
		game.addVisual(reloj)
		
		game.onTick(1000, "controlReloj", { self.controlReloj() })
	}
	
	method terminar() {
		
		game.removeTickEvent("controlReloj")
		
		sillas.forEach({ silla => silla.terminar() })
		
		game.removeVisual(barman)
		configSonido.silencioTotal()
		
		game.addVisual(cartelFinal)
		game.addVisual(textoFinal)
	}
	
	method iniciarSilla(silla) {
		game.addVisual(silla)
		silla.iniciar()
	}
	
	method crearSillas()
	
	method propinaObjetivo()
	
	method tiempoInicial() = 100
	
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
	
	override method propinaObjetivo() = 3000
	
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
	
	override method propinaObjetivo() = 5000
	
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
	
	override method propinaObjetivo() = 8000
	
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

object reloj {
	const property position = game.at(2, game.height() - 5)
	method sesion() = config.sesion()
	method text() = self.sesion().tiempoRestante().toString()
}

object cartelFinal {
	const property position = game.at(30, 35)
	const property image = 'cartelFinal.png'
}

object textoFinal {
	const property position = game.at(47, 38)
	
	method text() = 'Obtuviste $' + propinero.dinero().toString() + 
					' de un objetivo de $' + config.sesion().propinaObjetivo() + '. ' + 
					self.textoResultado()
	
	method textoResultado() = if (config.sesion().propinaObjetivo() <= propinero.dinero()) '¡Ganaste!' else '¡Perdiste!'
}



