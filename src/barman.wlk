import wollok.game.*
import coctelera.*
import ingredientes.*
import cliente.*

object barman{
	var seleccionado = 0
	const property todosLosIngredientes = []//se agregarán en el test o cuando el juego comience
	
	method cantIngredientes() = todosLosIngredientes.size()
	
	method seleccionado() = seleccionado
	
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
	
	// qué es batir? parce ser un metodo de coctelera o al menos que tiene que convivir con ella
	method batir(num){
		
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
			cliente.recibirTrago(coctelera.ingredientes())  //ESTO DE RECIBIR TRAGO, ES RECIBIR INGREDIENTES
			cliente.modificarSatisfaccion() // este metodo no debería ser llamado desde bar, debería ser desencadenado por recibirTrago
			cliente.darPropina() //este metodo no debería ser llamado desde bar, debería ser desencadenado por recibirTrago
		} else {
			game.say(self, "El cliente se ha ido. ¿Le entrego este trago a otro cliente o tiro este?")
		}
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
		keyboard.space().onPressDo({barman.batir(1)})
		
		/*
		keyboard.num1().onPressDo({barman.entregar(silla1)})
		keyboard.num2().onPressDo({barman.entregar(silla2)})
		keyboard.num3().onPressDo({barman.entregar(silla3)})
		keyboard.num4().onPressDo({barman.entregar(silla4)})
		keyboard.num5().onPressDo({coctelera.limpiar()})
		*/
	}
	
}