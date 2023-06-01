import wollok.game.*
import sesion.*
///////////////////////////////////////////////////////////////
// 		MENU
//////////////////////////////////////////////////////////////
object menuPrincipal {
	
	method cargarFondo(){game.addVisual(fondoMenuPrincipal)}
	method cargarOpciones(){
		game.addVisual(comenzar)
		game.addVisual(tutorial)
		game.addVisual(cartel)
		game.addVisual(salir)
		game.addVisual(selector)
	}
	method cargarConfiguracion(){config.configMenuPrincipal()}
	method cargarSonido(){configSonido.musicaMenu()}
	method iniciar(){
		game.clear()
		self.cargarFondo()
		self.cargarOpciones()
		self.cargarConfiguracion()
		//const musicaDeMenu = game.sound("audio/menu.mp3")
	}
}

///////////////////////////////////////////////////////////////
// OPCIONES DE MENU
//////////////////////////////////////////////////////////////
object comenzar{
	const property position = game.at(65, 32)
	
	method aceptar(){
		game.clear()
		configSonido.seleccionOpcionMenu()
		game.addVisual(fondoMenuPrincipal)
		game.addVisual(facil)
		game.addVisual(normal)
		game.addVisual(dificil)
		game.addVisual(selector)
		selector.ultimaSeleccion(self)
		game.addVisual(volverMenuPrincipal)
		selector.seleccionado(normal)
		config.configMenuPrincipal()
		config.configVolver()
	} 
	method seleccionado() = selector.position().y() == self.position().y()
	method image() = if(!self.seleccionado()) "comenzar.png" else "comenzarSeleccionado.png"
	method siguiente() = salir
	method anterior() = tutorial
}

object tutorial{
	const property position = game.at(65, 24)
	
	method aceptar(){
		game.clear()
		configSonido.seleccionOpcionMenu()
		game.addVisual(fondoMenuPrincipal)
		game.addVisual(fondoTutorial)
		game.addVisual(volverMenuPrincipal)
		selector.ultimaSeleccion(self)
		config.configVolver()
	} 
	method seleccionado() = selector.position().y() == self.position().y()
	method image() = if(!self.seleccionado()) "tutorial.png" else "tutorialSeleccionado.png"
	method siguiente() = comenzar
	method anterior() = cartel
}

object cartel{
	const property position = game.at(65, 16)
	
	method aceptar(){
		game.clear()
		configSonido.seleccionOpcionMenu()
		game.addVisual(fondoMenuPrincipal)
		game.addVisual(fondoCartel)
		game.addVisual(volverMenuPrincipal)
		selector.ultimaSeleccion(self)
		config.configVolver()
		
	} 
	method seleccionado() = selector.position().y() == self.position().y()
	method image() = if(!self.seleccionado()) "cartel.png" else "cartelSeleccionado.png"
	method siguiente() = tutorial
	method anterior() = salir
}

object salir{
	const property position = game.at(65, 8)
	
	method aceptar(){ game.stop() } 
	method seleccionado() = selector.position().y() == self.position().y()
	method image() = if(!self.seleccionado()) "salir.png" else "salirSeleccionado.png"
	method siguiente() = cartel
	method anterior() = comenzar
}

object facil{
	const property position = game.at(65, 32)
	
	method aceptar(){
		configSonido.seleccionOpcionMenu()
		configSonido.musicaMenuStop()
		game.clear()
		game.addVisual(fondoJuego)
		const sesion = new SesionFacil()
		config.iniciar(sesion)
		game.addVisual(sesion)
		sesion.iniciar()
	} 
	method seleccionado() = selector.position().y() == self.position().y()
	method image() = if(!self.seleccionado()) "facil.png" else "facilSeleccionado.png"
	method siguiente() = dificil
	method anterior() = normal
}
object normal{
	const property position = game.at(65, 24)
	
	method aceptar(){
		configSonido.seleccionOpcionMenu()
		configSonido.musicaMenuStop()
		game.clear()
		game.addVisual(fondoJuego)
		const sesion = new SesionNormal()
		config.iniciar(sesion)
		game.addVisual(sesion)
		sesion.iniciar()
	} 
	method seleccionado() = selector.position().y() == self.position().y()
	method image() = if(!self.seleccionado()) "normal.png" else "normalSeleccionado.png"
	method siguiente() = facil
	method anterior() = dificil
}
object dificil{
	const property position = game.at(65, 16)
	
	method aceptar(){
		configSonido.seleccionOpcionMenu()
		configSonido.musicaMenuStop()
		game.clear()
		game.addVisual(fondoJuego)
		const sesion = new SesionDificil()
		config.iniciar(sesion)
		game.addVisual(sesion)
		sesion.iniciar()
	} 
	method seleccionado() = selector.position().y() == self.position().y()
	method image() = if(!self.seleccionado()) "dificil.png" else "dificilSeleccionado.png"
	method siguiente() = normal
	method anterior() = facil
}

///////////////////////////////////////////////////////////////
// SELECTOR
//////////////////////////////////////////////////////////////
object selector{
	const property x = 25
	var property seleccionado = cartel
	var property ultimaSeleccion
	method position() = game.at(x, seleccionado.position().y())
	
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
	method text() = "FLECHA IZQUIERA PARA VOLVER AL MENU PRINCIPAL"
	method textColor() = if(!self.seleccionado()) paleta.verde() else paleta.rojo()

}
///////////////////////////////////////////////////////////////
// 			FONDOS DE PANTALLA PARA CADA MENU
//////////////////////////////////////////////////////////////
object fondoMenuPrincipal{
	const property position = game.origin()
	method image() = "turboAlgoLey2.png"
}

object fondoJuego{
	const property position = game.origin()
	method image() = "fondo.png"
}

object fondoTutorial{
	const property position = game.at(65,game.center().y())
	method text() = "ACA ARMAR LA EXPLICACION DEL TUTORIAL"
	
	method regresar(){}//aca configurar botones para volver al menu principal 
}

object fondoCartel{
	const property position = game.at(65,game.center().y())
	method text() = "PROHIBIDA EL ALCOHOL A LOS MENORES DE 18 AÑOS, SI TIENE PROBLEMAS CON LA BEBIDA BUSQUE AYUDA PROFESIONAL"
	
	method regresar(){}//aca configurar botones para volver al menu principal 
}

object paleta {
	const property verde = "00FF00FF"
	const property rojo = "FF0000FF"
}

