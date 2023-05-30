import wollok.game.*
import sesion.*
///////////////////////////////////////////////////////////////
// 		MENU
//////////////////////////////////////////////////////////////
object menuPrincipal {
	
	method iniciar(){
		game.clear()
		game.addVisual(comenzar)
		game.addVisual(tutorial)
		game.addVisual(cartel)
		game.addVisual(salir)
		game.addVisual(selector)
		config.configMenuPrincipal()
		//const musicaDeMenu = game.sound("audio/menu.mp3")
		configSonido.musicaMenu()
		
		
	}
}

///////////////////////////////////////////////////////////////
// OPCIONES DE MENU
//////////////////////////////////////////////////////////////
object comenzar{
	const property position = game.at(45, 32)
	
	method aceptar(){
		configSonido.musicaMenuStop()
		game.clear()
		game.addVisual(fondoJuego)
		const sesion = new SesionFacil()
		config.iniciar(sesion)
		game.addVisual(sesion)
		sesion.iniciar()
	} 
	method seleccionado() = selector.position().y() == self.position().y()
	method image() = if(!self.seleccionado()) "comenzar.png" else "comenzarSeleccionado.png"
	method siguiente() = salir
	method anterior() = tutorial
}

object tutorial{
	const property position = game.at(45, 24)
	
	method aceptar(){
		game.clear()
		game.addVisual(fondoTutorial)
		game.addVisual(volverMenuPrincipal)
		config.configVolver()
		configSonido.seleccionOpcionMenu()
		
	} 
	method seleccionado() = selector.position().y() == self.position().y()
	method image() = if(!self.seleccionado()) "tutorial.png" else "tutorialSeleccionado.png"
	method siguiente() = comenzar
	method anterior() = cartel
}

object cartel{
	const property position = game.at(45, 16)
	
	method aceptar(){
		game.clear()
		game.addVisual(fondoCartel)
		game.addVisual(volverMenuPrincipal)
		config.configVolver()
		configSonido.seleccionOpcionMenu()
		
	} 
	method seleccionado() = selector.position().y() == self.position().y()
	method image() = if(!self.seleccionado()) "cartel.png" else "cartelSeleccionado.png"
	method siguiente() = tutorial
	method anterior() = salir
}

object salir{
	const property position = game.at(45, 8)
	
	method aceptar(){ game.stop() } 
	method seleccionado() = selector.position().y() == self.position().y()
	method image() = if(!self.seleccionado()) "salir.png" else "salirSeleccionado.png"
	method siguiente() = cartel
	method anterior() = comenzar
}

///////////////////////////////////////////////////////////////
// SELECTOR
//////////////////////////////////////////////////////////////
object selector{
	const property x = 25
	var property seleccionado = cartel
	var property position = game.at(x, cartel.position().y())
	
	method arriba(){ 
		seleccionado = seleccionado.siguiente()
		configSonido.seleccionMenu()
		self.position(game.at(x, seleccionado.position().y()))
	}
	
	method abajo(){ 
		seleccionado = seleccionado.anterior()
		configSonido.seleccionMenu()
		self.position(game.at(x, seleccionado.position().y()))
	}
}

object volverMenuPrincipal{
	const property position = game.at(10, 10)
	
	method aceptar(){
		game.clear()
		game.addVisual(comenzar)
		game.addVisual(tutorial)
		game.addVisual(cartel)
		game.addVisual(salir)
		game.addVisual(selector)
		config.configMenuPrincipal()
		configSonido.seleccionOpcionMenu()
	} 
	method seleccionado() = true
	method text() = "FLECHA IZQUIERA PARA VOLVER AL MENU PRINCIPAL"
	method textColor() = if(!self.seleccionado()) paleta.verde() else paleta.rojo()

}
///////////////////////////////////////////////////////////////
// 			FONDOS DE PANTALLA PARA CADA MENU
//////////////////////////////////////////////////////////////
object fondoMenuPrincipal{
	
}

object fondoJuego{
	const property position = game.origin()
	method image() = "fondo.png"
}

object fondoTutorial{
	const property position = game.center()
	method text() = "ACA ARMAR LA EXPLICACION DEL TUTORIAL"
	
	method regresar(){}//aca configurar botones para volver al menu principal 
}

object fondoCartel{
	const property position = game.center()
	method text() = "PROHIBIDA EL ALCOHOL A LOS MENORES DE 18 AÑOS, SI TIENE PROBLEMAS CON LA BEBIDA BUSQUE AYUDA PROFESIONAL"
	
	method regresar(){}//aca configurar botones para volver al menu principal 
}

object paleta {
	const property verde = "00FF00FF"
	const property rojo = "FF0000FF"
}

