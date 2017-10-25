extends Panel

var factoryPersonajes = preload("res://Escenas/Personaje.tscn")
var archivoTiradores = File.new()
var listaTiradores = []
var listaRecolectores = []

func _ready():
	crearTiradores()
	crearRecolectores()
	cargarPersonajes()
	resize()
	pass

func resize():
	var width = get_viewport_rect().size.x
	var height = get_viewport_rect().size.y
	edit_set_rect(Rect2(0,0,get_viewport_rect().size.width,get_viewport_rect().size.height))
	get_node("Tiradores").set_pos(Vector2(width/2-get_node("Tiradores").get_item_rect().size.x-100,height/2-get_node("Recolectores").get_item_rect().size.y/2))
	get_node("Recolectores").set_pos(Vector2(width/2+100,height/2-get_node("Recolectores").get_item_rect().size.y/2))
	get_node("Continuar").set_pos(Vector2(width/2-get_node("Continuar").get_item_rect().size.x/2,height-100))
	get_node("Label").set_pos(Vector2(width/2-get_node("Label").get_item_rect().size.x-200,50))
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

func _on_Seleccion_Personajes_resized():
	resize()
	pass # replace with function body


func _on_Seleccion_Personajes_item_rect_changed():
	print("puto")
	pass # replace with function body
