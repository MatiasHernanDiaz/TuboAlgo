import cliente.*
import wollok.game.*
import tragos.*

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////      SILLAS
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class Silla {
	var property cliente = null
	
	const property position // Lo define la Sesión cuando crea la silla
		
	
	/* METODOS DE INICIO Y TERMINAR */
	method iniciar() {
		game.onTick(1000, self.identity().toString(), { self.evaluarEstado() })
	}
	
	method terminar() {
		game.removeTickEvent(self.identity().toString())
		
		if(self.estaOcupada())
			self.retirarCliente()
	}
	
	method probabilidadCliente() // Configura la probabilidad numérica de que ingrese un cliente a cada segundo
	
	// Evalúa si la silla está ocupada
	method estaOcupada() = self.cliente() != null
	
	
	method evaluarEstado() {
		/* Si la silla está desocupada, genera un número random para decidir si ingresa un cliente */
		if (not self.estaOcupada()) {
			const dado = new Range(start = 1, end = 100).anyOne()
			
			if (dado < self.probabilidadCliente()) {
				self.recibirCliente()
			}
		}
	}
	
	method recibirCliente() {
		/* Instancia un nuevo cliente, lo inicializa y lo incorpora al tablero */
		const nuevoCliente = [
			new ClienteConformista(silla = self),
			new ClienteMedio(silla = self),
			new ClienteExigente(silla = self)
		].anyOne()
		
		self.cliente(nuevoCliente)
		game.addVisual(self.cliente())
		
		// Pequeño truco para que los nuevos clientes no tapen la carta, si está desplegada.
		if(game.allVisuals().contains(carta)) {
            game.removeVisual(carta)
            game.addVisual(carta)
            }
		self.cliente().iniciar()
	}
	
	method retirarCliente() {
		// Finaliza al cliente actual y lo retira del tablero luego de tres segundos, para que pueda verse
		// su último diálogo
		self.cliente().terminar()
		const cli = self.cliente()
		game.schedule(3000, {game.removeVisual(cli)})
		self.cliente(null)
	}
}


/* SUBCLASES DE SILLA */
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

/* Subclases para test, con probabilidad total de que aparezcan cliente al inicio. */
class SillaParaTest inherits Silla {
	override method probabilidadCliente() = 100
}
