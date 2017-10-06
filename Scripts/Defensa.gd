extends Area2D

var recolectora
var rayo_escena = preload("res://Escenas/Rayo.tscn")
var poder

func _ready():
	set_process(true)
	set_process_input(true)
	poder = global.tirador.poder
	pass

func _input(event):
	if (event.is_action("Disparo") and event.is_pressed() and !event.is_echo()) and tengoEnergia():
		var rayo = rayo_escena.instance()
		rayo.set_global_pos(get_node("Pos_disparo").get_global_pos())
		rayo.dir = (get_global_mouse_pos()-get_global_pos()).normalized()
		rayo.set_rotd(get_global_rotd()+270)
		get_tree().get_root().add_child(rayo)
		global.energia -= 1
	if (event.is_action("DisparoEspecial") and event.is_pressed() and !event.is_echo() and global.CdTirador.TengoCD()):
		var poder_instanciado = poder.instance()
		poder_instanciado.set_global_pos(get_node("Pos_disparo").get_global_pos())
		poder_instanciado.dir = (get_global_mouse_pos()-get_global_pos()).normalized()
		poder_instanciado.set_rotd(get_global_rotd()+180)
		get_tree().get_root().add_child(poder_instanciado)
		poder_instanciado.Disparar()
		global.CdTirador.Iniciar()
	pass

func tengoCdPoder():
	return poder.cd()

func tengoEnergia():
	return global.energia>0

func _process(delta):
	look_at(get_global_mouse_pos())
	if recolectora!=null:
		var size_recolectora = recolectora.get_item_rect().size
		recolectora.set_global_pos(get_node("Pos_recolector").get_global_pos())
		recolectora.set_global_rotd(get_global_rotd()+270)
		recolectora.rot = get_global_rotd()+270
	pass

func _on_Defensa_body_enter( body ):
	if body.is_in_group("recolector"):
		body.enganchado = true
		body.estacion = self
	pass # replace with function body


func _on_Defensa_body_exit( body ):
	if body.is_in_group("recolector"):
		body.enganchado = false
		body.estacion = null
	pass # replace with function body

func Reabastecer(reco):
	get_node("Timer_reabastecimiento").start()
	recolectora = reco
	recolectora.set_linear_velocity(Vector2(0,0))
	global.energia += recolectora.energia
	recolectora.Limpiar()

func _on_Timer_reabastecimiento_timeout():
	recolectora.reabasteciendo = false
	recolectora.set_linear_velocity(Vector2(5,1))
	recolectora=null
	pass # replace with function body
