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
	var width = OS.get_window_size().width
	var height = OS.get_window_size().height
	edit_set_rect(Rect2(0,0,width,height))
	get_node("Tiradores").set_pos(Vector2(width/2-get_node("Tiradores").get_item_rect().size.x-150,height/2-get_node("Recolectores").get_item_rect().size.y/2))
	get_node("Recolectores").set_pos(Vector2(width/2+150,height/2-get_node("Recolectores").get_item_rect().size.y/2))
	get_node("Label").set_pos(Vector2(width/2-get_node("Label").get_item_rect().size.x-200,50))
	get_node("Continuar").edit_set_rect(Rect2(0,0,width/8,height/17))
	get_node("Atras").edit_set_rect(Rect2(0,0,width/10,height/20))
	get_node("Continuar").set_pos(Vector2(width/2-get_node("Continuar").get_item_rect().size.x/2,height-get_node("Atras").get_rect().size.height*2))
	get_node("Atras").set_pos(Vector2(0+get_node("Atras").get_rect().size.width,height-get_node("Atras").get_rect().size.height*2))
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
	get_node("Tiradores").setTipo("Tirador")
	get_node("Recolectores").setTipo("Recolector")
	pass

func _on_Continuar_pressed():
	global.tirador = get_node("Tiradores").getPersonaje()
	global.recolector = get_node("Recolectores").getPersonaje()
	get_tree().change_scene("res://Escenas/Nivel.tscn")
	pass # replace with function body


func _on_Atras_pressed():
	get_tree().change_scene("res://Escenas/Controles.tscn")
	pass # replace with function body
