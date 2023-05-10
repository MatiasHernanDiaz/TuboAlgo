import silla.*
import barman.*

import wollok.game.*


class Sesion {
	var property tiempoRestante = self.tiempoInicial()
	const property sillas = []
	
	const property position = game.at(1, game.height() - 1)
	
	method iniciar() {
		sillas.forEach({ silla => self.iniciarSilla(silla) })
		
		game.onTick(1000, "controlReloj", { self.controlReloj() })
	}
	
	method terminar() {
		sillas.forEach({ silla => silla.terminar() })
		
		game.removeTickEvent("controlReloj")
		
		game.removeVisual(barman)
		
		game.addVisual(finalSesion)
	}
	
	method iniciarSilla(silla) {
		game.addVisual(silla)
		silla.iniciar()
	}
	
	method crearSillas()
	
	method propinaObjetivo()
	
	method text() = tiempoRestante.toString()
	
	method tiempoInicial() = 10
	
	method controlReloj() {
		self.tiempoRestante(self.tiempoRestante() - 1)
		
		if(self.tiempoRestante() == 0)
			self.terminar()
		
	}
}

class SesionFacil inherits Sesion {
	
	override method propinaObjetivo() = 10000
	
	override method crearSillas() {
		self.sillas().addAll([
			new SillaFria(position = game.at(3, 2)),
			new SillaTibia(position = game.at(3, 4)),
			new SillaTibia(position = game.at(3, 8)),
			new SillaCaliente(position = game.at(3, 10))
		])
	}
}

class SesionNormal inherits Sesion {
	
	override method propinaObjetivo() = 16000
	
	override method crearSillas() {
		self.sillas().addAll([
			new SillaFria(position = game.at(3, 2)),
			new SillaCaliente(position = game.at(3, 4)),
			new SillaTibia(position = game.at(3, 8)),
			new SillaCaliente(position = game.at(3, 10))
		])
	}
}

class SesionDificil inherits Sesion {
	
	override method propinaObjetivo() = 22000
	
	override method crearSillas() {
		self.sillas().addAll([
			new SillaTibia(position = game.at(3, 2)),
			new SillaCaliente(position = game.at(3, 4)),
			new SillaTibia(position = game.at(3, 8)),
			new SillaCaliente(position = game.at(3, 10))
		])
	}
}

class SesionParaTest inherits Sesion {
	
	override method propinaObjetivo() = 22000
	
	override method crearSillas() {
		self.sillas().addAll([
			new SillaParaTest(position = game.at(3, 2)),
			new SillaParaTest(position = game.at(3, 4)),
			new SillaParaTest(position = game.at(3, 8)),
			new SillaParaTest(position = game.at(3, 10))
		])
	}
}




object finalSesion {
	const property position = game.center()
	
	method text() = 'Terminó'
}
