import wollok.game.*
import config.*
import coctelera.*
import ingredientes.*
import barman.*
import tragos.*
import sesion.*

class Cliente{
	
	const property silla 
	var property satisfaccion = 3 
	var property tragoPedido = null	
	var property recibioTrago = false
	const property position = silla.position().right(2) 
	var tiempoRestante = self.tiempoEspera()
	const propinaSatisfaccion1 = 250
	const propinaSatisfaccion2 = 500
	const propinaSatisfaccion3 = 1000
	
	method nombre()  
	
	method image(){
		 return 
			if(self.satisfaccion()==3) self.nombre() + "1.png" 
			else if(self.satisfaccion()==2) self.nombre() + "2.png" 
			else self.nombre() + "3.png"	
	}
	
/*METODOS DE INICIO Y TERMINAR */
	method iniciar() {
		//Pide un trago y llama a control una vez por segundo
		self.generarTrago()
		game.onTick(1000, self.identity().toString(), {self.control()})
		
	}
	
	method control(){
		//Controla la satisfaccion del cliente por tiempo y corre reloj
		if (self.silla().cliente() != null) {
			self.tiempoRegresivo()
			self.modificarSatisfaccionTiempo()			
		}		
	}

	method desalojar() {
		//deja la silla vacia
		silla.retirarCliente()	
	}
	
	method terminar() {
		//remueve los onTick de iniciar()
		game.removeTickEvent(self.identity().toString())
	}

/*METRODOS DE TIEMPO */
	method tiempoEspera()
	
	method tiempoRestante() = tiempoRestante

	method tiempoRegresivo(){
		//inicia la cuenta regresiva
		if(self.verificarTiempoPositivo())
			self.restarSegundos()
		else {
			self.recibioTrago(true)
			dialogo.tiempoFuera(self)
			self.desalojar()			
		}
	}
	
	method restarSegundos(){tiempoRestante -= 1}
	
	method verificarTiempoPositivo() = tiempoRestante > 0
	
	method modificarSatisfaccionTiempo(){
		//modifico satisfaccion de a tercios
		if(((self.tiempoRestante()) - (self.tiempoEspera()*(1/3))).abs() <= 1){
			satisfaccion = 1
			self.image()
			dialogo.faltaMucho(self)
		}
		else if(((self.tiempoRestante()) - (self.tiempoEspera()*(2/3))).abs() <= 1) {
			satisfaccion = 2
			self.image()
		}
	}

/*METODOS PARA EL ANALISIS DE LOS TRAGOS */ 
	method verificarTrago(tragoQueRecibio) = self.compararTragosSet(tragoQueRecibio)
	
	method generarTrago(){
		self.tragoPedido(carta.elegirTrago())
		dialogo.dameUn(self)
	}
	
	method recibirTrago(unTrago) {
		//Solo recibe el trago si no recibio previamente uno
		//Independientemente de que lo reciba o no desaloja
		if(not self.recibioTrago()) {
			self.recibioTrago(true)
			if(self.verificarTrago(unTrago)){
				self.darPropina()
				dialogo.rico(self)
			} else {
				dialogo.noPedi(self)
			}
			self.desalojar()
		}
	}
	
	method generarTrago(unTrago){
		//Creado para poder implementar los test
		self.tragoPedido(unTrago)
	}
	
	method compararTragosSet(tragoQueRecibio){
		//convierte los tragos en Set y los compara
		return tragoQueRecibio.ingredientes().asSet() == self.tragoPedido().ingredientes().asSet()
	}
	
	method ingredientesIdeales() = self.tragoPedido().ingredientes().asSet()
	
	method ingredientesReales(tragoQueRecibio) =  tragoQueRecibio.ingredientes().asSet()
	
	
	method darPropina(){
	//Da propina acorde a su nivel de satisfaccion
	//modifica el contador del propinero
		if(self.satisfaccion() == 1){
			dialogo.satisfaccion1(self)
			self.propinaMasSonido(propinaSatisfaccion1)
		} else if(self.satisfaccion() == 2) {
			dialogo.satisfaccion2(self)
			self.propinaMasSonido(propinaSatisfaccion2)
		} else if(self.satisfaccion() >= 3) {
			dialogo.satisfaccion3(self)
			self.propinaMasSonido(propinaSatisfaccion3) 
		} else {
			dialogo.tragoMal(self)
			self.desalojar()
		}
	}
	
	method propinaMasSonido(dinero){
		propinero.entregarPropina(dinero)
			configSonido.efectoPropina()
	}
}

/*TIPOS DE CLIENTES */
class ClienteExigente inherits Cliente {
	//tiempo de espera 16 segundos
	
	var property image = "exigente1.png"
	
	var property nombre =  "exigente"
	
	override method tiempoEspera(){return 16}
	
	override method verificarTrago(tragoQueRecibio){
		//Se deben ordenar los tragos, y luego devolver la comparación.
		//Tiene que ser identicos
		//el no compara set, por eso no va super()
		return self.ordenarTragoRecibido(tragoQueRecibio) == self.ordenarTragoPedido()
	}
	
	method ordenarTragoRecibido(tragoQueRecibio){
		//retorna lista del trago que recibio ordenado
		tragoQueRecibio.ingredientes().sortBy({ e1, e2 => e1.toString() < e2.toString()})
		return tragoQueRecibio.ingredientes()
	}
	
	method ordenarTragoPedido(){
		//retorna lista del trago pedido ordenado
		self.tragoPedido().ingredientes().sortBy({ e1, e2 => e1.toString() < e2.toString()})
		return self.tragoPedido().ingredientes()
	}
}

class ClienteMedio inherits Cliente{
	//tiempo de espera 30 segundos
	
	var property image = "medio1.png"
	
	var property nombre = "medio"
	
	override method tiempoEspera() {return 30}
	
	override method verificarTrago(tragoQueRecibio){
		//Compara los set de tragos y se verifica la direrencia de cantidades
		
		return super(tragoQueRecibio) and 
			self.verificarToleranciaUnaDif(tragoQueRecibio)
	}
	
	method verificarToleranciaUnaDif(tragoQueRecibio){
		//Para todos los ingredientes del trago pedido y los compara con los del trago que entregado
		//si son iguales
		return self.ingredientesIdeales().all({
					ingr1 => (self.tragoPedido().ingredientes().count({ingr2 => ingr1 === ingr2}) 
						- tragoQueRecibio.ingredientes().count({ingr2 => ingr1 === ingr2})
					).abs() <= 1
				})
	}
}

class ClienteConformista inherits Cliente{
	//tiempo de espera 45 segundos
	
	var property image = "conformista1.png" 
	
	var property nombre = "conformista"

	override method tiempoEspera(){return 45}
	
	override method verificarTrago(tragoQueRecibio){
		//compara set tragos y pide que el vaso este lleno
		return super(tragoQueRecibio) and self.vasoLleno(tragoQueRecibio)
		}
	
	method vasoLleno(unTrago){
		//Retorna True si el vaso esta lleno
		return unTrago.ingredientes().size() >= 7
	}	
}
