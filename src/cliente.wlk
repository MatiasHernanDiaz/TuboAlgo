import wollok.game.*
import coctelera.*
import ingredientes.*
import barman.*
import tragos.*

/*Matias */

class Cliente{
	
	const property silla // por parametro
	var property satisfaccion = 3 //siempre arranca alta
	var property tragoPedido = null	// que trago genero
	const property position = silla.position().right(2) //misma posicion que la silla que se le asigno
	//var property image  //cuantas imagenes de clienteFeliz hay?
	var tiempoRestante = self.tiempoEspera() //se inicializa igual que tiempo de espera 
	
	
	method cambiarImagen()
	
	//deja la silla vacia
	method desalojar() = silla.retirarCliente()
	
	/*METODOS DE INICIO Y TERMINAR */
	method iniciar() {

		//pide un trago y corre el reloj y estado
		self.generarTrago()
		game.onTick(1000,'c' + self.silla().evento(),{self.control()})
		
	}
	
	method control(){
		if (self.silla().cliente() != false) {
			self.tiempoRegresivo()
			self.modificarSatisfaccionTiempo()			
		}
		
	}
	
	method terminar() {
		//remueve los onTick de iniciar()
		game.removeTickEvent('c' + self.silla().evento())
	}
	
	/*abstracto */
	method tiempoEspera()
	
	method tiempoRestante() = tiempoRestante

	
	method tiempoRegresivo(){
		//inicia la cuenta regresiva
		if(self.verificarTiempoPositivo())
			self.restarSegundos()
		else
			//game.schedule(6000,{self.desalojar()})
			self.desalojar()
	}
	
	//resto de a 1 seg
	method restarSegundos(){
		tiempoRestante -= 1
	}
	
	//tiempo positivo
	method verificarTiempoPositivo() = tiempoRestante > 0
	
	//modifico satisfaccion de a tercios
	method modificarSatisfaccionTiempo(){
		//modifico satisfaccion de a tercios
		//escuchar mas tarde a theo
		if((self.tiempoRestante()) < (self.tiempoEspera()*(1/3))){
			satisfaccion = 1
			//game.say(self, "Me canse de esperar...")
			
			
		}
		else if((self.tiempoRestante()) < (self.tiempoEspera()*(2/3))){
			satisfaccion = 2
			//game.say(self, "¿Falta mucho?")
		}
	}
	
	
	/*METODOS PARA EL ANALISIS DE LOS TRAGOS */ 

	method verificarTrago(unTrago) //abstracto
	
	method generarTrago(){
		//genera un trago
		//llama al methodo que instancia un trago
		self.tragoPedido(carta.elegirTrago())
		
		game.say(self, 'Dame ' + self.tragoPedido().toString())
	}
	
	
	method recibirTrago(_unTrago){
		console.println(_unTrago)
		if(self.verificarTrago(_unTrago)){
			self.darPropina()
		}
		game.say(self, 'Esto no es lo que pedí.')
		game.schedule(1000,{self.desalojar()})
	}
	

	//genera un trago
	//llama al methodo que instancia un trago
	method generarTrago(_unTrago){
		tragoPedido = _unTrago
	}
	
	
	method darPropina(){
	//da propina acorde a su nivel de satisfaccion
	//modifica el contador del propinero
		if(self.satisfaccion() == 1){
			game.say(self, "Deja que desear. Seguí practicando y pronto lo lograrás")
			propinero.entregarPropina(250)
		} else if(self.satisfaccion() == 2) {
			game.say(self, "Estuvo bien pero puede estar mejor")
			propinero.entregarPropina(500)
		} else if(self.satisfaccion() >= 3) {
			game.say(self, "Sos lo más. Excelente trago")
			propinero.entregarPropina(1000) 
		} else {
			game.say(self, "Si no se tiene nada bueno que decir, mejor no decir nada. ¡Hasta nunca!")
			
			self.desalojar()
		}
	}
}

/*TIPOS DE CLIENTES */
class ClienteExigente inherits Cliente {
	//tiempo de espera 20 segundos
	
	var property image = "clienteDificilFeliz.png"
	
	override method tiempoEspera(){return 10}
	
	override method verificarTrago(tragoQueRecibio){
		//compara set tragos y lista onzas
		return tragoQueRecibio.ingredientes().sortBy({ e1, e2 => e1 < e2}) == self.tragoPedido().ingredientes().sortBy({ e1, e2 => e1 < e2})}
	
	override method cambiarImagen(){
		self.image(
			if(self.satisfaccion()==3) "clienteDificilFeliz.png" 
			else if(self.satisfaccion()==2) "clienteDificilNeutral.png" 
			else "clienteDificilTriste.png") 
	}
}

class ClienteMedio inherits Cliente{
	//tiempo de espera 40 segundos
	
	var property image = "clienteMedioFeliz.png"
	
	override method tiempoEspera() {return 20}
	
	override method verificarTrago(tragoQueRecibio){
		//compara set tragos y compara lista onzas con tolerancia de 1 de dif
		const ingredientesIdeales = self.tragoPedido().ingredientes().asSet()
		const ingredientesReales = tragoQueRecibio.ingredientes().asSet()
		
		return ingredientesIdeales == ingredientesReales and 
				tragoQueRecibio.ingredientes().all(
				{ ingr1 => self.tragoPedido().any(
					{ ingr2 => (
						self.tragoPedido().count(ingr2) - tragoQueRecibio.ingredientes().count(ingr1)
					).abs() <= 1 and ingr1 == ingr2}
				)}
			)
		
//		return self.cantErrores() < 3
	}
	
//	method cantErrores(){
//		const sett = tragoRecibido.ingredientes().asSet() or tragoPedido.ingredientes().asSet()
//		var errores = 0
//		sett.forEach({
//			ingr =>
//			errores += (tragoRecibido.ingredientes().count(ingr) - tragoPedido.ingredientes().count(ingr)).abs()
//		})
//		return errores
//	}
	
	override method cambiarImagen(){
		self.image(
			if(self.satisfaccion()==3) "clienteMedioFeliz.png" 
			else if(self.satisfaccion()==2) "clienteMedioNeutral.png" 
			else "clienteMedioTriste.png") 
	}
}

class ClienteConformista inherits Cliente{
	//tiempo de espera 60 segundos
	
	var property image = "clienteFacilFeliz.png" 

	override method tiempoEspera(){return 30}
	
	override method verificarTrago(tragoQueRecibio){
		return tragoQueRecibio.ingredientes().asSet() == self.tragoPedido().ingredientes().asSet() and
			tragoQueRecibio.ingredientes().size() >= 7
	
	}
		
	override method cambiarImagen(){
		self.image(
			if(self.satisfaccion()==3) "clienteFacilFeliz.png" 
			else if(self.satisfaccion()==2) "clienteFacilNeutral.png" 
			else "clienteFacilTriste.png") 
	}
}
