import wollok.game.*
import coctelera.*
import ingredientes.*
import cliente.*
import tragos.*
//Theo
object barman{
	const property image = 'selector.png'
	const property minPosition = fernet.position()
	const property maxPosition = naranja.position()
	var property position = minPosition
	
	method iniciar(){}
	
	method derecha(){
		if(self.position().x() < maxPosition.x()){ self.position(self.position().right(7)) }
		else{ self.position(minPosition) }
	}
	method izquierda(){
		if(self.position().x() > minPosition.x()){ self.position(self.position().left(7)) }
		else{ self.position(maxPosition) }
	}
	
	method seleccionar(){
		coctelera.agregarIngredientes(game.uniqueCollider(self))
	}	
	
	method entregar(silla){
		if( silla.cliente() != null ) {
			silla.cliente().recibirTrago(coctelera.preparado())
			coctelera.limpiar()
		} else {
			game.say(silla, 'Esta silla está vacía')
		}
	}
	
}

object propinero{
	var property dinero = 0
	const dineroNescesario = 0 //dependerá de la sesion
	
	const property position = game.at(2, 20)
	const property image = 'propinero.png'
	method text() = self.dinero().toString()
	
	method entregarPropina(cant){
		dinero += cant
	}
	method dineroTotal() = dinero
	
	method objetivoCumplido() = dinero >= dineroNescesario
}
