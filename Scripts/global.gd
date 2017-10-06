extends Node

var vidaPlaneta = 10
var energia = 10
var puntaje = 0
var camara
var posTierra
var tirador
var recolector
var CdTirador
var CdRecolector
var nombre
var wave = 1
var contadorEnemigos = 0

func _ready():
	set_process(true)
	pass

func Inicializar():
	energia = 10
	vidaPlaneta = 10
	wave = 1
	contadorEnemigos = 0
	puntaje = 0
	var hijos = get_tree().get_root().get_children()
	for i in hijos:
		if i.get_name().find("Asteroide")>=0 || i.get_name().find("Energia")>=0:
			i.queue_free()

func _process(delta):
	if energia>10:
		energia = 10
	if vidaPlaneta>10:
		vidaPlaneta = 10

func PuedoSpawnear():
	return contadorEnemigos <= wave*3

func Shake():
	camara.Shake()

func ShakeFuerte():
	camara.ShakeFuerte()