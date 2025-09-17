extends Area2D
class_name HitboxComponent


var damage := 1.0
var critical := false
var knockback_power := 0.0
var source: Node2D


func enable() -> void:
	set_deferred("monitoring", true)
	set_deferred("monitorable", true)


func disable() -> void:
	set_deferred("monitoring", false)
	set_deferred("monitorable", false)


func setup (damage: float, critical: bool, knockback: float, source: Node2D) -> void:
	self.damage = damage
	self.critical = critical
	knockback_power = knockback
	self.source = source
	
