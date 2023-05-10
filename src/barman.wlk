import wollok.game.*
import coctelera.*
import ingredientes.*
import cliente.*

object barman{
	var seleccionado = 0
	const property todosLosIngredientes = []//se agregarán en el test o cuando el juego comienze
	
	method cantIngredientes() = todosLosIngredientes.size()
	
	method seleccionado() = seleccionado
	
	method derecha(){
		if(seleccionado == self.cantIngredientes()-1){
			seleccionado = 0
		}
		else{
			seleccionado++
		}
	}
	method izquierda(){
		if(seleccionado == 0){
			seleccionado = self.cantIngredientes()-1
		}
		else{
			seleccionado--
		}
	}
	method batir(num){
		
	}
	method seleccionar(){
		coctelera.agregarIngredientes(self.ingredienteSeleccionado())
	}
	method agregarIngrediente(ingrediente){
		todosLosIngredientes.add(ingrediente)
	}
	method ingredienteSeleccionado(){
		return self.todosLosIngredientes().get(seleccionado)
	}
	
	method entregar(silla){
		const cliente = silla.cliente()
		if(cliente != null){
			cliente.verificarTrago()
		}
	}
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