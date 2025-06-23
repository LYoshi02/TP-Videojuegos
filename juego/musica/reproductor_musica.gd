extends AudioStreamPlayer

func reproducir_musica(musica: AudioStream, volumen: float = 0.0) -> void:
	if stream == musica:
		return
	
	stream = musica
	stream.loop = true
	volume_db = volumen
	bus = "musica"
	play()

func pausar_musica() -> void:
	stop()

func reproducir_efecto_de_sonido(efecto: AudioStream, volumen: float = 15) -> void:
	var reproductor = AudioStreamPlayer.new()
	reproductor.stream = efecto
	reproductor.name = "REPRODUCTOR_SFX"
	reproductor.volume_db = volumen
	reproductor.bus = "sfx"
	add_child(reproductor)
	reproductor.play()
	
	await reproductor.finished
	
	reproductor.queue_free()
