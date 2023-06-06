import wollok.game.*
import config.*
import coctelera.*
import ingredientes.*
import cliente.*
import tragos.*
import sesion.*
//THEO

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////// BARMAN, PROPINERO, PROPINA
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
object barman{
	const property image = 'selector.png'
	const property minPosition = limon.position()
	const property maxPosition = ron.position()
	var property position = minPosition//Cada 7 posiciones es un objeto
	
	method derecha(){//
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
			configSonido.servir()
	}	
	method entregarTragoLimpiarCoctelera(silla){
				silla.cliente().recibirTrago(coctelera.preparado())
				coctelera.limpiar()
				configSonido.entrega()
	}
	method entregar(silla){
		if(game.allVisuals().contains(self)) {
			if( silla.cliente() != null ) {self.entregarTragoLimpiarCoctelera(silla)} 
			else {dialogo.sillaVacia(silla) }			
		}
	}

}

object propinero{
	var property dinero = 0
	const property position = game.at(2, 20)
	const property image = 'propinero.png'
	
	method entregarPropina(cant){ dinero += cant }
	
}

object propina {
	const property position = game.at(4, 19)
	method text() = '$'+propinero.dinero().toString()
	method textColor() = paleta.verde()
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////// BARMAN para test, sin sonidos
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
object barmanParaTest{
	const property image = 'selector.png'
	const property minPosition = limon.position()
	const property maxPosition = ron.position()
	var property position = minPosition
	
	method derecha(){
		if(self.position().x() < maxPosition.x()){ self.position(self.position().right(7)) }
		else{ self.position(minPosition) }
		
	}
	method izquierda(){
		if(self.position().x() > minPosition.x()){ self.position(self.position().left(7)) }
		else{ self.position(maxPosition) }
	}
	
	method seleccionar(){
		if(game.allVisuals().contains(self))
			cocteleraParaTest.agregarIngredientes(game.uniqueCollider(self))
	}	
	
	method entregarTragoLimpiarCoctelera(silla){
		silla.cliente().recibirTrago(cocteleraParaTest.preparado())
		cocteleraParaTest.limpiar()
	}
	
	method entregar(silla){
		if(game.allVisuals().contains(self)) {
			if( silla.cliente() != null ) {self.entregarTragoLimpiarCoctelera(silla)} 
			else {dialogo.sillaVacia(silla) }			
		}
	}
	
}
