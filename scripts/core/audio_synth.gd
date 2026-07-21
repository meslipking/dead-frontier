# ═══════════════════════════════════════════════════════════════
#  AUDIO SYNTHESIZER (audio_synth.gd) — Procedural SFX Engine
#  Tự động tổng hợp âm thanh 16-bit SNES (Chém, Bắn, Nổ, Click) bằng GDScript
# ═══════════════════════════════════════════════════════════════
class_name AudioSynthesizer

static func generate_laser_sfx(frequency: float = 880.0, duration: float = 0.15) -> AudioStreamWAV:
	var sample_rate := 22050
	var total_samples := int(sample_rate * duration)
	var stream := AudioStreamWAV.new()
	stream.format = AudioStreamWAV.FORMAT_8_BITS
	stream.mix_rate = sample_rate
	
	var data := PackedByteArray()
	data.resize(total_samples)
	
	for i in total_samples:
		var t := float(i) / float(sample_rate)
		var freq := frequency * (1.0 - t / duration) # Frequency sweep down
		var val := sin(2.0 * PI * freq * t)
		var byte_val := int(clamp((val * 0.5 + 0.5) * 255.0, 0, 255))
		data[i] = byte_val
		
	stream.data = data
	return stream

static func generate_slash_sfx(duration: float = 0.12) -> AudioStreamWAV:
	var sample_rate := 22050
	var total_samples := int(sample_rate * duration)
	var stream := AudioStreamWAV.new()
	stream.format = AudioStreamWAV.FORMAT_8_BITS
	stream.mix_rate = sample_rate
	
	var data := PackedByteArray()
	data.resize(total_samples)
	
	for i in total_samples:
		var env := 1.0 - (float(i) / float(total_samples))
		var noise := randf_range(-1.0, 1.0) * env
		var byte_val := int(clamp((noise * 0.4 + 0.5) * 255.0, 0, 255))
		data[i] = byte_val
		
	stream.data = data
	return stream
