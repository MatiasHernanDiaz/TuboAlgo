import wollok.game.*
import coctelera.*
import ingredientes.*

/*Matias */

class Cliente{
	
	const silla // por parametro
	const tiempoEspera //por parametro
	var satisfaccion = 3 //siempre arranca alta
	var property tragoRecibido = false // se fija si recibio o no el trago
	var tragoPedido = null// que trago genero
	
	
	method tiempoEspera(){return tiempoEspera}
	
	
	method satisfaccion(){return satisfaccion}
	
	method modificarSatisfaccion(){
		//este metodo llama a verificar satisfaccion y decide si modifica o no
	}
	
	method generarTrago(_unTrago){
		//genera un trago
		//llama al methodo que instancia un trago
		tragoPedido = _unTrago
	}
	
	method tragoPedido(){return tragoPedido}
	
	method darPropina(){
		//da propina acorde a su nivel de satisfaccion
		//modifica el contador del propinero
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
	
	method iniciar(){
		//NO SE QUE HACE ESTO
	}
	
	
	
	
}

class ClienteExigente inherits Cliente{
	//tiempo de espera 20 segundos
	override method verificarTrago(){}
}

class ClienteMedio inherits Cliente{
	//tiempo de espera 40 segundos
	override method verificarTrago(){}
}

class ClienteConformista inherits Cliente{
	//tiempo de espera 60 segundos
	override method verificarTrago(){}
}


