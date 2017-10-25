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
	set_process(true)
	pass

func _process(delta):
	get_node("Background").set_scale(Vector2(OS.get_window_size().x/600,OS.get_window_size().y/600))
	get_node("SpawnEnemigos").set_global_pos(Vector2(0,0))
	get_node("SpawnEnemigos1").set_global_pos(Vector2(0,OS.get_window_size().y))
	get_node("SpawnEnemigos2").set_global_pos(Vector2(OS.get_window_size().x,OS.get_window_size().y))
	get_node("SpawnEnemigos3").set_global_pos(Vector2(OS.get_window_size().x,0))
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
	get_node("Background").edit_set_rect(Rect2(0,0,OS.get_window_size().x,OS.get_window_size().y))
	pass

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
