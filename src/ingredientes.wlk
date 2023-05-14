import wollok.game.*

class Ingredientes {
	var property nombre
	var property image = "algunaimagen"
	var property position = new Position(x=10, y=20)
	var property cantidadOnzas = 0
	
	method aumentarOnza() = cantidadOnzas++
}