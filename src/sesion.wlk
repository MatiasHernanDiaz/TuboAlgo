import silla.*
import barman.*
import ingredientes.*
import coctelera.*

import wollok.game.*

object config{
	method config(){
		keyboard.right().onPressDo({=> barman.derecha()})
		keyboard.left().onPressDo({=> barman.izquierda()})
		keyboard.up().onPressDo({=> barman.seleccionar()})
		keyboard.down().onPressDo({coctelera.limpiar()})
		
		/*
		keyboard.num1().onPressDo({barman.entregar(silla1)})
		keyboard.num2().onPressDo({barman.entregar(silla2)})
		keyboard.num3().onPressDo({barman.entregar(silla3)})
		keyboard.num4().onPressDo({barman.entregar(silla4)})
		keyboard.num5().onPressDo({coctelera.limpiar()})
		*/
	}
	
}

class Sesion {
	var property tiempoRestante = self.tiempoInicial()
	const property sillas = []
	const property ingredientes = [fernet, coca, campari, naranja, limon]
	
	const property position = game.at(2, game.height() - 5)
	
	method iniciar() {
		self.crearSillas()
		
		self.sillas().forEach({ silla => self.iniciarSilla(silla) })
		self.ingredientes().forEach({ ingr => game.addVisual(ingr) })
		
		game.addVisual(barman)
		game.addVisual(coctelera)
		
		config.config()
		
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
	
	method tiempoInicial() = 300
	
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
			new SillaFria(position = game.at(16, 19), evento = 'e1'),
			new SillaTibia(position = game.at(30, 19), evento = 'e2'),
			new SillaTibia(position = game.at(44, 19), evento = 'e3'),
			new SillaCaliente(position = game.at(58, 19), evento = 'e4')
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


object finalSesion {
	const property position = game.center()
	
	method text() = 'Terminó'
}
