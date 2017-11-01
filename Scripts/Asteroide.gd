extends KinematicBody2D

var asteroides2_escena = preload("res://Escenas/Asteroide_2.tscn")
var puntaje = preload("res://Escenas/Puntos.tscn")
var puntos = 300 * global.wave
var velocidad
var rot = 0
var danio = 2
var texturas = ["res://Sprites/Enemigos/AsteroideG_1.png","res://Sprites/Enemigos/AsteroideG_2.png","res://Sprites/Enemigos/AsteroideG_3.png","res://Sprites/Enemigos/AsteroideG_4.png"]
var vivo = true
var velocity = Vector2()
var dir
var color

func _ready():
	Inicializar()
	set_fixed_process(true)
	pass

func Inicializar():
	randomize()
	var text = randi() % texturas.size()
	get_node("Sprite").set_texture(load(texturas[text]))
	velocidad = rand_range(100,150)
	var dir_x = rand_range(-1,1)
	var dir_y = rand_range(-1,1)
	dir = Vector2(dir_x,dir_y).normalized()
	get_node("CollisionShape2D").set_trigger(true)
	get_node("Sprite").set_modulate(Color(rand_range(0,1),rand_range(0,1),rand_range(0,1)))
	pass

func _fixed_process(delta):
	velocity.x = dir.x * velocidad * delta
	velocity.y = dir.y * velocidad * delta
	move(velocity)
	CalcularPantalla()
	pass

func _process(delta):
	CalcularPantalla()

func CalcularPantalla():
	var pos_x = get_global_pos().x
	var pos_y = get_global_pos().y
	var pantalla = OS.get_window_size()
	if pos_x > pantalla.x:
		set_global_pos(Vector2(0,pos_y))
	if pos_y > pantalla.y:
		set_global_pos(Vector2(pos_x,0))
	if pos_x < 0:
		set_global_pos(Vector2(pantalla.x,pos_y))
	if pos_y < 0:
		set_global_pos(Vector2(pos_x,pantalla.y))

func Destruir():
	if vivo:
		vivo = false
		hide()
		var num = 1+randi() % 2
		for i in range(num):
			var asteroide2 = asteroides2_escena.instance()
			get_tree().get_root().add_child(asteroide2)
			asteroide2.set_global_pos(get_global_pos())
			asteroide2.setModulate(get_node("Sprite").get_modulate())
		global.camara.ShakeFuerte()
		global.contadorEnemigos -= 1
		get_node("SamplePlayer").play("asteroide")
		get_node("Timer").start()
		var p = puntaje.instance()
		p.setPuntaje(puntos)
		p.set_global_pos(get_global_pos())
		get_tree().get_root().add_child(p)

func Daniar():
	if vivo:
		vivo = false
		global.contadorEnemigos -= 1
		queue_free()
	return danio

func _on_Timer_timeout():
	queue_free()
	pass

func vivo():
	return vivo
