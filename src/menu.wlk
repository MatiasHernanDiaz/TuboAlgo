import wollok.game.*
import config.*
import sesion.*
import coctelera.*
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////// 				MENU PRINCIPAL
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
object menuPrincipal {
	method cargarOpciones(){
		// Carga de visuales
		game.addVisual(comenzar)
		game.addVisual(tutorial)
		game.addVisual(cartel)
		game.addVisual(salir)
	}
	
	/* MÉTODO DE INICIO */
	method iniciar(){
		game.clear()
		self.cargarOpciones()
		config.tecladoMenu()
		configSonido.iniciarMusicaMenu()
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////  OPCIONES DEL MENU PRINCIPAL
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class OpcionMenu {
	const property position
	const property visuales
	const property siguiente
	const property anterior
	const property nombre
	
	method aceptar() {
		// Ejecuta las acciones requeridas al presionar un botón.
		game.clear()
		configSonido.seleccionOpcionMenu()
		visuales.forEach({ visual => game.addVisual(visual) })
		selector.ultimaSeleccion(self)
		config.tecladoMenu()
	}
	
	// El botón se autosetea como seleccionado por el selector
	method seleccionado() = selector.seleccionado() === self
	
	// Elije la imagen correspondiente a su estado
	method image() = if(!self.seleccionado()) self.nombre() + '.png' else self.nombre() + 'Seleccionado.png'
}

/* Opciones del menú inicial */
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
	visuales = [volverMenuPrincipal,tutorialDescripcion],
	siguiente = comenzar, 
	anterior = cartel,
	nombre = 'tutorial'
) {}

object cartel inherits OpcionMenu(
	position = game.at(65, 16), 
	visuales = [volverMenuPrincipal,creditos],
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

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////   OPCIONES DE DIFICULTAD
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class OpcionNivelSesion inherits OpcionMenu {
	method nuevaSesion()
	override method aceptar(){
		// Asegura el reinicio del tablero y la configuración antes de una nueva sesión
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

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////   SELECTOR Y BOTON PARA VOLVER
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
object selector{
	var property seleccionado = comenzar
	var property ultimaSeleccion = null
	
	/* Movimientos del selector y selección de la opción correspondiente */
	method arriba(){ 
		seleccionado = seleccionado.siguiente()
		configSonido.seleccionMenu()
	}
	
	method abajo(){ 
		seleccionado = seleccionado.anterior()
		configSonido.seleccionMenu()
	}
}

/* Opción de retorno de todas las pantallas secundarias */
object volverMenuPrincipal{
	const property position = game.at(16, 7)
	
	method aceptar(){
		configSonido.seleccionOpcionMenu()		
		selector.seleccionado(selector.ultimaSeleccion())
		menuPrincipal.iniciar()
	}
	
	method seleccionado() = true
	method image() = "backspace.png"
}

/////////////////////////////////////////////////////////////////////////////////////
///////////// PANTALLAS SECUNDARIAS
////////////////////////////////////////////////////////////////////////////////////
object tutorialDescripcion{
	var property position = game.at(3,3)
	method image() = "tutorial-descripcion.png"
}

object creditos{
	var property position = game.at(53, 4)
	method image() = "creditos-nombres.png"
}