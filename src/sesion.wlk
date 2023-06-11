import config.*
import silla.*
import barman.*
import ingredientes.*
import coctelera.*
import tragos.*
import menu.*
import wollok.game.*

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////      SESIONES / INSTANCIAS DEL JUEGO
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class Sesion {
	var property tiempoRestante = self.tiempoInicial()
	const property sillas = []
	const property position_y_sillas = 20
	const property ingredientes = [limon, naranja, tomate, cola, whisky, vodka, fernulo, ron]
	
	const property position = game.origin()
	const property image = 'fondo.png'
	
	/* METODOS DE INICIO Y TERMINAR */
	method iniciar() {
		/* Instancia las sillas y pone en el tablero los elementos del juego */
		self.crearSillas()
		
		self.sillas().forEach({ silla => self.iniciarSilla(silla) })
		self.ingredientes().forEach({ ingr => game.addVisual(ingr) })
		propinero.dinero(0)
		
		game.addVisual(barman)
		game.addVisual(propinero)
		game.addVisual(propina)
		game.addVisual(coctelera)
		game.addVisual(reloj)
		
		// Inicia el control de tiempo 
		game.onTick(1000, "controlReloj", { self.controlReloj() })
	}
	
	method terminar() {
		/* Remueve los elementos del juego, detiene el reloj y dispara
		 * el cartel de finalización
		 */
		game.removeTickEvent("controlReloj")
		
		sillas.forEach({ silla => silla.terminar() })
		
		game.clear()
		configSonido.silencioTotal()
		config.tecladoFinal()
		game.addVisual(self)
		game.addVisual(propinero)
		game.addVisual(propina)
		game.addVisual(coctelera)
		game.addVisual(reloj)
		sillas.forEach({ silla => game.addVisual(silla) })		
		game.addVisual(cartelFinal)
		game.addVisual(textoFinal)
	}
	
	method iniciarSilla(silla) {
		/* Activa el funcionamiento independiente de las sillas */
		game.addVisual(silla)
		silla.iniciar()
	}
	
	method crearSillas() // Instancia las sillas de la sesión; serán de 
						// distinto tipo según la subclase
	
	method propinaObjetivo() // Determina el monto de dinero necesario para 
							// ganar la partida (depende de la subclase)
	
	method tiempoInicial() = 100 // Configura el tiempo de duración para todas
								// las sesiones
	
	method controlReloj() {
		/* Controla el tiempo y la finalización del juego */
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
	
	// Evalúa el resultado final del juego
	method objetivoCumplido() = self.propinaObjetivo() <= propinero.dinero()	
}


/* SUBCLASES DE SESIÓN */
class SesionFacil inherits Sesion {
	
	override method propinaObjetivo() = 3000
	
	override method crearSillas() {
		self.sillas().addAll([
			new SillaFria(position = game.at(16, position_y_sillas)),
			new SillaTibia(position = game.at(32, position_y_sillas)),
			new SillaTibia(position = game.at(48, position_y_sillas)),
			new SillaCaliente(position = game.at(64, position_y_sillas))
		])
	}
}

class SesionNormal inherits Sesion {
	
	override method propinaObjetivo() = 5000
	
	override method crearSillas() {
		self.sillas().addAll([
			new SillaFria(position = game.at(16, position_y_sillas)),
			new SillaCaliente(position = game.at(30, position_y_sillas)),
			new SillaTibia(position = game.at(44, position_y_sillas)),
			new SillaCaliente(position = game.at(58, position_y_sillas))
		])
	}
}

class SesionDificil inherits Sesion {
	
	override method propinaObjetivo() = 8000
	
	override method crearSillas() {
		self.sillas().addAll([
			new SillaTibia(position = game.at(16, position_y_sillas)),
			new SillaCaliente(position = game.at(30, position_y_sillas)),
			new SillaTibia(position = game.at(44, position_y_sillas)),
			new SillaCaliente(position = game.at(58, position_y_sillas))
		])
	}
}

/* Subclase especial para TEST (instancia elementos preparados para testing) */
class SesionParaTest inherits Sesion {
	
	override method propinaObjetivo() = 100
	
	override method iniciar(){
		super()
		game.removeVisual(barman)
		game.removeVisual(coctelera)
		game.addVisual(barmanParaTest)
		game.addVisual(cocteleraParaTest)
	}
	override method terminar() {
		game.removeTickEvent("controlReloj")
		
		sillas.forEach({ silla => silla.terminar() })
		
		game.removeVisual(barmanParaTest)
		configSonido.silencioTotal()
		
		game.addVisual(cartelFinal)
		game.addVisual(textoFinal)
	}
	override method crearSillas() {
		self.sillas().addAll([
			new SillaParaTest(position = game.at(16, position_y_sillas)),
			new SillaParaTest(position = game.at(30, position_y_sillas)),
			new SillaParaTest(position = game.at(44, position_y_sillas)),
			new SillaParaTest(position = game.at(58, position_y_sillas))
		])
	}
	override method controlReloj() {
		/* Controla el tiempo y la finalización del juego */
		self.tiempoRestante(self.tiempoRestante() - 1)
		
		if(self.tiempoRestante() <= 0 or self.objetivoCumplido()){
			if(self.objetivoCumplido()){
				//configSonido.win()
				self.terminar()				
			}
			else{
				//configSonido.loser()
				self.terminar()
			}
		}
	}
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////  ELEMENTOS EXTRA
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
object reloj {
	/* Objeto con función puramente visual: muestra el tiempo de la sesión */
	const property position = game.at(2, game.height() - 5)
	method sesion() = config.sesion()
	method text() = self.sesion().tiempoRestante().toString()
	method textColor() = paleta.blanco()
}

object cartelFinal {
	/* Objeto con función puramente visual: le da fondo a la leyenda final */
	const property position = game.at(30, 35)
	const property image = 'cartelFinal.png'
}

object textoFinal {
	/* Leyenda final: anuncia los resultado del juego */
	const property position = game.at(47, 38)
	
	method text() = 'Obtuviste $' + propinero.dinero().toString() + 
					' de un objetivo de $' + config.sesion().propinaObjetivo() + '. ' + 
					self.textoResultado()
	
	method textoResultado() = if (config.sesion().propinaObjetivo() <= propinero.dinero()) '¡Ganaste!' else '¡Perdiste!'
}
