extends Panel

var indice = 0
var listaPersonajes = []
var mostrando = false
var tipo = ""

func _ready():
	set_process(true)
	inicializar()
	pass

func inicializar():
	var width = get_item_rect().size.width
	var height = get_item_rect().size.height
	edit_set_rect(Rect2(Vector2(0,0),Vector2(width,height)))
	get_node("Izquierda").set_pos(Vector2(0-get_node("Izquierda").get_rect().size.width*get_node("Izquierda").get_scale().x+5,height/2-30))
	get_node("Derecha").set_pos(Vector2(width-get_node("Derecha").get_item_rect().size.x,height/2-30))
	get_node("PanelDetalles").edit_set_rect(Rect2(0,0,width,height/4.2))
	get_node("PanelDetalles").set_pos(Vector2(width/2-get_node("PanelDetalles").get_rect().size.width/2,height-get_node("PanelDetalles").get_rect().size.height))
	get_node("Imagen").set_pos(Vector2(width/2,height/2-20))
	get_node("DetallesPoderes").edit_set_rect(Rect2(0,0,width/1.2,height/4))
	get_node("DetallesPoderes").set_pos(Vector2(width/2-get_node("DetallesPoderes").get_item_rect().size.x/2,height))
	get_node("PanelDetalles/RichTextLabel").edit_set_rect(Rect2(0,0,width-10,height/3))
	get_node("Imagen").set_scale(Vector2(width/270,height/270))
	get_node("CenterContainer/Nombre").set_custom_minimum_size(Vector2(width,30))
	get_node("CenterContainer/Nombre").set_pos(Vector2(width/2-get_node("CenterContainer/Nombre").get_item_rect().size.x/2,30))
	get_node("CenterContainer").edit_set_rect(Rect2(0,0,width,70))
	get_node("CenterContainer 2").edit_set_rect(Rect2(0,0,width,-40))
	pass

func _process(delta):
	if !listaPersonajes.empty() and not mostrando:
		mostrarDatos()
		mostrando = true
	pass

func mostrarDatos():
	randomize()
	var personaje = listaPersonajes[indice]
	get_node("PanelDetalles/RichTextLabel").clear()
	get_node("PanelDetalles/RichTextLabel").add_text(personaje.detalles)
	get_node("CenterContainer/Nombre").set_text(personaje.nombre)
	get_node("DetallesPoderes").llenarInfo(personaje.getPoderDetalles())
	get_node("Imagen").set_texture(load(personaje.imagen))
	var num = randi() % personaje.voces.size()
	get_node("SamplePlayer").play(personaje.voces[num])
	pass

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

func setTipo(tip):
	get_node("CenterContainer 2/Tipo").set_text(tip)

func getPersonaje():
	return listaPersonajes[indice]
