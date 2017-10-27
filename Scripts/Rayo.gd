extends Area2D

const VELOCIDAD = 300
var dir

func _ready():
	set_process(true)
	get_node("AnimationPlayer").play("Volar")
	get_node("SamplePlayer").play("laser")
	pass

func _process(delta):
	translate(dir*delta*VELOCIDAD)

func _on_VisibilityNotifier2D_exit_screen():
	queue_free()
	pass # replace with function body

func _on_Rayo_body_enter( body ):
	if body.is_in_group("destruible") and body.vivo():
		body.Destruir()
		queue_free()
	if body.is_in_group("recolector") and !body.protegido:
		body.Destruir()
		queue_free()
	pass # replace with function body
