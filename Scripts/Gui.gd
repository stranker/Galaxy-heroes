extends CanvasLayer

var vidaPlaneta
var energia
var puntaje
var nombre
var wave

func _ready():
	set_process(true)
	SetPoderes()
	pass

func SetPoderes():
	get_node("PanelPoderT/PoderTirador").Poder(global.tirador.poder.instance().Inicializar())
	global.CdTirador = get_node("PanelPoderT/PoderTirador")
	get_node("PanelPoderR/PoderRecolector").Poder(global.recolector.poder.instance().Inicializar())
	global.CdRecolector = get_node("PanelPoderR/PoderRecolector")

func _process(delta):
	vidaPlaneta = global.vidaPlaneta
	energia = global.energia
	puntaje = global.puntaje
	nombre = global.nombre
	wave = global.wave
	get_node("PanelPlaneta/Planeta").set_text(nombre)
	get_node("PanelPlaneta/Planeta/ProgressBar").set_value(vidaPlaneta)
	get_node("PanelEnergia/Energia/ProgressBar").set_value(energia)
	get_node("Wave").set_text("WAVE "+str(wave))
	get_node("Puntaje").set_text("SCORE "+str(puntaje))
