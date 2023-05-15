import wollok.game.*
import coctelera.*
import ingredientes.*
import barman.*

/*Matias */

class Cliente{
	
	var property satisfaccion = 3 //siempre arranca alta
	//var property tragoRecibido = false // se fija si recibio o no el trago
	var property tragoPedido = null	// que trago genero
	//var tragoQueRecibio = null
	const property position = silla.position() //misma posicion que la silla que se le asigno
	var property image = "clienteFeliz.png" //cuantas imagenes de clienteFeliz hay?
	var tiempoRestante = self.tiempoEspera() //se inicializa igual que tiempo de espera 
	var property tragoRecibido = false // se fija si recibio o no el trago
	const silla // por parametro
	
	
	method cambiarImagen(){
		image = if(self.satisfaccion()==3) "clienteFeliz.png" else if(self.satisfaccion()==2) "clienteNeutral.png" else "clienteEnojado.png"
	}
	
	//deja la silla vacia
	method desalojar() = silla.retirarCliente()
	
	/*METODOS DE INICIO Y TERMINAR */
	method iniciar() {

		//pide un trago y corre el reloj y estado
		self.generarTrago()
		game.onTick(1000,"control",{self.control()})
		
	}
	
	method control(){
	
		self.tiempoRegresivo()
		self.modificarSatisfaccionTiempo()
	}
	
	method terminar() {
		//remueve los onTick de iniciar()
		game.removeTickEvent("control")
	}
	
	/*abstracto */
	method tiempoEspera()
	
	method tiempoRestante() = tiempoRestante

	
	method tiempoRegresivo(){
		//inicia la cuenta regresiva
		if(self.verificarTiempoPositivo())
			game.onTick(1000,"restasSegundos",{self.restarSegundos()})
		else
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
			game.say(self, "Estoy por irme")
		}
		else if((self.tiempoRestante()) < (self.tiempoEspera()*(2/3))){
			satisfaccion = 2
			game.say(self, "¿Falta mucho?")
		}
	}
	
	
	/*METODOS PARA EL ANALISIS DE LOS TRAGOS */ 

	method verificarTrago(unTrago) //abstracto
	
	method generarTrago(){
		//genera un trago
		//llama al methodo que instancia un trago
		const unTrago = [new BotellaCoca(), new BotellaFernet()].anyOne()
		self.tragoPedido(unTrago)
	}
	
	
	method recibirTrago(_unTrago){
		if(self.verificarTrago(_unTrago)){
			self.darPropina()
		}
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
			game.say(self, "Deja que desea. Seguí practicando y pronto lo lograrás")
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
	
	override method tiempoEspera(){return 20}
	
	override method verificarTrago(tragoQueRecibio){
		//compara set tragos y lista onzas
		return tragoQueRecibio.ingredientes().count(
			{ing => tragoPedido.ingredientes().any(
				{ing2 => ing2.toString() == ing.toString() and ing2.Onzas() == ing.Onzas()}
			)}
		)
	}
}

class ClienteMedio inherits Cliente{
	//tiempo de espera 40 segundos
	override method tiempoEspera() {return 40}
	
	override method verificarTrago(tragoQueRecibio){
		//compara set tragos y compara lista onzas con tolerancia de 1 de dif
		return tragoQueRecibio
				.ingredientes()
				.count({ing => tragoPedido
					.ingredientes()
					.any({ing2 => ing2.nombre() == ing.nombre() && (ing2.Onzas() - ing.Onzas()).abs() <= 1})})
	}
}

class ClienteConformista inherits Cliente{
	//tiempo de espera 60 segundos

	override method tiempoEspera(){return 60}
	
	override method verificarTrago(tragoQueRecibio){

		//si los set son iguales le basta
		//return tragoQueRecibio.ingredientes() == tragoPedido.ingredientes()
		return tragoQueRecibio
				.ingredientes()
				.count({ing => tragoPedido
					.ingredientes()
					.any({ing2 => ing2.nombre() == ing.nombre()})}
		)
	}
}