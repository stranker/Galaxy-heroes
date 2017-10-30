extends Node2D

var easter = 0
var activado = false
var back = ["res://Sprites/Background/1.png","res://Sprites/Background/2.png","res://Sprites/Background/3.png","res://Sprites/Background/4.png","res://Sprites/Background/5.png","res://Sprites/Background/6.png","res://Sprites/Background/7.png","res://Sprites/Background/8.png","res://Sprites/Background/9.png","res://Sprites/Background/10.png","res://Sprites/Background/11.png","res://Sprites/Background/12.png"]

func _ready():
	get_node("SamplePlayer").play("test")
	Input.set_custom_mouse_cursor(load("res://Sprites/UI/PNG/cursor_pointer3D.png"))
	set_process(true)
	inicializar()
	pass

func inicializar():
	var width = OS.get_window_size().width
	var height = OS.get_window_size().height
	get_node("Background").set_global_pos(Vector2(OS.get_window_size().width/2,OS.get_window_size().height/2))
	get_node("Title").set_global_pos(Vector2(width/2-get_node("Title").get_rect().size.width/2,height/7))
	get_node("Jugar").edit_set_rect(Rect2(0,0,width/6,height/8))
	get_node("Creditos").edit_set_rect(Rect2(0,0,width/6,height/10))
	get_node("Jugar").set_global_pos(Vector2(width/2-get_node("Jugar").get_rect().size.width/2,height/2))
	get_node("Creditos").set_global_pos(Vector2(width/2-get_node("Creditos").get_rect().size.width/2,get_node("Jugar").get_global_pos().y+get_node("Jugar").get_rect().size.height*1.2))
	pass

func _process(delta):
	if easter == 5 and not(activado):
		activado = true
		get_node("StreamPlayer").play()
		get_node("anim").play("stars")
		get_node("Timer").start()
		get_node("fondo").start()
	pass

func _on_Jugar_pressed():
	get_tree().change_scene("res://Escenas/ComoJugar.tscn")
	pass # replace with function body

func _on_Star_pressed():
	easter += 1
	pass # replace with function body

func _on_Timer_timeout():
	randomize()
	var num = randi() % back.size()
	pass # replace with function body


func _on_fondo_timeout():
	randomize()
	var r = rand_range(0,1)
	var g = rand_range(0,1)
	var b = rand_range(0,1)
	get_node("Background").set_modulate(Color(r,g,b))
	pass # replace with function body


func _on_Creditos_pressed():
	get_tree().change_scene("res://Escenas/Creditos.tscn")
	pass # replace with function body
