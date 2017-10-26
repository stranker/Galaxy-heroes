extends Node2D

var asteroide = preload("res://Escenas/Asteroide.tscn")
var nave = preload("res://Escenas/Ovni.tscn")

func _ready():
	randomize()
	var tiempo = rand_range(5,10)
	get_node("Timer").set_wait_time(tiempo)
	get_node("Timer").start()
	pass

func _on_Timer_timeout():
	var wave = global.wave
	if global.PuedoSpawnear():
		randomize()
		var tiempo = 5 + randi() % 10*(1/wave)
		var enemigo = randi() % 10
		var enem
		get_node("Timer").set_wait_time(tiempo)
		if enemigo <=8:
			enem = asteroide.instance()
		else:
			enem = nave.instance()
		get_tree().get_root().add_child(enem)
		global.contadorEnemigos += 1
	pass # replace with function body
