import coctelera.*
import ingredientes.*
import cliente.*
import wollok.game.*

object barman{
	var seleccionado = 0
	const todosLosIngredientes = []//se agregarán en el set o cuando el juego comienze
	
	method cantIngredientes() = todosLosIngredientes.size()
	
	method seleccionado() = seleccionado
	
	method derecha(){
		if(seleccionado == self.cantIngredientes()-1){
			seleccionado = 1
		}
		else{
			seleccionado++
		}
	}
	method izquierda(){
		if(seleccionado == 1){
			seleccionado = self.cantIngredientes()-1
		}
		else{
			seleccionado--
		}
	}
	method seleccionar(){
		
	}
}