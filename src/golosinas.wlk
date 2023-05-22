/*
 * Los sabores
 */
object frutilla { }
object chocolate { }
object vainilla { }
object naranja { }
object limon { }


/*
 * Golosinas
 */
 
 class Golosina{
	var peso=15
	var libreGluten=true
	var sabor=frutilla
	method peso() { return peso }
	method libreGluten()=libreGluten
	method sabor() =sabor	
 }
 
class Bombon inherits Golosina{
	
	method precio() { return 5 }
	method mordisco() { peso = peso * 0.8 - 1 }
	
}

class BombonDuro inherits Bombon {
	override method mordisco() {peso=peso-1}
			
	method dureza()=if(peso > 12)  3 else if (peso.between(8,12)) 2 else 1  
}



class Alfajor inherits Golosina{
	
	method precio() { return 12 }
	method mordisco() { peso = peso * 0.8 }
	method initialize() { 
		libreGluten=false
		sabor=chocolate
	}
}

class Caramelo inherits Golosina{
	
	method precio() { return 12 }
	method initialize(){peso = 5}
	method mordisco() { peso = peso - 1 }
	
}

class CarameloRellenoDeChocolate inherits Caramelo{
	override method mordisco() {sabor=chocolate}
	override method sabor()=sabor
	override method precio() { return 13 }
}

class Chupetin inherits Golosina{
	method initialize(){
		peso = 7
		sabor=naranja
	}
	method precio() { return 2 }
	method mordisco() { 
		if (peso >= 2) {
			peso = peso * 0.9
		}
	}
	
	
}

class Oblea inherits Golosina{

	method initialize(){
		peso = 5
		libreGluten=false
		sabor=vainilla
	}
	method mordisco() {
		if (peso >= 70) {
			// el peso pasa a ser la mitad
			peso = peso * 0.5
		} else { 
			// pierde el 25% del peso
			peso = peso - (peso * 0.25)
		}
	}	
}

class ObleaCrujiente inherits Oblea{
	var cantMordiscos
	override method mordisco(){
		if (peso>70 and cantMordiscos<=3){
			peso=(peso*0.5)-3	cantMordiscos+=1	
		}
		else if(peso>70 and cantMordiscos>3) {
			peso=peso*0.5
			cantMordiscos+=1
			} 	
		else {
			peso=(peso*0.25)
			cantMordiscos+=1
		}
	}

	method estaDebil()=	cantMordiscos>3
	
}

class Chocolatin inherits Golosina{
	// hay que acordarse de *dos* cosas, el peso inicial y el peso actual
	// el precio se calcula a partir del precio inicial
	// el mordisco afecta al peso actual
	var pesoInicial
	var comido = 0
	
	method pesoInicial(unPeso) { pesoInicial = unPeso }
	method precio() { return pesoInicial * 0.50 }

	method initialize() { 
		peso= (pesoInicial - comido).max(0)
		libreGluten=false
		sabor=chocolate
	}
	method mordisco() { comido = comido + 2 }
	

}

class ChocolatinVip inherits Chocolatin{
	var coeficienteHumedad 
	
		override method peso() =  (pesoInicial - comido) * 1 + coeficienteHumedad
		method coeficienteHumedad() = coeficienteHumedad
}

class ChocolatinPremium inherits ChocolatinVip{
	override method peso()=(pesoInicial - comido) * 1 + self.coeficienteHumedad()
	override method coeficienteHumedad()=coeficienteHumedad/2
}


class GolosinaBaniada {
	var golosinaInterior
	var pesoBanio = 4
	
	method golosinaInterior(unaGolosina) { golosinaInterior = unaGolosina }
	method precio() { return golosinaInterior.precio() + 2 }
	method peso() { return golosinaInterior.peso() + pesoBanio }
	method mordisco() {
		golosinaInterior.mordisco()
		pesoBanio = (pesoBanio - 2).max(0) 
	}	
	method sabor() { return golosinaInterior.sabor() }
	method libreGluten() { return golosinaInterior.libreGluten() }	
}


class Tuttifrutti inherits Golosina{
	var libreDeGluten
	const sabores = [frutilla, chocolate, naranja]
	var saborActual = 0
	
	method mordisco() { saborActual += 1 }		
	method initialize(){
		peso = 5
		sabor=sabores.get(saborActual % 3)
	}
	method precio() { return (if(self.libreGluten()) 7 else 10) }	
	method libreGluten(valor) { libreDeGluten = valor }
}
