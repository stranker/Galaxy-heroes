extends Area2D

var recolectora
var rot = 0

func _ready():
	set_process(true)
	pass

func _process(delta):
	rot+=0.05
	set_rotd(rot)
	get_node("Sprite").set_rotd(-rot*3)
	if recolectora!=null:
		var size_recolectora = recolectora.get_item_rect().size
		recolectora.set_global_pos(get_node("Position2D").get_global_pos())
		recolectora.set_global_rotd(get_global_rotd()+270)
		recolectora.rot = get_global_rotd()+270


func _on_Satelite_body_enter( body ):
	if body.is_in_group("recolector"):
		body.enganchado = true
		body.estacion = self
	pass # replace with function body


func _on_Satelite_body_exit( body ):
	if body.is_in_group("recolector"):
		body.enganchado = false
		body.estacion = null
	pass # replace with function body

func Reabastecer(reco):
	get_node("Timer").start()
	recolectora = reco
	recolectora.set_linear_velocity(Vector2(0,0))
	global.vidaPlaneta += recolectora.energia
	recolectora.Limpiar()


func _on_Timer_timeout():
	recolectora.reabasteciendo = false
	recolectora.set_linear_velocity(Vector2(5,1))
	recolectora=null
	pass # replace with function body
