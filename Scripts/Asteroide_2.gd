extends KinematicBody2D

var vivo = true
var velocidad
var energia_escena = preload("res://Escenas/Energia.tscn")
var danio = 1
var texturas = ["res://Sprites/Enemigos/AsteroideC_1.png","res://Sprites/Enemigos/AsteroideC_2.png"]
var velocity = Vector2()
var dir
var puntos = 400
var puntaje = preload("res://Escenas/Puntos.tscn")

func _ready():
	randomize()
	global.contadorEnemigos += 1 
	var text = randi() % texturas.size()
	get_node("Sprite").set_texture(load(texturas[text]))
	velocidad = rand_range(200,400)
	var dir_x = rand_range(-1,1)
	var dir_y = rand_range(-1,1)
	dir = Vector2(dir_x,dir_y).normalized()
	set_fixed_process(true)
	get_node("CollisionShape2D").set_trigger(true)
	pass

func _fixed_process(delta):
	velocity.x = dir.y * velocidad * delta
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
	pass


func Destruir():
	vivo = false
	var num = 1+randi() % 3
	for i in range(num):
		var energia = energia_escena.instance()
		get_tree().get_root().add_child(energia)
		energia.set_global_pos(get_global_pos())
	global.camara.Shake()
	global.contadorEnemigos -= 1
	set_fixed_process(false)
	get_node("SamplePlayer").play("asteroide")
	get_node("AnimationPlayer").play("explotar")
	var p = puntaje.instance()
	p.setPuntaje(puntos)
	p.set_global_pos(get_global_pos())
	get_tree().get_root().add_child(p)

func Daniar():
	if vivo:
		global.contadorEnemigos -= 1
		queue_free()
	return danio

func vivo():
	return vivo