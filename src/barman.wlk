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
		game.sound("audio/botellas.mp3").play()
		
	}
	method izquierda(){
		if(self.position().x() > minPosition.x()){ self.position(self.position().left(7)) }
		else{ self.position(maxPosition) }
		game.sound("audio/botellas.mp3").play()

	}
	
	method seleccionar(){
		if(game.allVisuals().contains(self))
			coctelera.agregarIngredientes(game.uniqueCollider(self))
	}	
	
	method entregar(silla){
		if(game.allVisuals().contains(self)) {
			if( silla.cliente() != null ) {
				silla.cliente().recibirTrago(coctelera.preparado())
				game.sound("audio/entregaTrago.mp3").play()
				
				coctelera.limpiar()
			} else {
				game.say(silla, 'Esta silla está vacía')
			}			
		}
	}
	
}

object propinero{
	var property dinero = 0
	
	const property position = game.at(2, 20)
	const property image = 'propinero.png'
	
	method entregarPropina(cant){
		dinero += cant
	}
}

object propina {
	const property position = game.at(4, 19)
	method text() = propinero.dinero().toString()
}
