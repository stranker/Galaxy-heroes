extends CanvasLayer

var vidaPlaneta
var energia
var puntaje
var nombre
var wave

func _ready():
	set_process(true)
	inicializar()
	SetPoderes()
	pass

func inicializar():
	var width = OS.get_window_size().width
	var height = OS.get_window_size().height
	get_node("PanelPoderT").set_global_pos(Vector2(OS.get_window_size().width/1.2,OS.get_window_size().height/1.2))
	get_node("PanelPoderR").set_global_pos(Vector2(OS.get_window_size().width/6-get_node("PanelPoderR").get_item_rect().size.width,OS.get_window_size().height/1.2))
	get_node("Puntaje").set_global_pos(Vector2(width/2-get_node("Puntaje").get_rect().size.width/2,30))
	get_node("Wave").set_global_pos(Vector2(width/2-get_node("Wave").get_rect().size.width/2,10))
	get_node("PanelVida").edit_set_rect(Rect2(Vector2(0,2),Vector2(width/2.5,40)))
	get_node("PanelEnergia").edit_set_rect(Rect2(Vector2(width,2),Vector2(width/2.5,40)))
	get_node("PanelEnergia").set_global_pos(Vector2(width-get_node("PanelEnergia").get_rect().size.width,0))
	get_node("PanelVida/Planeta").set_global_pos(Vector2(5,0))
	get_node("PanelEnergia/Energia").set_global_pos(Vector2(get_node("PanelEnergia").get_pos().x+5,0))
	get_node("PanelVida/ProgressBar").edit_set_rect(Rect2(Vector2(0,0),Vector2(get_node("PanelVida").get_rect().size.width/1.5,30)))
	get_node("PanelEnergia/ProgressBar").edit_set_rect(Rect2(Vector2(0,0),Vector2(get_node("PanelEnergia").get_rect().size.width/1.5,30)))
	get_node("PanelVida/ProgressBar").set_global_pos(Vector2(get_node("PanelVida").get_pos().x + get_node("PanelVida").get_rect().size.width - get_node("PanelVida/ProgressBar").get_rect().size.width - 5,get_node("PanelVida/Planeta").get_pos().y+(get_node("PanelVida/Planeta").get_rect().size.height-get_node("PanelVida/ProgressBar").get_rect().size.y)/2))
	get_node("PanelEnergia/ProgressBar").set_global_pos(Vector2(get_node("PanelEnergia").get_global_pos().x + get_node("PanelEnergia").get_rect().size.width - get_node("PanelEnergia/ProgressBar").get_rect().size.width - 5,get_node("PanelEnergia/Energia").get_global_pos().y+(get_node("PanelEnergia/Energia").get_rect().size.height-get_node("PanelEnergia/ProgressBar").get_rect().size.y)/2))
	pass

func SetPoderes():
	if (global.tirador != null):
		get_node("PanelPoderT/PoderTirador").Poder(global.tirador.poder.instance().Inicializar())
		global.CdTirador = get_node("PanelPoderT/PoderTirador")
		get_node("PanelPoderR/PoderRecolector").Poder(global.recolector.poder.instance().Inicializar())
		global.CdRecolector = get_node("PanelPoderR/PoderRecolector")
	pass

func _process(delta):
	if(global.tirador != null):
		vidaPlaneta = global.vidaPlaneta
		energia = global.energia
		puntaje = global.puntaje
		nombre = global.nombre
		wave = global.wave
		get_node("PanelVida/Planeta").set_text(nombre)
		get_node("PanelVida/ProgressBar").set_value(vidaPlaneta)
		get_node("PanelEnergia/ProgressBar").set_value(energia)
		get_node("Wave").set_text("WAVE "+str(wave))
		get_node("Puntaje").set_text("SCORE "+str(puntaje))
	pass
