extends StaticBody2D

var listaFormas = ["res://Sprites/Planeta/Forma1.png","res://Sprites/Planeta/Forma2.png","res://Sprites/Planeta/Forma3.png","res://Sprites/Planeta/Forma4.png"]
var listaLayer1 = ["res://Sprites/Planeta/Layer1_1.png","res://Sprites/Planeta/Layer1_2.png","res://Sprites/Planeta/Layer1_3.png","res://Sprites/Planeta/Layer1_4.png"]
var listaLayer2 = ["res://Sprites/Planeta/Layer2_1.png","res://Sprites/Planeta/Layer2_2.png","res://Sprites/Planeta/Layer2_3.png"]
var rot = 0
var vivo = true

func _ready():
	iniciar_pos()
	Forma()
	global.nombre = CrearNombre()
	set_process(true)
	get_node("Particles2D").set_emitting(false)
	get_node("gameOver").hide()
	pass

func _process(delta):
	if vivo:
		rot += 0.1
		get_node("Forma").set_rotd(rot)
		CalcularVida()
	else:
		set_process(false)
		Explotar()
	pass

func CalcularVida():
	if global.vidaPlaneta>0:
		vivo = true
	else:
		vivo = false

func Forma():
	randomize()
	var randForma = randi() % listaFormas.size()
	var randLista1 = randi() % listaLayer1.size()
	var randLista2 = randi() % listaLayer2.size()
	var r = rand_range(0,1)
	var g = rand_range(0,1)
	var b = rand_range(0,1)
	var rl = rand_range(0,1)
	var gl = rand_range(0,1)
	var bl = rand_range(0,1)
	get_node("Forma").set_texture(load(listaFormas[randForma]))
	get_node("Forma/Layer1").set_texture(load(listaLayer1[randLista1]))
	get_node("Forma/Layer2").set_texture(load(listaLayer2[randLista2]))
	get_node("Forma").set_modulate(Color(r,g,b))
	get_node("Forma/Layer2").set_modulate(Color(rl,gl,bl))
	var color_ramp = ColorRamp.new()
	color_ramp.set_color(0,Color(r,g,b))
	color_ramp.set_color(1,Color(r,g,b,0))
	get_node("Particles2D").set_color_ramp(color_ramp)
	pass

func iniciar_pos():
	var view = OS.get_window_size()
	var pos = Vector2(view.x,view.y)/2
	global.posTierra = pos
	set_global_pos(pos)
	pass

func CrearNombre():
	var listaPrefijo = ["A","Ah","At","Aa","Ae","B","Beh","Bo","C","Ca","Cuh","Du","Da","Deh","Dor","Ki","Ka","Ku","Keh","Meh","Mi","Ma","Min","Mu","La","Lai","Lur"]
	var listaInfijo = ["er","tu","ex","her","hum"]
	var listaSubfijo = ["ra","ma","kep","vax","tuuhk"]
	var np = randi() % listaPrefijo.size()
	var ni = randi() % listaInfijo.size()
	var ns = randi() % listaSubfijo.size()
	return listaPrefijo[np]+listaInfijo[ni]+listaSubfijo[ns]

func Explotar():
	get_parent().StopMusic()
	get_node("SamplePlayer").play("PLANETA")
	get_node("AnimationPlayer").play("Explotar")
	get_node("Proteccion").hide()
	get_node("Gravedad").set_gravity(0)
	get_node("colision").set_trigger(true)
	get_node("Proteccion/CollisionShape2D").set_trigger(true)
	pass

func _on_Proteccion_body_enter( body ):
	if body.is_in_group("destruible") and vivo and body.vivo():
		global.vidaPlaneta -= body.Daniar()
		get_node("SamplePlayer").play("planetaChoque")
		get_node("AnimationPlayer").play("choque")
		get_node("AnimationPlayer").queue("Idle")
	pass

func gameOver():
	get_node("gameOver").show()
	get_node("SamplePlayer").play("gameOver")

func goToHighscore():
	get_parent().mostrarHighscore()

func _on_Proteccion_area_enter( area ):
	if area.is_in_group("destruible") and vivo:
		global.vidaPlaneta -= area.Daniar()
		get_node("SamplePlayer").play("planetaChoque")
		get_node("AnimationPlayer").play("choque")
		get_node("AnimationPlayer").queue("Idle")
	pass # replace with function body
