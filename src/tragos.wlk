import ingredientes.*

//####   Tragos creados por la coctelera    #####
//###############################################
class Trago{
	const property ingredientes = []
	const property cantidades = []
	const property cantidadShakes = 0
}

//####   Clase abstracta, solo para diferenciar trago instanciado de tragos disponibles #####
//###########################################################################################
class Receta inherits Trago{}

//####   Tragos    #####, cantidad maxima total 8 onzas de ingredientes
//######################, estas son las recetas a seguir a la hora de preparar los tragos solicitados
const fernetCoca = new Receta(ingredientes = [fernet, coca], cantidades = [3, 5], cantidadShakes = 1)

const fernetCordobes = new Receta(ingredientes = [fernet, coca], cantidades = [5, 3], cantidadShakes = 1)

const vino = new Receta(ingredientes = [pulpaUva, soda, soda], cantidades = [2, 4, 2], cantidadShakes = 2)

const vinoTinto = new Receta(ingredientes = [pulpaUva, soda], cantidades = [8], cantidadShakes = 1)

const agua = new Receta(ingredientes = [agua], cantidades = [8], cantidadShakes = 0)

const jugoNaranja = new Receta(ingredientes = [agua, pulpaNaranja], cantidades = [2, 6], cantidadShakes = 3)

const jugoMultifruta= new Receta(ingredientes = [agua, pulpaLimon, pulpaUva, pulpaManzana], cantidades = [2, 2, 2, 2], cantidadShakes = 3)


//####  Carta #####, 1 carta por cada cliente, se elije un randon de la "const property carta"
//#################

class  Carta{
	const property vinos = [vino, vinoTinto]
	const property fernets = [fernetCoca, fernetCordobes]
	const property sinAlcohol = [agua, jugoNaranja, jugoMultifruta]
	
	const property carta = [vinos, fernets, sinAlcohol].flatten()
}
