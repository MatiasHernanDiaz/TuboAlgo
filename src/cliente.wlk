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
	const property position = silla.position() //misma posicion que la silla que se le asigno
	var property image = "clienteFeliz.png" //cuantas imagenes de clienteFeliz hay?
	var tiempoRestante = self.tiempoEspera() //se inicializa igual que tiempo de espera 
	
	
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
	
	method satisfaccion(){return satisfaccion}
	
	method modificarSatisfaccion(){
		//este metodo llama a verificarTrago y decide si modifica o no la satisfaccion
		//la satisfaccion tambien se tiene que modificar con el tiempo
		if(self.verificarTrago()){satisfaccion += 1}
		else{satisfaccion -=1 }
	}
	
	
	
	method satisfaccionActual(){
		//revisa la satisfaccion para ver si tiene que cambiar imagen
		game.onTick(1000,"revisarSatisfaccion",{self.estado()})
	}
	
	method cambiarImagen(){
		if(self.satisfaccion() == 3){image = "clienteFeliz.png"}
		else if(self.satisfaccion() == 2){image = "clienteNeutral.png"}
		else{image = "clienteEnojado.png"}
	}
	
	
	method desalojar(){
		//deja la silla vacia
		
		silla.retirarCliente()
	}
	
	
	
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
	
	/*METODOS DE TIEMPO */
	
	method tiempoEspera()
	
	method tiempoRestante(){return tiempoRestante}
	
	
	
	method tiempoRegresivo(){
		//inicial la cuenta regresiva
		if(self.verificarTiempoPositivo()){
			game.onTick(1000,"restasSegundos",{self.restarSegundos()})
			}
		else{
			self.desalojar()
		}
	}
	
	method restarSegundos(){
		//resto de a 1 seg
		tiempoRestante -= 1
	}
	
	method verificarTiempoPositivo(){
		//tiempo positivo
		return tiempoRestante > 0
	}
	
	method modificarSatisfaccionTiempo(){
		//modifico satisfaccion de a tercios
		
		if(self.tiempoRestante() < (self.tiempoEspera()*(1/3))){
			satisfaccion = 1
		}
		else if(self.tiempoRestante() < (self.tiempoEspera()*(2/3))){
			satisfaccion = 2
		}
		
	}
	
	
	/*METODOS PARA EL ANALISIS DE LOS TRAGOS */
	
	method verificarTrago() //abstracto
	
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
			propinero.entregarPropina(250)
		}
		else if(self.satisfaccion() == 2){
			propinero.entregarPropina(500)
		}
		else if(self.satisfaccion() >= 3){
			propinero.entregarPropina(1000)
		}
		else{
			self.desalojar()
		}
	}
}



/*TIPOS DE CLIENTES */

class ClienteExigente inherits Cliente{
	//tiempo de espera 20 segundos
	
	override method tiempoEspera(){return 20}
	
	override method verificarTrago(){
		//si los set son iguales le basta
		return tragoQueRecibio.ingredientes().count(
			{ing => tragoPedido.ingredientes().any(
				{ing2 => ing2.toString() == ing.toString() and ing2.Onzas() == ing.Onzas()}
			)}
		)
	}
	
}


class ClienteMedio inherits Cliente{
	//tiempo de espera 40 segundos
	override method tiempoEspera(){return 40}
	
	override method verificarTrago(){
		//si los set son iguales le basta
		return tragoQueRecibio.ingredientes().count(
			{ing => tragoPedido.ingredientes().any(
				{ing2 => ing2.toString() == ing.toString() 
					and (ing2.Onzas() - ing.Onzas()).abs() <= 1
				}
			)}
		)
	}
}




class ClienteConformista inherits Cliente{
	//tiempo de espera 60 segundos
	override method tiempoEspera(){return 60}
	
	override method verificarTrago(){
		//si los set son iguales le basta
		//return tragoQueRecibio.ingredientes() == tragoPedido.ingredientes()
		return tragoQueRecibio.ingredientes().count(
			{ing => tragoPedido.ingredientes().any(
				{ing2 => ing2.toString() == ing.toString()}
			)}
		)
	}
}


