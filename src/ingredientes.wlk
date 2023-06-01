import wollok.game.*

class Ingrediente {
	const property nombre
	const property posicionX
	const property position = game.at(posicionX, 8)
	const property image = 'botella' + self.nombre() + '.png'
	//const property text = self.nombre()
	
	method onza() {
		return new Onza(image = 'onza' + self.nombre() + '.png')
	}
}
const limon = new Ingrediente(
	nombre = 'Limon',
	posicionX = 4
)

const naranja = new Ingrediente(
	nombre = 'Naranja',
	posicionX = 11
)

const tomate = new Ingrediente(
	nombre = 'Tomate',
	posicionX = 18
)

const cola = new Ingrediente(
	nombre = 'Cola',
	posicionX = 25
)

const whisky = new Ingrediente(
	nombre = 'Whisky',
	posicionX = 32
)

const vodka = new Ingrediente(
	nombre = 'Vodka',
	posicionX = 39
)

const fernulo = new Ingrediente(
	nombre = 'Fernulo',
	posicionX = 46
)

const ron = new Ingrediente(
	nombre = 'Ron',
	posicionX = 53
)





class Onza {
	//var property position = game.origin()
	const property image 
}
