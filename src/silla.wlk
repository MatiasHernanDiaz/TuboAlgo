import cliente.*
import wollok.game.*


class Silla {
	var property cliente = false
	
	const property evento
	
	const property position // Lo define la Sesión cuando crea la silla
		
	
	method iniciar() {
		game.onTick(1000, self.evento(), { self.evaluarEstado() })
	}
	
	method terminar() {
		game.removeTickEvent(self.evento())
		
		if(self.estaOcupada())
			self.retirarCliente()
	}
	
	method probabilidadCliente()
	
	method estaOcupada() = self.cliente() != false
	
	method evaluarEstado() {
		if (not self.estaOcupada()) {
			const dado = new Range(start = 1, end = 100).anyOne()
			
			if (dado < self.probabilidadCliente()) {
				self.recibirCliente()
			}
		}
	}
	
	method recibirCliente() {
		const nuevoCliente = [
			new ClienteConformista(silla = self),
			new ClienteMedio(silla = self),
			new ClienteExigente(silla = self)
		].anyOne()
		
		self.cliente(nuevoCliente)
		game.addVisual(self.cliente())
		self.cliente().iniciar()
	}
	
	method retirarCliente() {
		self.cliente().terminar()
		game.removeVisual(self.cliente())
		self.cliente(false)
	}
}


class SillaFria inherits Silla {
	const property image = "sillaFria.png"
	
	override method probabilidadCliente() = 6
}

class SillaTibia inherits Silla {
	const property image = "sillaTibia.png"
	
	override method probabilidadCliente() = 10
}

class SillaCaliente inherits Silla {
	const property image = "sillaCaliente.png"
	
	override method probabilidadCliente() = 12
}

class SillaParaTest inherits Silla {
	override method probabilidadCliente() = 100
}
