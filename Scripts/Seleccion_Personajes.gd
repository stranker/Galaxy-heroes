extends Node

var factoryPersonajes = preload("res://Escenas/Personaje.tscn")
var archivoTiradores = File.new()
var listaTiradores = []
var listaRecolectores = []

func _ready():
	crearTiradores()
	crearRecolectores()
	cargarPersonajes()
	pass

func crearTiradores():
	listaTiradores.append(factoryPersonajes.instance().LeoTwain())
	listaTiradores.append(factoryPersonajes.instance().CollinSpecter())
	listaTiradores.append(factoryPersonajes.instance().RogerMcmahon())
	pass

func crearRecolectores():
	listaRecolectores.append(factoryPersonajes.instance().NikolasMavic())
	listaRecolectores.append(factoryPersonajes.instance().JosephineBouclier())
	listaRecolectores.append(factoryPersonajes.instance().IndiaGravita())
	pass

func cargarPersonajes():
	get_node("Main/Tiradores").listaPersonajes = listaTiradores
	get_node("Main/Recolectores").listaPersonajes = listaRecolectores
	pass

func _on_Continuar_pressed():
	global.tirador = get_node("Main/Tiradores").getPersonaje()
	global.recolector = get_node("Main/Recolectores").getPersonaje()
	get_tree().change_scene("res://Escenas/Nivel.tscn")
	pass # replace with function body
