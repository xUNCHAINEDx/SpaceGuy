extends Node

export (PackedScene) var Roca
var score = 0

func _ready():
	randomize()

func nuevo_juego():
	score = 0
	$Player.inicio($PosicionDeInicio.position) # Posicion de inicio del player
	$IniciorTimer.start()

func game_over():
	$ScoreTimer.stop()
	$RocaTimer.stop()

func _on_IniciorTimer_timeout():
	$RocaTimer.start()
	$ScoreTimer.start()

func _on_ScoreTimer_timeout():
	# Incrementar el score
	score += 1
	
func _on_RocaTimer_timeout():
	# Selecciona un lugar aleatorio en el camino
	$Camino/RocaPosicion.set_offset(randi())
	
	var roca_instance = Roca.instance()
	add_child(roca_instance)
	
	# Seleccionar una direccion
	var direction = $Camino/RocaPosicion.rotation + PI / 2
	
	roca_instance.position = $Camino/RocaPosicion.position
	
	direction += rand_range(-PI / 4, PI / 4)
	roca_instance.rotation = direction
	roca_instance.set_linear_velocity(Vector2(rand_range(roca_instance.velocidad_min, roca_instance.velocidad_max), 0).rotated(direction))
