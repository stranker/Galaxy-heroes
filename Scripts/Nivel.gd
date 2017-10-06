extends Node

var menuPausa = preload("res://Escenas/MenuPausa.tscn")
var listaBack = []
var pausa = false

func _ready():
	Input.set_custom_mouse_cursor(load("res://Sprites/UI/PNG/crossair_white.png"),Vector2(18,18))
	CargarMapas()
	setMapa()
	get_node("TiempoWave").start()
	set_process_input(true)
	pass

func _input(event):
	if event.is_action("Pausa") and event.is_pressed() and !event.is_echo() and !pausa:
		var menu = menuPausa.instance()
		get_tree().get_root().add_child(menu)
		menu.set_global_pos(Vector2(1024,600)/2)

func CargarMapas():
	for i in range (1,13):
		listaBack.append("res://Sprites/Background/"+str(i)+".png")

func setMapa():
	randomize()
	var num = randi() % listaBack.size()
	get_node("Background").set_texture(load(listaBack[num]))

func _on_TiempoWave_timeout():
	get_node("anim").play("Wave")
	get_node("SamplePlayer").play("nuevaOleada")
	global.wave += 1
	pass # replace with function body

func ReiniciarNivel():
	get_node("TiempoMuerto").start()

func StopMusic():
	get_node("StreamPlayer").stop()

func _on_TiempoMuerto_timeout():
	get_tree().change_scene("res://Escenas/Seleccion_Personajes.tscn")
	global.Inicializar()
	pass # replace with function body
