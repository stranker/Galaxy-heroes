extends Node2D

var menuPausa = preload("res://Escenas/MenuPausa.tscn")
var listaBack = []
var pausa = false

func _ready():
	Input.set_custom_mouse_cursor(load("res://Sprites/UI/PNG/crossair_white.png"),Vector2(18,18))
	CargarMapas()
	setMapa()
	get_node("TiempoWave").start()
	set_process_input(true)
	inicializar()
	pass

func inicializar():
	get_node("Camara").set_global_pos(Vector2(OS.get_window_size().x,OS.get_window_size().y)/2)
	get_node("SpawnEnemigos").set_global_pos(Vector2(0,0))
	get_node("SpawnEnemigos1").set_global_pos(Vector2(0,OS.get_window_size().height))
	get_node("SpawnEnemigos2").set_global_pos(Vector2(OS.get_window_size().width,OS.get_window_size().height))
	get_node("SpawnEnemigos3").set_global_pos(Vector2(OS.get_window_size().width,0))
	get_node("Defensa").set_global_pos(Vector2(OS.get_window_size().x,OS.get_window_size().y)/2)
	get_node("Wave").set_global_pos(Vector2(OS.get_window_size().x/2-get_node("Wave").get_item_rect().size.width*2.4,OS.get_window_size().height/5))
	_on_TiempoWave_timeout()
	pass

func _input(event):
	if event.is_action("Pausa") and event.is_pressed() and !event.is_echo() and !pausa:
		var menu = menuPausa.instance()
		get_tree().get_root().add_child(menu)
	pass

func CargarMapas():
	for i in range (1,13):
		listaBack.append("res://Sprites/Background/"+str(i)+".png")

func setMapa():
	randomize()
	var num = randi() % listaBack.size()
	get_node("Background").set_texture(load(listaBack[num]))
	get_node("Background").edit_set_rect(Rect2(-50,-50,OS.get_window_size().x+50,OS.get_window_size().y+50))
	pass

func _on_TiempoWave_timeout():
	global.wave += 1
	if(global.wave!=1):
		get_node("SamplePlayer").play("nuevaOleada")
	get_node("Wave").set_text("WAVE "+str(global.wave))
	get_node("Tween").interpolate_property(get_node("Wave"),"visibility/opacity",0,1,3,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	get_node("Tween").interpolate_property(get_node("Wave"),"visibility/opacity",1,0,3,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT,3)
	get_node("Tween").start()
	pass # replace with function body

func mostrarHighscore():
	get_tree().change_scene("res://Escenas/HighscoreEscena.tscn")

func StopMusic():
	get_node("StreamPlayer").stop()