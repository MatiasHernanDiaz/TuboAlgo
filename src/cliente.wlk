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
	
	
	method cambiarImagen()
	
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
			self.cambiarImagen()
			dialogo.faltaMucho(self)
		}
		else if(((self.tiempoRestante()) - (self.tiempoEspera()*(2/3))).abs() <= 1) {
			satisfaccion = 2
			self.cambiarImagen()
		}
	}

	/*METODOS PARA EL ANALISIS DE LOS TRAGOS */ 
	method verificarTrago(unTrago)
	
	method generarTrago(){
		self.tragoPedido(carta.elegirTrago())
		game.say(self, 'Dame ' + self.tragoPedido().toString())
	}
	
	
	method recibirTrago(_unTrago) {
		if(not self.recibioTrago()) {
			self.recibioTrago(true)
			
			if(self.verificarTrago(_unTrago)){
				self.darPropina()
				dialogo.rico(self)
				//game.say(self, 'Está rico!')
			} else {
				dialogo.noPedi(self)
				//game.say(self, 'Esto no es lo que pedí.')
			}
			self.desalojar()
		}
	}
	

	//genera un trago
	//llama al methodo que instancia un trago
	method generarTrago(_unTrago){
		self.tragoPedido(_unTrago)
	}
	
	
	method darPropina(){
	//da propina acorde a su nivel de satisfaccion
	//modifica el contador del propinero
		if(self.satisfaccion() == 1){
			//game.say(self, "Deja que desear.")
			dialogo.satisfaccion1(self)
			propinero.entregarPropina(250)
			configSonido.efectoPropina()
		} else if(self.satisfaccion() == 2) {
			game.say(self, "Estuvo bien pero puede estar mejor")
			dialogo.satisfaccion2(self)
			propinero.entregarPropina(500)
			configSonido.efectoPropina()
		} else if(self.satisfaccion() >= 3) {
			game.say(self, "Sos lo más. Excelente trago")
			dialogo.satisfaccion3(self)
			propinero.entregarPropina(1000) 
			configSonido.efectoPropina()
		} else {
			//game.say(self, "Es muy feo!")
			dialogo.tragoMal(self)
			self.desalojar()
		}
	}
}

/*TIPOS DE CLIENTES */
class ClienteExigente inherits Cliente {
	//tiempo de espera 20 segundos
	
	var property image = "exigente1.png"
	
	override method tiempoEspera(){return 16}
	
	override method verificarTrago(tragoQueRecibio){
		//Primero se deben ordenar los tragos, y luego devolver la comparación
		tragoQueRecibio.ingredientes().sortBy({ e1, e2 => e1.nombre() < e2.nombre()})
		self.tragoPedido().ingredientes().sortBy({ e1, e2 => e1.nombre() < e2.nombre()})
		
		return tragoQueRecibio.ingredientes() == self.tragoPedido().ingredientes()
	}
	
	override method cambiarImagen(){
		self.image(
			if(self.satisfaccion()==3) "exigente1.png" 
			else if(self.satisfaccion()==2) "exigente2.png" 
			else "exigente3.png") 
	}
	
}

class ClienteMedio inherits Cliente{
	//tiempo de espera 40 segundos
	
	var property image = "medio1.png"
	
	override method tiempoEspera() {return 30}
	
	override method verificarTrago(tragoQueRecibio){
		//compara set tragos y compara lista onzas con tolerancia de 1 de dif
		const ingredientesIdeales = self.tragoPedido().ingredientes().asSet()
		const ingredientesReales = tragoQueRecibio.ingredientes().asSet()
		
		return ingredientesIdeales == ingredientesReales and 
				ingredientesIdeales.all({
					ingr1 => (self.tragoPedido().ingredientes().count({ingr2 => ingr1 === ingr2}) 
						- tragoQueRecibio.ingredientes().count({ingr2 => ingr1 === ingr2})
					).abs() <= 1
				})
	}

	override method cambiarImagen(){
		self.image(
			if(self.satisfaccion()==3) "medio1.png" 
			else if(self.satisfaccion()==2) "medio2.png" 
			else "medio3.png") 
	}
}

class ClienteConformista inherits Cliente{
	//tiempo de espera 60 segundos
	
	var property image = "conformista1.png" 

	override method tiempoEspera(){return 45}
	
	override method verificarTrago(tragoQueRecibio){
		return tragoQueRecibio.ingredientes().asSet() == self.tragoPedido().ingredientes().asSet() and
			tragoQueRecibio.ingredientes().size() >= 7
	
	}
		
	override method cambiarImagen(){
		self.image(
			if(self.satisfaccion()==3) "conformista1.png" 
			else if(self.satisfaccion()==2) "conformista2.png" 
			else "conformista3.png")
	}
}
