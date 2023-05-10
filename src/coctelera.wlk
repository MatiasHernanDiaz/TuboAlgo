object coctelera {
	const property ingredientes = []
	
	method agregarIngredientes(ingrediente) {
		if(!ingredientes.contains(ingrediente)){
			ingrediente.aumentarOnza()
			ingredientes.add(ingrediente)
		}
		else
			ingredientes.filter({ingr => ingr==ingrediente}).get(0).aumentarOnza()
	}
	
	/*
	 * Autor: Any
	 * Instancia un objeto de la clase Trago
	 * TODO: Importar clase Trago
	 */
//	method entregarCoctel(){
//		return new Trago(ingredientes = self.ingredientes())
//	}
}
