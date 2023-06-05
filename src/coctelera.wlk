import wollok.game.*
import config.*
import tragos.*
import sesion.*
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////// COCTELERA
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
object coctelera {
	const property ingredientes = []
	const property onzas = []
	
	const property position = game.at(84, 20)
	const property image = 'coctelera.png'

	method agregarIngredientes(ingrediente) {
		if(ingredientes.size() < 8){ 
			ingredientes.add(ingrediente)
			const onza = ingrediente.onza()
			self.onzas().add(onza)
			game.addVisualIn(onza, self.position().up(self.ingredientes().size() - 1))
		}
		else{ self.limpiarConSonido() }
	}
	
	method limpiar() {
		ingredientes.clear()
		self.onzas().forEach({ onza => game.removeVisual(onza) })
		self.onzas().clear()
	}
	
	method limpiarConSonido(){
		dialogo.contelera(self) 
		self.limpiar()
		configSonido.limpiar()
	}
	
	method preparado() = new Trago(ingredientes = self.ingredientes() )
	
	/*
	 * Autor: Any
	 * Instancia un objeto de la clase Trago
	 * TODO: Importar clase Trago
	 */
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////  IDEM COCTELERA PERO SIN SONIDOS NI VISUALES
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
object cocteleraParaTest {
	const property ingredientes = []
	const property onzas = []
	
	method agregarIngredientes(ingrediente) {
		if(ingredientes.size() < 8){ 
			ingredientes.add(ingrediente)
			const onza = ingrediente.onza()
			self.onzas().add(onza)
		}
		else{ self.limpiar() }
	}
	
	method limpiar() {
		ingredientes.clear()
		self.onzas().clear()
	}

	method preparado() = new Trago(ingredientes = self.ingredientes() )
	
}

