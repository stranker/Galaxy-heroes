extends Area2D

var misil = preload("res://Escenas/Misil.tscn")
var rayo = preload("res://Escenas/RayoEspectral.tscn")
var salto = preload("res://Escenas/SaltoCuantico.tscn")
var escudo = preload("res://Escenas/Omniescudo.tscn")
var atractor = preload("res://Escenas/AtractorGravitacional.tscn")
var mina = preload("res://Escenas/MinaEspacial.tscn")

var poder_detalles
var poder
var imagen
var nombre
var detalles
var imagen_nave
var voces = []

func _ready():
	pass

func LeoTwain():
	nombre = "Tte. Leo 'Nuke' Twain"
	detalles =  "Ex militar y retirado con el grado de teniente. Posee un arsenal a su disposicion para defender los planetas."
	imagen = "res://Sprites/Twain.png"
	poder_detalles = misil.instance().Inicializar()
	poder = misil
	voces = ["twain_hora","twain_senior"]
	return self

func CollinSpecter():
	nombre = "Collin 'KaYn' Specter"
	detalles =  "Ingeniero en electro-particulas. Paso su vida desarrollando el rayo espectral."
	imagen = "res://Sprites/Spectral.png"
	poder_detalles = rayo.instance().Inicializar()
	poder = rayo
	voces = ["gaston_vectorial","gaston_energia"]
	return self

func NikolasMavic():
	nombre = "Nikolas 'Alyzer' Mavic"
	detalles = "Jugador de basketball en Rusia y cientifico en su tiempo libre. Especialista en saltos cuanticos."
	imagen = "res://Sprites/Mavic.png"
	poder_detalles = salto.instance().Inicializar()
	poder = salto
	imagen_nave = "res://Sprites/Naves/Nikolai.png"
	voces = ["nico_saltar","nico_triple"]
	return self

func JosephineBouclier():
	nombre = "Josephine 'LaTour' Bouclier"
	detalles = "Pilota de la Flota Intergalactica Armada. Manipuló el Iridium para crear el Omniescudo que proteje planetas."
	imagen = "res://Sprites/Bouclier.png"
	poder_detalles = escudo.instance().Inicializar()
	poder = escudo
	imagen_nave = "res://Sprites/Naves/Bouclier.png"
	voces = ["rage_escudo","rage_torre"]
	return self

func IndiaGravita():
	nombre = "India 'Vega' Gravita"
	detalles = "Cientifica y fundadora del Centro de Investigcion Gravitacional. Inventora del Atractor Gravitacional y el café Arwiano."
	imagen = "res://Sprites/Gravita.png"
	poder_detalles = atractor.instance().Inicializar()
	poder = atractor
	imagen_nave = "res://Sprites/Naves/Indi.png"
	voces = ["indi_gravedad","indi_acercate"]
	return self

func RogerMcmahon():
	nombre = "Roger 'K8' Mcmahon"
	detalles = "Agente del Estado Conservador Unido. Era zapador en las Guerras Therianas."
	imagen = "res://Sprites/RogerMcmahon.png"
	poder_detalles = mina.instance().Inicializar()
	poder = mina
	voces = ["perro_pichi","perro_wofwof"]
	return self

func getPoderDetalles():
	return poder_detalles