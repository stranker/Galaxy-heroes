extends Panel

var indice = 0
var listaPersonajes = []
var mostrando = false

func _ready():
	set_process(true)
	pass

func _process(delta):
	if !listaPersonajes.empty() and not mostrando:
		mostrarDatos()
		mostrando = true
	var width = get_item_rect().size.x
	var height = get_item_rect().size.y
	get_node(".").edit_set_rect(Rect2(Vector2(0,0),Vector2(get_viewport_rect().size.x/3,get_viewport_rect().size.y/2)))
	get_node("Nombre").set_pos(Vector2(width/2-get_node("Nombre").get_item_rect().size.x/2-10,20))
	get_node("Izquierda").set_pos(Vector2(0-get_node("Izquierda").get_item_rect().size.x,height/2-30))
	get_node("Derecha").set_pos(Vector2(width-get_node("Izquierda").get_item_rect().size.x,height/2-30))
	get_node("PanelDetalles").edit_set_rect(Rect2(Vector2(width/2,height-30),Vector2(width,height/3)))
	get_node("PanelDetalles").set_pos(Vector2(width/2-get_node("PanelDetalles").get_item_rect().size.x/2,height-get_node("PanelDetalles").get_item_rect().size.y))
	get_node("Imagen").set_pos(Vector2(width/2,height/2-30))
	get_node("DetallesPoderes").set_pos(Vector2(width/2-get_node("DetallesPoderes").get_item_rect().size.x/2,height))
	get_node("DetallesPoderes").edit_set_rect(Rect2(0,0,width/1.2,height/3.5))
	pass

func mostrarDatos():
	randomize()
	var personaje = listaPersonajes[indice]
	get_node("PanelDetalles/RichTextLabel").clear()
	get_node("PanelDetalles/RichTextLabel").add_text(personaje.detalles)
	get_node("Nombre").set_text(personaje.nombre)
	get_node("DetallesPoderes").llenarInfo(personaje.getPoderDetalles())
	get_node("Imagen").set_texture(load(personaje.imagen))
	var num = randi() % personaje.voces.size()
	get_node("SamplePlayer").play(personaje.voces[num])

func _on_Izquierda_pressed():
	indice -= 1
	if indice < 0:
		indice = listaPersonajes.size()-1
	mostrarDatos()
	pass # replace with function body


func _on_Derecha_pressed():
	indice += 1
	if indice > listaPersonajes.size()-1:
		indice = 0
	mostrarDatos()
	pass # replace with function body

func getPersonaje():
	return listaPersonajes[indice]