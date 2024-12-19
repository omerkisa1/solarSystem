extends Node3D

@export var orbit_radius_x: float = 60.0  # X eksenindeki yörünge yarıçapı
@export var orbit_radius_z: float = 60.0  # Z eksenindeki yörünge yarıçapı
@export var particle_lifetime: float = 2.0  # Kuyruğun yaşam süresi (saniye)
@export var particle_size: Vector2 = Vector2(0.1, 2.0)  # Çizgi boyutu: genişlik ve uzunluk
@export var particle_color: Color = Color(1, 0, 0, 1)  # Parçacık rengi

var current_angle: float = 0.0  # Yörüngedeki mevcut açı
var trail_particles: GPUParticles3D

func _ready():
	# TrailParticles düğümüne erişim
	trail_particles = $TrailParticles
	if trail_particles == null:
		print("TrailParticles düğümü bulunamadı!")
		return

	# GPUParticles3D ayarları
	trail_particles.lifetime = particle_lifetime  # Parçacık yaşam süresi

	# GPUParticles3D için ParticleProcessMaterial oluştur ve yapılandır
	var material = ParticleProcessMaterial.new()

  # Boyut ayarı (çizgi etkisi için uzunluk ve genişlik)
	material.set_param_min(ParticleProcessMaterial.PARAM_SCALE, particle_size.x)
	material.set_param_max(ParticleProcessMaterial.PARAM_SCALE, particle_size.y)

	# Renk ayarı
	material.color = particle_color

	# Yerçekimi etkisini kapatma
	material.gravity = Vector3.ZERO

	# Malzemeyi GPUParticles3D'ye uygula
	trail_particles.process_material = material
	trail_particles.emitting = true  # Parçacık yaymaya başla

func _process(delta):
	# Yörünge hareketini hesapla
	current_angle += Global.earth_orbit_speed * delta  # Hızı global değişkenden al
	if current_angle >= 360.0:
		current_angle -= 360.0

	var x_position = orbit_radius_x * cos(deg_to_rad(current_angle))
	var z_position = orbit_radius_z * sin(deg_to_rad(current_angle))

	# Earth pozisyonunu güncelle
	$Earth.global_transform.origin = Vector3(x_position, 0, z_position)

	# TrailParticles pozisyonunu güncelle
	if trail_particles != null:
		trail_particles.global_transform.origin = $Earth.global_transform.origin
