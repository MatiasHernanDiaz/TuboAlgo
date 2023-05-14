import wollok.game.*

object coctelera {
	var property image = "algunaimagen" //customizar 
	var property position = new Position(x=10, y=20) //customizar 
	const property ingredientes = #{}
	
	method agregarIngredientes(ingrediente) {
		if(!ingredientes.contains(ingrediente)){
			ingrediente.aumentarOnza()
			ingredientes.add(ingrediente)
		}
		else
			ingredientes.asList().filter({ingr => ingr==ingrediente}).get(0).aumentarOnza()
	}
	
	method limpiar() = ingredientes.clear()
	
	/*
	 * Autor: Any
	 * Instancia un objeto de la clase Trago
	 * TODO: Importar clase Trago
	 */
//	method entregar(){
//		return new Trago(ingredientes = self.ingredientes())
//	}
}
