extends Camera2D

func _ready():
	global.camara = self
	pass

func Shake():
	get_node("AnimationPlayer").play("Shake")
	pass

func ShakeFuerte():
	get_node("AnimationPlayer").play("ShakeFuerte")
	pass