import wollok.game.*
import config.*
import tragos.*
import sesion.*

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////// COCTELERA
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
object coctelera{
	const property ingredientes = []
	const property onzas = []
	const property position = game.at(84, 20)
	const property image = 'coctelera.png'
	
	/* Métodos para gestionar los ingredientes a nivel lógico */
	method agregarIngredientes(ingrediente) {
		// Valida que los ingredientes agregados no superen la capacidad máxima de la coctelera
		if(ingredientes.size() < 8){ 	
			ingredientes.add(ingrediente)
			self.agregarOnzas(ingrediente)
		}
		else{ self.limpiarConSonido() }
	}
	
	method limpiar() {
		ingredientes.clear()
		self.quitarOnzas()
	}
	
	/* Métodos para gestionar los ingredientes a nivel visual */
	method agregarOnzas(ingrediente){
		const onza = ingrediente.onza()
		self.onzas().add(onza)
		game.addVisualIn(onza, self.position().up(self.ingredientes().size() - 1))
	}
	
	method quitarOnzas(){
		self.onzas().forEach({ onza => game.removeVisual(onza) })
		self.onzas().clear()
	}
	
	/* Gestión de los sonidos de la coctelera */
	method sonidosYDialogos(){
		dialogo.contelera(self) 
		configSonido.limpiar()
	}
	method limpiarConSonido(){
		self.limpiar()
		self.sonidosYDialogos()
	}
	
	// Devuelve el trago elaborado hasta el momento de su llamada
	method preparado() = new Trago(ingredientes = self.ingredientes() )
	
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////  IDEM COCTELERA PERO SIN SONIDOS NI VISUALES
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
object cocteleraParaTest {
	const property ingredientes = []
	const property onzas = []
	const property position = game.at(84, 20)
	const property image = 'coctelera.png'
	
	method agregarOnzas(ingrediente){
		const onza = ingrediente.onza()
		self.onzas().add(onza)
	}
	method agregarIngredientes(ingrediente) {
		if(ingredientes.size() < 8){ 
			ingredientes.add(ingrediente)
			self.agregarOnzas(ingrediente)
		}
		else{ self.limpiar() }
	}
	
	method quitarOnzas(){
		self.onzas().clear()
	}
	method limpiar() {
		ingredientes.clear()
		self.quitarOnzas()
	}

	method preparado() = new Trago(ingredientes = self.ingredientes())
} 
