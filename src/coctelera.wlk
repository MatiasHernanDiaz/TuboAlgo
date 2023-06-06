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
	
	method agregarOnzas(ingrediente){
		const onza = ingrediente.onza()
		self.onzas().add(onza)
		game.addVisualIn(onza, self.position().up(self.ingredientes().size() - 1))
	}
	method agregarIngredientes(ingrediente) {
		if(ingredientes.size() < 8){ 	
			ingredientes.add(ingrediente)
			self.agregarOnzas(ingrediente)
		}
		else{ self.limpiarConSonido() }
	}
	
	method quitarOnzas(){
		self.onzas().forEach({ onza => game.removeVisual(onza) })
		self.onzas().clear()
	}
	method limpiar() {
		ingredientes.clear()
		self.quitarOnzas()
	}
	
	method sonidosYDialogos(){
		dialogo.contelera(self) 
		configSonido.limpiar()
	}
	method limpiarConSonido(){
		self.limpiar()
		self.sonidosYDialogos()
	}
	
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

	method preparado() = new Trago(ingredientes = self.ingredientes() )
	
} 
