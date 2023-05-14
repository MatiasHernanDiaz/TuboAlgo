import wollok.game.*
import coctelera.*
import ingredientes.*
import barman.*

/*Matias */

class Cliente{
	
	var satisfaccion = 3 //siempre arranca alta
	var tragoPedido = null	// que trago genero
	var tragoQueRecibio = null
	var tiempoRestante = self.tiempoEspera() //se inicializa igual que tiempo de espera 
	var property tragoRecibido = false // se fija si recibio o no el trago
	var property image = "clienteFeliz.png" //cuantas imagenes de clienteFeliz hay?
	const silla // por parametro
	const property position = silla.position() //misma posicion que la silla que se le asigno
	
	
	/*ESTADO DEL CLIENTE */
	method estado(){
		if(self.tragoRecibido()){
			//sacar modificarSatisfaccion
			//self.modificarSatisfaccion()
			//self.cambiarImagen()
			//->agregar dialogo(acorde a satifaccion)
			//remover onTick de tiempo
			//paga
			self.darPropina()
			self.desalojar()
		}
		else{
			//reviso el tiempo, y si paso la mitad baja satisfaccion
			self.modificarSatisfaccionTiempo()
			self.cambiarImagen()
			//un dialogo
		}
	}
	
	method satisfaccion() = satisfaccion
	
	//este metodo llama a verificarTrago y decide si modifica o no la satisfaccion
	//la satisfaccion tambien se tiene que modificar con el tiempo
	method modificarSatisfaccion(){
		satisfaccion = if(self.verificarTrago()) satisfaccion+1 else satisfaccion-1
	}
	
	//revisa la satisfaccion para ver si tiene que cambiar imagen
	method satisfaccionActual() = game.onTick(1000,"revisarSatisfaccion",{self.estado()})
	
	method cambiarImagen(){
		image = if(self.satisfaccion()==3) "clienteFeliz.png" else if(self.satisfaccion()==2) "clienteNeutral.png" else "clienteEnojado.png"
	}
	
	//deja la silla vacia
	method desalojar() = silla.retirarCliente()
	
	/*METODOS DE INICIO Y TERMINAR */
	method iniciar() {
		//inciar eventos 
		//onTick tiene que llamar
		//generarTrago()
		self.estado()
		self.tiempoRegresivo()
	}
	
	method terminar() {
		//remueve los onTick de iniciar()
	}
	
	/*abstracto */
	method tiempoEspera()
	
	method tiempoRestante() = tiempoRestante

	//inicia la cuenta regresiva
	method tiempoRegresivo(){
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
	//abstracto
	method verificarTrago() 
	
	//genera un trago
	//llama al methodo que instancia un trago
	method generarTrago(_unTrago){
		tragoPedido = _unTrago
	}
	
	method tragoPedido() = tragoPedido
	
	method recibirTrago(_unTrago){
		tragoQueRecibio = _unTrago
		
		/* 
		 * Agregado por ANY - VER */
//		tragoRecibido = true
//		self.modificarSatisfaccion()
//		self.estado()
	}

	//da propina acorde a su nivel de satisfaccion
	//modifica el contador del propinero
	method darPropina(){
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
	override method tiempoEspera() = 20
	
	//si los set son iguales le basta
	override method verificarTrago(){
		return tragoQueRecibio
				.ingredientes()
				.count({ing => tragoPedido
					.ingredientes()
					.any({ing2 => ing2.nombre() == ing.nombre() && ing2.Onzas() == ing.Onzas()})})
	}	
}

class ClienteMedio inherits Cliente{
	//tiempo de espera 40 segundos
	override method tiempoEspera() = 40
	
	override method verificarTrago(){
		//si los set son iguales le basta
		return tragoQueRecibio
				.ingredientes()
				.count({ing => tragoPedido
					.ingredientes()
					.any({ing2 => ing2.nombre() == ing.nombre() && (ing2.Onzas() - ing.Onzas()).abs() <= 1})})
	}
}

class ClienteConformista inherits Cliente{
	//tiempo de espera 60 segundos
	override method tiempoEspera() = 60

	override method verificarTrago(){
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