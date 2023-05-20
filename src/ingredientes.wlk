import wollok.game.*


object  fernet {
	var property image = 'botellaFernet.png'
	const property position = game.at(4, 8)
	const property text = 'Fernet'
	
	method onza() {
		return new Onza(image = 'onzaFernet.png')
	}
}
object  limon {
	var property image = 'botellaLimon.png'
	const property position = game.at(11, 8)
	const property text = 'Limón'
	
	method onza() {
		return new Onza(image = 'onzaLimon.png')
	}
}
object  coca{
	var property image = 'botellaCola.png'
	const property position = game.at(18, 8)
	const property text = 'Cola'
	
	method onza() {
		return new Onza(image = 'onzaCola.png')
	}
}

object  campari{
	var property image = 'botellaCampari.png'
	const property position = game.at(25, 8)
	const property text = 'Campi'
	
	method onza() {
		return new Onza(image = 'onzaCampari.png')
	}
}

object  naranja{
	var property image = 'botellaNaranja.png'
	const property position = game.at(32, 8)
	const property text = 'Orange'
	
	method onza() {
		return new Onza(image = 'onzaNaranja.png')
	}
}

class Onza {
	//var property position = game.origin()
	const property image 
}
