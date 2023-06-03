import wollok.game.*
import barman.*
import coctelera.*
import menu.*
import tragos.*


object config{
	
	var property sesion = null
	
	method iniciarJuego(sesion_){
		self.sesion(sesion_)
		self.tecladoJuego()
		game.addVisual(self.sesion())
		self.sesion().iniciar()
		configSonido.iniciarMusicaFondo()
	}
	
	method tecladoJuego(){

		keyboard.right().onPressDo({barman.derecha()})
		keyboard.left().onPressDo({barman.izquierda()})
		keyboard.up().onPressDo({barman.seleccionar()})
		keyboard.down().onPressDo({coctelera.limpiarConSonido()})
		
		
		keyboard.num1().onPressDo({barman.entregar(self.sesion().sillas().get(0))})
		keyboard.num2().onPressDo({barman.entregar(self.sesion().sillas().get(1))})
		keyboard.num3().onPressDo({barman.entregar(self.sesion().sillas().get(2))})
		keyboard.num4().onPressDo({barman.entregar(self.sesion().sillas().get(3))})
		keyboard.num5().onPressDo({coctelera.limpiar()})
		
		keyboard.space().onPressDo({carta.toggle()})
		
		keyboard.backspace().onPressDo({volverMenuPrincipal.aceptar()})
	}
	
	method tecladoMenu(){
		keyboard.up().onPressDo({selector.arriba()})
		keyboard.down().onPressDo({selector.abajo()})
		keyboard.enter().onPressDo({selector.seleccionado().aceptar()})
		keyboard.backspace().onPressDo({volverMenuPrincipal.aceptar()})
	}
}

object configSonido{
	
	const musicaDeFondo = game.sound("audio/fondo1.mp3")
	const musicaDeMenu = game.sound("audio/menu.mp3")
	
	method cargarAudio() {
		self.musicaMenu()
		self.musicaFondo()
	}
	
	method iniciarMusicaMenu() {
		musicaDeFondo.volume(0)
		musicaDeMenu.volume(0.5)
	}
	
	method iniciarMusicaFondo() {
		musicaDeMenu.volume(0)
		musicaDeFondo.volume(0.5)
	}
	
	method silencioTotal(){
		musicaDeMenu.volume(0)
		musicaDeFondo.volume(0)
	}
	
	method musicaFondo(){
		musicaDeFondo.shouldLoop(true)
		game.schedule(500, { musicaDeFondo.play()} )
		//musicaDeFondo.volume(0.5)
	}
	
	method musicaMenu(){
		musicaDeMenu.shouldLoop(true)
		game.schedule(500, { musicaDeMenu.play()} )
		//musicaDeMenu.volume(0)
	}
	
	//method musicaFondoStop(){musicaDeFondo.stop()}
	
	//method musicaMenuStop() {musicaDeMenu.stop()} // musicaDem
	
	method efectoBotella(){game.sound("audio/botellas.mp3").play()}
	
	method efectoPropina(){game.sound("audio/propina1.mp3").play()}

	method entrega(){game.sound("audio/entregaTrago1.mp3").play()}
	
	method win(){game.sound("audio/win.mp3").play()}
	
	method loser(){game.sound("audio/loser.mp3").play()}
	
	method limpiar(){game.sound("audio/limpiar.mp3").play()}
	
	method servir(){game.sound("audio/servir.mp3").play()}
	
	method seleccionOpcionMenu(){game.sound("audio/seleccion_opcion_menu1.mp3").play()}
	
	method seleccionMenu(){game.sound("audio/selector_menu1.mp3").play()}
				
}

object dialogo{
	
	const property tiempoFueraDialogos = ["¡Me cansé de esperar!","Me burrí","Te esperé mucho!"]
	
	const property faltaMucho = ["¿Falta mucho?","Sigo esperando...","¿Por qué tardas tanto?"]
	
	const property rico = ["Está rico!","Excelente","mmm delicioso"]
	
	const property noPedi = ["Esto no es lo que pedí","Jamás pedí esto","Creo que te confundiste"]
	
	const property satisfaccion1 = ["Al fin!","Mejor tarde que nunca","Pudo estar mejor"]
	
	const property satisfaccion2 = ["Estuvo bien","Con practica podes mejorar"]
	
	const property satisfaccion3 = ["Excelente trago!", "Impecable, te aplaudo","Oh, me sorprendiste"]
	
	const property tragoMal = ["Es asqueroso!", "Un espanto", "Es muy feo","Y pensar que te pagué"]
	
	method tiempoFuera(c){game.say(c, self.tiempoFueraDialogos().anyOne())}
	
	method faltaMucho(c){game.say(c, self.faltaMucho().anyOne())}
	
	method rico(c){game.say(c, self.rico().anyOne())}
	
	method noPedi(c){game.say(c, self.noPedi().anyOne())}
	
	method satisfaccion1(c){game.say(c, self.satisfaccion1().anyOne())}
	
	method satisfaccion2(c){game.say(c, self.satisfaccion2().anyOne())}
	
	method satisfaccion3(c){game.say(c, self.satisfaccion3().anyOne())}
	
	method tragoMal(c){game.say(c, self.tragoMal().anyOne())}
	
	method sillaVacia(s){ game.say(s, 'Esta silla está vacía')}
	
	method contelera(cot){game.say(cot, 'Te pasaste')}
}