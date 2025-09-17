extends Node2D
class_name Unit

@export var stats: UnitStats

@onready var visuals = %Visuals
@onready var sprite = %Sprite
@onready var anim_player = $AnimationPlayer
@onready var health_component = $HealthComponent


func _ready() -> void:
	health_component.setup(stats)


func _on_hurtbox_component_on_damaged(hitbox: HitboxComponent):
	if health_component.current_health <= 0:
		return
	
	health_component.take_damage(hitbox.damage)
	print("%s: %d" % [name, health_component.current_health])
