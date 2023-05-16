
class Ingrediente{
	var property vacio = false
	var property image = if(!vacio) 'pepita.png' else 'pepita.png'
	var property cantidadOnzas = 0
	
	method aumentarOnza() = cantidadOnzas++
}

//#### Ingredientes #####
//#######################
//DESCRIPCION:El bartender tiene que reponer los ingredientes, apretando una tecla 
//			se agrega la animacion de una botella vacia, y una llena
//			con el mensaje que no se puede seguir porque esta vacio
//			Se instancian 1 vez para agregar el ingrediente a la carta.
class BotellaCoca inherits Ingrediente(image = 'pepita.png'){}
const coca = new BotellaCoca()

class BotellaFernet inherits Ingrediente(image = 'pepita.png'){}
const fernet = new BotellaFernet()

class BotellaCamparo inherits Ingrediente(image = 'pepita.png'){}

class BotellaGinebra inherits Ingrediente(image = 'pepita.png'){}

class BotellaVodka inherits Ingrediente(image = 'pepita.png'){}

class BotellaGancia inherits Ingrediente(image = 'pepita.png'){}

class BotellaAgua inherits Ingrediente(image = 'pepita.png'){}
const aguaMineral = new BotellaAgua()

class SifonSoda inherits Ingrediente(image = 'pepita.png'){}
const soda= new SifonSoda()

class BidonPulpaNaranja inherits Ingrediente(image = 'pepita.png'){}
const pulpaNaranja = new BidonPulpaNaranja()

class BidonPulpaManzana inherits Ingrediente(image = 'pepita.png'){}
const pulpaManzana = new BidonPulpaManzana()

class BidonPulpaUva inherits Ingrediente(image = 'pepita.png'){}
const pulpaUva = new BidonPulpaUva()

class BidonPulpaLimon inherits Ingrediente(image = 'pepita.png'){}
const pulpaLimon = new BidonPulpaLimon()
