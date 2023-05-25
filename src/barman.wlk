import wollok.game.*
import coctelera.*
import ingredientes.*
import cliente.*
import tragos.*
import sesion.*

//Theo
object barman{
	const property image = 'selector.png'
	const property minPosition = limon.position()
	const property maxPosition = ron.position()
	var property position = minPosition
	
	method iniciar(){}
	
	method derecha(){
		if(self.position().x() < maxPosition.x()){ self.position(self.position().right(7)) }
		else{ self.position(minPosition) }
		configSonido.efectoBotella()
		
	}
	method izquierda(){
		if(self.position().x() > minPosition.x()){ self.position(self.position().left(7)) }
		else{ self.position(maxPosition) }
		configSonido.efectoBotella()

	}
	
	method seleccionar(){
		if(game.allVisuals().contains(self))
			coctelera.agregarIngredientes(game.uniqueCollider(self))
	}	
	
	method entregar(silla){
		if(game.allVisuals().contains(self)) {
			if( silla.cliente() != null ) {
				silla.cliente().recibirTrago(coctelera.preparado())
				configSonido.entrega()
				//game.sound("audio/entregaTrago.mp3").play()
				
				coctelera.limpiar()
			} else {
				//game.say(silla, 'Esta silla está vacía')
				dialogo.sillaVacia(silla)
			}			
		}
	}
	
}

object propinero{
	
	var property dinero = 0
	
	const property position = game.at(2, 20)
	const property image = 'propinero.png'
	method text() = self.dinero().toString()
	
	method entregarPropina(cant){
		dinero += cant
	}
	
}
