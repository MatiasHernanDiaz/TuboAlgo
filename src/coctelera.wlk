import tragos.*

object coctelera {
	const property ingredientes = []
	const property cantidades = []

	method agregarIngredientes(ingrediente) {
		if(!ingredientes.contains(ingrediente)){
			ingrediente.aumentarOnza()
			ingredientes.add(ingrediente)
		}
		else
			ingredientes.filter({ingr => ingr==ingrediente}).get(0).aumentarOnza()
	}
	
	method limpiar() = ingredientes.clear()
	
	method entregar() = new Trago(ingredientes = self.ingredientes(), cantidades = self.cantidades())
	/*
	 * Autor: Any
	 * Instancia un objeto de la clase Trago
	 * TODO: Importar clase Trago
	 */
}
