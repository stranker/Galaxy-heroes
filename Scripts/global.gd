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
var wave = 0
var contadorEnemigos = 0

func _ready():
	set_process(true)
	pass

func Inicializar():
	energia = 10
	vidaPlaneta = 10
	wave = 0
	contadorEnemigos = 0
	puntaje = 0
	var wips = get_tree().get_nodes_in_group("wip")
	for i in wips:
		i.queue_free()

func _process(delta):
	if energia>10:
		energia = 10
	if vidaPlaneta>10:
		vidaPlaneta = 10

func PuedoSpawnear():
	if(wave>0):
		if(contadorEnemigos <= wave*3):
			return true
		else:
			return false

func Shake():
	camara.Shake()

func ShakeFuerte():
	camara.ShakeFuerte()