import wollok.game.*


object  fernet {
	var property image = 'botellaMarron.png'
	const property position = game.at(4, 8)
	
	method onza() {
		return new Onza(image = 'onzaMarron.png')
	}
}
object  limon {
	var property image = 'botellaAmarilla.png'
	const property position = game.at(11, 8)
	
	method onza() {
		return new Onza(image = 'onzaAmarilla.png')
	}
}
object  coca{
	var property image = 'botellaRoja.png'
	const property position = game.at(18, 8)
	
	method onza() {
		return new Onza(image = 'onzaRoja.png')
	}
}

object  campari{
	var property image = 'botellaCeleste.png'
	const property position = game.at(25, 8)
	
	method onza() {
		return new Onza(image = 'onzaCeleste.png')
	}
}

object  naranja{
	var property image = 'botellaCeleste.png'
	const property position = game.at(32, 8)
	
	method onza() {
		return new Onza(image = 'onzaCeleste.png')
	}
}

class Onza {
	//var property position = game.origin()
	const property image 
}
