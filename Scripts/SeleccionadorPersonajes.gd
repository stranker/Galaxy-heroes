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

func mostrarDatos():
	randomize()
	var personaje = listaPersonajes[indice]
	get_node("PanelDetalles/RichTextLabel").clear()
	get_node("PanelDetalles/RichTextLabel").add_text(personaje.detalles)
	get_node("Nombre").set_text(personaje.nombre)
	get_node("PanelDetalles/DetallesPoderes").llenarInfo(personaje.getPoderDetalles())
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