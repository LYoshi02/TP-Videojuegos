extends AudioStreamPlayer2D

func reproducir_musica(musica: AudioStream, volumen = 0.0):
	if stream == musica:
		return
	
	stream = musica
	stream.loop = true
	volume_db = volumen
	play()

func reproducir_efecto_de_sonido(efecto: AudioStream, volumen = 0.0):
	var reproductor = AudioStreamPlayer2D.new()
	reproductor.stream = efecto
	reproductor.name = "REPRODUCTOR_SFX"
	reproductor.volume_db = volumen
	add_child(reproductor)
	reproductor.play()
	
	await reproductor.finished
	
	reproductor.queue_free()
