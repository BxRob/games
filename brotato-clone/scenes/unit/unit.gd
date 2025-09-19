extends Node2D
class_name Unit

@export var stats: UnitStats

@onready var visuals = %Visuals
@onready var sprite = %Sprite
@onready var anim_player = $AnimationPlayer
@onready var health_component = $HealthComponent
@onready var flash_timer = $FlashTimer


func _ready() -> void:
	health_component.setup(stats)


func set_flash_material() -> void:
	sprite.material = Global.FLASH_MATERIAL
	flash_timer.start()


func _on_hurtbox_component_on_damaged(hitbox: HitboxComponent):
	if health_component.current_health <= 0:
		return
	
	var blocked = Global.get_chance_success(stats.block_chance / 100)
	if blocked:
		Global.on_create_block_text.emit(self)
		return
	
	set_flash_material()
	
	health_component.take_damage(hitbox.damage)
	Global.on_create_damage_text.emit(self, hitbox)


func _on_flash_timer_timeout():
	sprite.material = null
