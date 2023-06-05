import wollok.game.*
import barman.*
import coctelera.*
import menu.*
import tragos.*
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////  CONFIGURACIONES
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
		//Agrupa todas las configuraciones del teclado
		
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
	//Agrupa todos los efectos de sonido
	
	const musicaDeFondo = soundProducer.sound("audio/fondo1.mp3")
	const musicaDeMenu = soundProducer.sound("audio/menu.mp3")
	
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
	}
	
	method musicaMenu(){
		musicaDeMenu.shouldLoop(true)
		game.schedule(500, { musicaDeMenu.play()} )
	}
	
	method efectoBotella(){	soundProducer.sound("audio/botellas.mp3").play()}
	
	method efectoPropina(){	soundProducer.sound("audio/propina1.mp3").play()}

	method entrega(){soundProducer.sound("audio/entregaTrago1.mp3").play()}
	
	method win(){soundProducer.sound("audio/win.mp3").play()}
	
	method loser(){soundProducer.sound("audio/loser.mp3").play()}
	
	method limpiar(){soundProducer.sound("audio/limpiar.mp3").play()}
	
	method servir(){soundProducer.sound("audio/servir.mp3").play()}
	
	method seleccionOpcionMenu(){soundProducer.sound("audio/seleccion_opcion_menu1.mp3").play()}
	
	method seleccionMenu(){ soundProducer.sound("audio/selector_menu1.mp3").play() }
				
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////   SOUND PRODUCER. LEER 'Explicacion de conceptops' DE WOLLOK GAME
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
object soundProducer {
	
	var provider = game
	
	method provider(_provider){provider = _provider}
	
	method sound(audioFile) = provider.sound(audioFile)
	
}

object soundProviderMock {
	
	method sound(audioFile) = "mock"
	
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////   DIALOGOS
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
object dialogo{
	//Agrupa todo los dialogos
	
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
	
	method dameUn(c){game.say(c, 'Dame ' + c.tragoPedido().toString())}
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////   COLORES => Red,Green,Blue,Intensity => Cada value con rango (00-FF)
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
object paleta {
	const property verde = "00FF00FF"
	const property rojo = "FF0000FF"
	const property negro = "000000FF"
	const property blanco = "FFFFFFFF"
}

