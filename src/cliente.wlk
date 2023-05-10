import wollok.game.*
import coctelera.*
import ingredientes.*

/*Matias */

class Cliente{
	
	const silla // por parametro
	var satisfaccion = 3 //siempre arranca alta
	var property tragoRecibido = false // se fija si recibio o no el trago
	var tragoPedido = null	// que trago genero
	var tragoQueRecibio = null
	var position = silla.position() //misma posicion que la silla que se le asigno
	var property image = "clienteFeliz.png" //cuantas imagenes de clienteFeliz hay?
	
	method tiempoEspera()
	
	method satisfaccion(){return satisfaccion}
	
	method modificarSatisfaccion(){
		//este metodo llama a verificar satisfaccion y decide si modifica o no
		if(self.verificarTrago()){satisfaccion += 1}
		else{satisfaccion -=1 }
	}
	
	method satisfaccionActual(){
		game.onTick(1000,"revisarSatisfaccion",{self.cambiarImagen()})
	}
	
	method cambiarImagen(){
		if(self.satisfaccion() == 3){image = "clienteFeliz.png"}
		else if(self.satisfaccion() == 2){image = "clienteNeutral.png"}
		else{image = "clienteEnojado.png"}
	}
	
	method generarTrago(_unTrago){
		//genera un trago
		//llama al methodo que instancia un trago
		tragoPedido = _unTrago
	}
	
	method tragoPedido(){return tragoPedido}
	
	method recibirTrago(_unTrago){tragoQueRecibio = _unTrago}
	
	method darPropina(){
		//da propina acorde a su nivel de satisfaccion
		//modifica el contador del propinero
		if(self.satisfaccion() == 1){
			//propinero.propina() = 25
		}
		else if(self.satisfaccion() == 2){
			//propinero.propina() = 50
		}
		else if(self.satisfaccion() >= 3){
			//propinero.propina() = 100
		}
		else{
			self.desalojar()
		}
	}
	
	method desalojar(){
		//deja la silla vacia
	}
	
	method verificarTrago() //abstracto
	
	method medirTiempo(){
		//checkea el tiempo y si es menor al estipulado
		//modifica satisfaccion
		//si el tiempo es mayor al de espera, desaloja
	}
	
	method iniciar() {
		//NO SE QUE HACE ESTO
	}
}

class ClienteExigente inherits Cliente{
	//tiempo de espera 20 segundos
	override method tiempoEspera(){return 20}
	override method verificarTrago(){
		//true si verificarOnzas == 0
		return self.verificarTragosIgualdad() and self.verificarOnzas(tragoQueRecibio) == 0
		
	}
	method verificarTragosIgualdad(){
		return tragoQueRecibio.ingredientes() == tragoPedido.ingredientes()
	}
	
	method verificarOnzas(_unTrago){
		//retorna diferencia de onzas entre tragoPedido y tragoQueRecibio
		//_unTrago.forEach({ingrediente => ingrediente.cantidadOnzas()})
		return 0 //corregir
	}
}

class ClienteMedio inherits Cliente{
	//tiempo de espera 40 segundos
	override method tiempoEspera(){return 40}
	override method verificarTrago(){
		//true si diferenciasOnzas == 1
		return false
	}
}

class ClienteConformista inherits Cliente{
	//tiempo de espera 60 segundos
	override method tiempoEspera(){return 60}
	
	override method verificarTrago(){
		//sirve si ingredientes es set
		return tragoQueRecibio.ingredientes() == tragoPedido.ingredientes()
	}
	
}


