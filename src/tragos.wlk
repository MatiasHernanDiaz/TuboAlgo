import ingredientes.*

//####   Tragos creados por la coctelera    #####
//###############################################
class Trago{
	const property ingredientes
	//const property cantidadShakes = 0
}

//####   Tragos    #####, cantidad maxima total 8 onzas de ingredientes
//######################, estas son las recetas a seguir a la hora de preparar los tragos solicitados
object fernetCoca inherits Trago(ingredientes = [fernet, fernet, fernet, coca, coca, coca, coca, coca]) {}

object fernetCordobes inherits Trago(ingredientes = [fernet, fernet, fernet, fernet, coca, coca, coca, coca]) {}

object garibaldi inherits Trago(ingredientes = [campari, campari, campari, naranja, naranja, naranja, naranja, naranja]) {}

//const vinoTinto = new Trago(ingredientes = [])

//const agua = new Trago(ingredientes = [agua], cantidades = [8], cantidadShakes = 0)

//const jugoNaranja = new Trago(ingredientes = [agua, pulpaNaranja], cantidades = [2, 6], cantidadShakes = 3)

//const jugoMultifruta= new Trago(ingredientes = [agua, pulpaLimon, pulpaUva, pulpaManzana], cantidades = [2, 2, 2, 2], cantidadShakes = 3)


//####  Carta #####, 1 carta por cada cliente, se elije un randon de la "const property carta"
//#################

object carta {
	const property vinos = [garibaldi]
	const property fernets = [fernetCoca, fernetCordobes]
	//const property sinAlcohol = [agua, jugoNaranja, jugoMultifruta]
	
	const property carta = [vinos, fernets].flatten()
	
	method elegirTrago() = carta.anyOne()

}
