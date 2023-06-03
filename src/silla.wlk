import cliente.*
import wollok.game.*
import tragos.*


class Silla {
	var property cliente = null
	
	const property position // Lo define la Sesión cuando crea la silla
		
	
	method iniciar() {
		game.onTick(1000, self.identity().toString(), { self.evaluarEstado() })
	}
	
	method terminar() {
		
		game.removeTickEvent(self.identity().toString())
		
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
		const nuevoCliente = [
			new ClienteConformista(silla = self),
			new ClienteMedio(silla = self),
			new ClienteExigente(silla = self)
		].anyOne()
		
		self.cliente(nuevoCliente)
		game.addVisual(self.cliente())
		if(game.allVisuals().contains(carta)) {
            game.removeVisual(carta)
            game.addVisual(carta)
            }
		self.cliente().iniciar()
	}
	
	method retirarCliente() {
		self.cliente().terminar()
		const cli = self.cliente()
		game.schedule(3000, {self.removerCliente(cli)})
		self.cliente(null)
	}
	
	method removerCliente(cli) {
		game.removeVisual(cli)
	}
}


class SillaFria inherits Silla {
	const property image = "sillaFria.png"
	
	override method probabilidadCliente() = 3
}

class SillaTibia inherits Silla {
	const property image = "sillaTibia.png"
	
	override method probabilidadCliente() = 6
}

class SillaCaliente inherits Silla {
	const property image = "sillaCaliente.png"
	
	override method probabilidadCliente() = 9
}

class SillaParaTest inherits Silla {
	override method probabilidadCliente() = 100
}
