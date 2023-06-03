import wollok.game.*
import config.*
import sesion.*
import coctelera.*
///////////////////////////////////////////////////////////////
// 		MENU
//////////////////////////////////////////////////////////////
object menuPrincipal {
	method cargarOpciones(){
		game.addVisual(comenzar)
		game.addVisual(tutorial)
		game.addVisual(cartel)
		game.addVisual(salir)
	}
	method iniciar(){
		game.clear()
		self.cargarOpciones()
		config.tecladoMenu()
		configSonido.iniciarMusicaMenu()
	}
}

///////////////////////////////////////////////////////////////
// OPCIONES GENERALES DEL MENU
//////////////////////////////////////////////////////////////
class OpcionMenu {
	const property position
	const property visuales
	const property siguiente
	const property anterior
	const property nombre
	
	method aceptar() {
		game.clear()
		configSonido.seleccionOpcionMenu()
		visuales.forEach({ visual => game.addVisual(visual) })
		selector.ultimaSeleccion(self)
		config.tecladoMenu()
	}
	
	method seleccionado() = selector.seleccionado() === self
	method image() = if(!self.seleccionado()) self.nombre() + '.png' else self.nombre() + 'Seleccionado.png'
}

object comenzar inherits OpcionMenu(
	position = game.at(65, 32), 
	visuales = [facil, normal, dificil, volverMenuPrincipal],
	siguiente = salir, 
	anterior = tutorial,
	nombre = 'comenzar'
) {
	override method aceptar() {
		super()
		selector.seleccionado(normal)
	}
}


object tutorial inherits OpcionMenu(
	position = game.at(65, 24), 
	visuales = [volverMenuPrincipal],
	siguiente = comenzar, 
	anterior = cartel,
	nombre = 'tutorial'
) {}


object cartel inherits OpcionMenu(
	position = game.at(65, 16), 
	visuales = [volverMenuPrincipal],
	siguiente = tutorial, 
	anterior = salir,
	nombre = 'cartel'
) {}


object salir inherits OpcionMenu(
	position = game.at(65, 8), 
	visuales = null,
	siguiente = cartel, 
	anterior = comenzar,
	nombre = 'salir'
) {
	override method aceptar() { game.stop() }
}

///////////////////////////////////////////////////////////////
// OPCIONES  DE INICIO DEL JUEGO
//////////////////////////////////////////////////////////////
class OpcionNivelSesion inherits OpcionMenu {
	method nuevaSesion()
	override method aceptar(){
		game.clear()
		coctelera.ingredientes().clear()
		coctelera.onzas().clear()
		selector.ultimaSeleccion(comenzar)
		config.iniciarJuego(self.nuevaSesion()) // Debe ser una Sesión
		configSonido.iniciarMusicaFondo()
	}
}


object facil inherits OpcionNivelSesion(
	position = game.at(65, 32),
	visuales = [], 
	siguiente = dificil, 
	anterior = normal,
	nombre = 'facil'
) {
	override method nuevaSesion(){
		return new SesionFacil()
	}
}


object normal inherits OpcionNivelSesion(
	position = game.at(65, 24),
	visuales = [], 
	siguiente = facil, 
	anterior = dificil,
	nombre = 'normal'
) {
	override method nuevaSesion(){
		return new SesionNormal()
	}
}


object dificil inherits OpcionNivelSesion(
	position = game.at(65, 16),
	visuales = [], 
	siguiente = normal, 
	anterior = facil,
	nombre = 'dificil'
) {
	override method nuevaSesion(){
		return new SesionDificil()
	}
}


///////////////////////////////////////////////////////////////
// SELECTOR
//////////////////////////////////////////////////////////////
object selector{
	var property seleccionado = comenzar
	var property ultimaSeleccion = null
	
	method arriba(){ 
		seleccionado = seleccionado.siguiente()
		configSonido.seleccionMenu()
	}
	
	method abajo(){ 
		seleccionado = seleccionado.anterior()
		configSonido.seleccionMenu()
	}
}


object volverMenuPrincipal{
	const property position = game.at(10, 10)
	
	method aceptar(){
		configSonido.seleccionOpcionMenu()		
		selector.seleccionado(selector.ultimaSeleccion())
		menuPrincipal.iniciar()
	}
	
	method seleccionado() = true
	method text() = "BACKSPACE PARA VOLVER AL MENU PRINCIPAL"
}

