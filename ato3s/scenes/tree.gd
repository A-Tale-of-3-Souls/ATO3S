extends CharacterBody2D

var oscillation_speed : float = 5.0  # Velocità dell'oscillazione
var amplitude : float = 0.2  # Ampiezza dell'oscillazione

func _process(delta: float) -> void:
	# Movimento su e giù basato su una funzione seno che oscilla nel tempo
	position.y += amplitude * sin(Time.get_ticks_msec() * 0.001 * oscillation_speed)
