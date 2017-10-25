extends Panel

var factoryPersonajes = preload("res://Escenas/Personaje.tscn")
var archivoTiradores = File.new()
var listaTiradores = []
var listaRecolectores = []

func _ready():
	crearTiradores()
	crearRecolectores()
	cargarPersonajes()
	set_process(true)
	pass

func _process(delta):
	#get_node("Main").edit_set_rect(Rect2(0,0,get_viewport_rect().size.width,get_viewport_rect().size.height))
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
	get_node("Tiradores").listaPersonajes = listaTiradores
	get_node("Recolectores").listaPersonajes = listaRecolectores
	pass

func _on_Continuar_pressed():
	global.tirador = get_node("Tiradores").getPersonaje()
	global.recolector = get_node("Recolectores").getPersonaje()
	get_tree().change_scene("res://Escenas/Nivel.tscn")
	pass # replace with function body
