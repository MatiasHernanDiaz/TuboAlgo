import wollok.game.*
import coctelera.*
import ingredientes.*
import cliente.*
import tragos.*

//Theo
object barman{
	var seleccionado = 0
	const property todosLosIngredientes = []//se agregarán en el test o cuando el juego comience
	var property sesion = null
	
	method cantIngredientes() = todosLosIngredientes.size()
	
	method seleccionado() = seleccionado
	
	method iniciar(sesion_){
		self.sesion(sesion_)
	}
	
	method derecha(){
		if(seleccionado == self.cantIngredientes()-1)
			seleccionado = 0
		else
			seleccionado++
		
	}
	method izquierda(){
		if(seleccionado == 0)
			seleccionado = self.cantIngredientes()-1
		else
			seleccionado--
		
	}
	
	
	method seleccionar(){
		coctelera.agregarIngredientes(self.ingredienteSeleccionado())
	}
	
	method agregarIngrediente(ingrediente){
		todosLosIngredientes.add(ingrediente)
	}
	
	method ingredienteSeleccionado() = self.todosLosIngredientes().get(seleccionado)
	
	
	method entregar(silla){
		const cliente = silla.cliente()
		if(cliente != null){
			cliente.recibirTrago(self.aTrago())
			coctelera.limpiar()
		} else {
			game.say(self, "No hay nadie ahi")
		}
	}
	
	method aTrago(){
		return new Trago(
			ingredientes = coctelera.ingredientes(),
			cantidades = coctelera.cantidades(),
			cantidadShakes = coctelera.cantidadShakes()
		)
	}
}

object propinero{
	var dinero = 0
	const dineroNescesario = 0 //dependerá de la sesion
	
	method entregarPropina(cant){
		dinero += cant
	}
	method dineroTotal() = dinero
	
	method objetivoCumplido() = dinero >= dineroNescesario
}


object config{
	method config(){
		keyboard.right().onPressDo({=> barman.derecha()})
		keyboard.left().onPressDo({=> barman.izquierda()})
		keyboard.enter().onPressDo({=> barman.seleccionar()})
		keyboard.space().onPressDo({coctelera.batir()})
		
		/*
		keyboard.num1().onPressDo({barman.entregar(silla1)})
		keyboard.num2().onPressDo({barman.entregar(silla2)})
		keyboard.num3().onPressDo({barman.entregar(silla3)})
		keyboard.num4().onPressDo({barman.entregar(silla4)})
		keyboard.num5().onPressDo({coctelera.limpiar()})
		*/
	}
	
}