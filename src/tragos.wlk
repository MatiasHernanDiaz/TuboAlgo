import ingredientes.*

import wollok.game.*

//####   Tragos creados por la coctelera    #####
//###############################################
class Trago{
	const property ingredientes
	//const property cantidadShakes = 0
}

//####   Tragos    #####, cantidad maxima total 8 onzas de ingredientes
//######################, estas son las recetas a seguir a la hora de preparar los tragos solicitados
object fernCola inherits Trago(ingredientes = [fernulo, fernulo, fernulo, cola, cola, cola, cola, cola]) {}

object fernCordobes inherits Trago(ingredientes = [fernulo, fernulo, fernulo, fernulo, cola, cola, cola, cola]) {}

object manhattan inherits Trago(ingredientes = [whisky, whisky, whisky, whisky, tomate, tomate, tomate, tomate]) {}

object destorni inherits Trago(ingredientes = [naranja, naranja, naranja, vodka, vodka, vodka, vodka, vodka]) {}

object vodkaFizz inherits Trago(ingredientes = [vodka, vodka, vodka, vodka, limon, limon, limon, limon]) {}

object sexBeach inherits Trago(ingredientes = [vodka, vodka, limon, limon, limon, naranja, naranja, naranja]) {}

object johnCollins inherits Trago(ingredientes = [whisky, whisky, whisky, whisky, whisky, whisky, naranja, limon]) {}

object cubaLibre inherits Trago(ingredientes = [cola, cola, cola, limon, limon, ron, ron, ron]) {}

object bloodyMary inherits Trago(ingredientes = [tomate, tomate, tomate, limon, vodka, vodka, vodka, vodka]) {}

object deadAwaker inherits Trago(ingredientes = [whisky, whisky, ron, ron, vodka, vodka, fernulo, fernulo]) {}

//####  Carta #####, 1 carta por cada cliente, se elije un randon de la "const property carta"
//#################

object carta {	
	const property carta = [
			fernCola, fernCordobes, manhattan, destorni, vodkaFizz, sexBeach,
			johnCollins, cubaLibre, bloodyMary, deadAwaker
		]
		
	const property position = game.at(3, 3)
	const property image = 'carta.png'
	
	method elegirTrago() = carta.anyOne()
	
	method toggle() {
		if(game.allVisuals().contains(self))
			game.removeVisual(self)
		else
			game.addVisual(self)
	}

}
