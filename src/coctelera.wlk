import tragos.*
import wollok.game.*
import sesion.*

object coctelera {
	const property ingredientes = []
	const property onzas = []
	//const property cantidades = []
	//var property cantidadShakes = 0
	
	const property position = game.at(84, 20)
	const property image = 'coctelera.png'

	method agregarIngredientes(ingrediente) {
		if(ingredientes.size() < 8){ 
			ingredientes.add(ingrediente)
			
			const onza = ingrediente.onza()
			self.onzas().add(onza)
			game.addVisualIn(onza, self.position().up(self.ingredientes().size() - 1))
		}
		else{ 
			//game.say(self, 'Te pasaste')
			dialogo.contelera(self)
			self.limpiar()
			configSonido.limpiar()
			
		}
	}
	
	method limpiar() {
		ingredientes.clear()
		self.onzas().forEach({ onza => game.removeVisual(onza) })
		self.onzas().clear()
	}
	
	method limpiarConSonido(){
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
