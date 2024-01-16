class_name TriggerPlatform
extends Node2D



#signal body_entered(body: Node)
#signal body_exited(body: Node)

#var colliding_bodies := {}

#func _ready() -> void:
	#var body_rid := get_rid()
	#PhysicsServer2D.body_set_omit_force_integration(body_rid, true)
	#PhysicsServer2D.body_set_force_integration_callback(body_rid, _integrate_forces)
	#PhysicsServer2D.body_set_max_contacts_reported(body_rid, 32)


#func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	#print(state)
	#var new_colliding_bodies := {}
	#for i in state.get_contact_count():
		#var body := state.get_contact_collider_object(i) as PhysicsBody2D
		#if not is_instance_valid(body):
			#continue
		#new_colliding_bodies[body] = body
		#if not colliding_bodies.has(body):
			#body_entered.emit(body)
		
	#for body in colliding_bodies.keys():
		#if not new_colliding_bodies.has(body):
			#body_exited.emit(body)
		
		#colliding_bodies = new_colliding_bodies
