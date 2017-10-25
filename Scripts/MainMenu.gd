extends Node2D

var easter = 0
var activado = false
var back = ["res://Sprites/Background/1.png","res://Sprites/Background/2.png","res://Sprites/Background/3.png","res://Sprites/Background/4.png","res://Sprites/Background/5.png","res://Sprites/Background/6.png","res://Sprites/Background/7.png","res://Sprites/Background/8.png","res://Sprites/Background/9.png","res://Sprites/Background/10.png","res://Sprites/Background/11.png","res://Sprites/Background/12.png"]

func _ready():
	get_node("SamplePlayer").play("test")
	Input.set_custom_mouse_cursor(load("res://Sprites/UI/PNG/cursor_pointer3D.png"))
	set_process(true)
	pass

func setPos():
	get_node("Panel").edit_set_rect(Rect2(0,0,get_viewport_rect().size.width,get_viewport_rect().size.height))
	get_node("Background").set_global_pos(Vector2(get_viewport_rect().size.width/2,get_viewport_rect().size.height/2))
	pass

func _process(delta):
	if easter == 5 and not(activado):
		activado = true
		get_node("StreamPlayer").play()
		get_node("anim").play("stars")
		get_node("Timer").start()
		get_node("fondo").start()
	setPos()

func _on_Jugar_pressed():
	get_tree().change_scene("res://Escenas/ComoJugar.tscn")
	pass # replace with function body


func _on_Controles_pressed():
	get_tree().change_scene("res://Escenas/Controles.tscn")
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
