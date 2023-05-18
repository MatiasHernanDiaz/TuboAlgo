import tragos.*
import wollok.game.*

object coctelera {
	const property ingredientes = []
	const property onzas = []
	//const property cantidades = []
	//var property cantidadShakes = 0
	
	const property position = game.at(73, 18)
	const property image = 'coctelera.png'

	method agregarIngredientes(ingrediente) {
		if(ingredientes.size() < 8){ 
			ingredientes.add(ingrediente)
			
			const onza = ingrediente.onza()
			self.onzas().add(onza)
			game.addVisualIn(onza, game.at(73, 17 + self.ingredientes().size()))
		}
		else{ 
			game.say(self, 'Te pasaste')
			self.limpiar()
		}
	}
	
	method limpiar() {
		
		ingredientes.clear()
		self.onzas().forEach({ onza => game.removeVisual(onza) })
		self.onzas().clear()
			
	}
	
	method preparado() = new Trago(ingredientes = self.ingredientes() )
	
	/*
	 * Autor: Any
	 * Instancia un objeto de la clase Trago
	 * TODO: Importar clase Trago
	 */
}
