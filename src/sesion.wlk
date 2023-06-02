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
//	method text() = tiempoRestante.toString()
//	method textPosition() = game.at(2, game.height() - 5)
	
	method iniciar() {
		self.crearSillas()
		
		self.sillas().forEach({ silla => self.iniciarSilla(silla) })
		self.ingredientes().forEach({ ingr => game.addVisual(ingr) })
		
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
		
		game.addVisual(cartelFinal)
		textoFinal.dineroObjetivo(self.propinaObjetivo())
		game.addVisual(textoFinal)
		//game.schedule(5000,{menuPrincipal.iniciar()})
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

object reloj {
	var property sesion = config.sesion()
	const property position = game.at(2, game.height() - 5)
	method text() = sesion.tiempoRestante().toString()
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



