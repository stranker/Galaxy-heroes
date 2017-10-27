extends RigidBody2D

const VELOCIDAD = 2
var dir
var rot = 0
var enganchado = false
var estacion
var reabasteciendo = false
var energia = 0
var escala = Vector2(1,1)
var vivo
var poder
var protegido = false

func _ready():
	get_node("Explosion").set_emitting(false)
	poder = global.recolector.poder
	get_node("Sprite").set_texture(load(global.recolector.imagen_nave))
	vivo = true
	set_fixed_process(true)
	set_pos(global.posTierra)
	get_node("ProgressBar").show()
	get_node("Sprite").show()
	pass

func _fixed_process(delta):
	if vivo:
		show()
		CalcularPantalla()
		BarraEnergia()
		Movimiento()
		Reabastecer()
		set_scale(escala)
		UsarPoder()
	pass

func Reabastecer():
	if Input.is_action_pressed("Entrar") and enganchado:
		estacion.Reabastecer(self)
		reabasteciendo = true
		escala = Vector2(1,1)
	pass

func UsarPoder():
	if Input.is_action_pressed("PoderRecolector") and global.CdRecolector.TengoCD():
		var poder_instanciado = poder.instance()
		if(poder_instanciado.get_nombre() == "Omniescudo" || poder_instanciado.get_nombre() == "Atractor"):
			get_tree().get_root().add_child(poder_instanciado)
		global.CdRecolector.Iniciar()
		poder_instanciado.Usar(self)
	pass

func Limpiar():
	energia = 0

func Movimiento():
	if not(reabasteciendo) or !vivo:
		dir = (get_node("Position2D").get_global_pos()-get_global_pos()).normalized()
		if Input.is_action_pressed("ui_up"):
			apply_impulse(Vector2(0,0),dir*VELOCIDAD)
			get_node("Adelante").set_emitting(true)
		else:
			get_node("Adelante").set_emitting(false)
		if Input.is_action_pressed("ui_right"):
			rot -=2
			set_rotd(rot)
		elif Input.is_action_pressed("ui_left"):
			rot +=2
			set_rotd(rot)
	pass

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

func BarraEnergia():
	get_node("ProgressBar").set_value(energia)

func Recolectar():
	if vivo:
		energia += 1
	pass

func Destruir():
	if(vivo):
		vivo = false
		set_linear_velocity(Vector2(0,0))
		energia = 0
		get_node("AnimationPlayer").play("Explotar")
	pass

func Reaparecer():
	set_global_pos(global.posTierra)
	get_node("Explosion").set_emitting(false)
	get_node("Sprite").show()
	get_node("ProgressBar").show()
	get_node("Tween").interpolate_property(self,"transform/scale",Vector2(0.1,0.1),Vector2(1,1),4,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	get_node("Tween").start()
	get_node("Timer_Reaparicion").start()
	pass

func _on_Recolectora_body_enter( body ):
	if not(reabasteciendo):
		escala = Vector2(1.2,1.2)
	pass # replace with function body


func _on_Recolectora_body_exit( body ):
	escala = Vector2(1,1)
	pass # replace with function body


func _on_Timer_Reaparicion_timeout():
	vivo = true
	pass # replace with function body
