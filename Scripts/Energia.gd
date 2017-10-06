extends Area2D

var dir_x = rand_range(-10,10)
var dir_y = rand_range(-10,10)
var pos = Vector2()
var recolectora
var atraido = false

func _ready():
	randomize()
	var num = 1 + randi() % 3
	get_node("Sprite").set_texture(load("res://Sprites/Energia"+str(num)+".png"))
	var tiempo = rand_range(0,5)
	pos = Vector2(dir_x,dir_y)
	set_process(true)
	get_node("AnimationPlayer").advance(tiempo)
	pass

func _process(delta):
	if !atraido:
		translate(pos*delta)
	else:
		translate((recolectora.get_global_pos()-get_global_pos()).normalized()*2)

func _on_Energia_body_enter( body ):
	if body.is_in_group("recolector") and body.energia<=10:
		body.Recolectar()
		queue_free()
	pass # replace with function body


func _on_VisibilityNotifier2D_exit_screen():
	queue_free()
	pass # replace with function body

func Atraer(rec):
	recolectora = rec
	atraido = true