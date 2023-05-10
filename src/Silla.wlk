import Cliente.*

import wollok.game.*


class Silla {
	var property cliente = null
	
	const property position // Lo define la Sesión cuando crea la silla
	const property image = "silla.png"
	
	
	method iniciar() {
		game.onTick(1000, "evaluarEstado", { self.evaluarEstado() })
	}
	
	method terminar() {
		game.removeTickEvent("evaluarEstado")
		
		if(self.estaOcupada())
			self.retirarCliente()
	}
	
	method probabilidadCliente()
	
	method estaOcupada() = self.cliente() != null
	
	method evaluarEstado() {
		if (not self.estaOcupada()) {
			const dado = new Range(start = 1, end = 100).anyOne()
			
			if (dado < self.probabilidadCliente()) {
				self.recibirCliente()
			}
		}
	}
	
	method recibirCliente() {
		self.cliente(new Cliente(silla = self))
		game.addVisual(self.cliente())
		self.cliente().iniciar()
	}
	
	method retirarCliente() {
		self.cliente().terminar()
		game.removeVisual(self.cliente())
		self.cliente(null)
	}
}


class SillaFria inherits Silla {
	override method probabilidadCliente() = 15
}

class SillaTibia inherits Silla {
	override method probabilidadCliente() = 10
}

class SillaCaliente inherits Silla {
	override method probabilidadCliente() = 6
}

class SillaParaTest inherits Silla {
	override method probabilidadCliente() = 100
}
