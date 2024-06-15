---@meta

---Collision object physics API documentation
---@class physics
physics = {}

---Docs: https://defold.com/ref/stable/physics/?q=physics.raycast_async#physics.raycast_async
---
---Ray casts are used to test for intersections against collision objects in the physics world.
---Collision objects of types kinematic, dynamic and static are tested against. Trigger objects
---do not intersect with ray casts.
---Which collision objects to hit is filtered by their collision groups and can be configured
---through <code>groups</code>.
---The actual ray cast will be performed during the physics-update.
---
---If an object is hit, the result will be reported via a ray_cast_response message.
---
---If there is no object hit, the result will be reported via a ray_cast_missed message.
---
---@param from vector3 the world position of the start of the ray
---@param to vector3 the world position of the end of the ray
---@param groups table a lua table containing the hashed groups for which to test collisions against
---@param request_id number|nil a number between [0,-255]. It will be sent back in the response for identification, 0 by default
---@overload fun(from: vector3, to: vector3, groups: table)
function physics.raycast_async(from, to, groups, request_id) end

---Docs: https://defold.com/ref/stable/physics/?q=physics.raycast#physics.raycast
---
---Ray casts are used to test for intersections against collision objects in the physics world.
---Collision objects of types kinematic, dynamic and static are tested against. Trigger objects
---do not intersect with ray casts.
---Which collision objects to hit is filtered by their collision groups and can be configured
---through <code>groups</code>.
---@param from vector3 the world position of the start of the ray
---@param to vector3 the world position of the end of the ray
---@param groups table a lua table containing the hashed groups for which to test collisions against
---@param options {all:boolean}|nil a lua table containing options for the raycast.
---@overload fun(from: vector3, to: vector3, groups: table): table|nil
---@return table|nil result It returns a list. If missed it returns <code>nil</code>. See ray_cast_response for details on the returned values.
function physics.raycast(from, to, groups, options) end

---Docs: https://defold.com/ref/stable/physics/?q=physics.create_joint#physics.create_joint
---
---Create a physics joint between two collision object components.
---Note: Currently only supported in 2D physics.
---@param joint_type number the joint type
---@param collisionobject_a string|hash|url first collision object
---@param joint_id string|hash id of the joint
---@param position_a vector3 local position where to attach the joint on the first collision object
---@param collisionobject_b string|hash|url second collision object
---@param position_b vector3 local position where to attach the joint on the second collision object
---@param properties table|nil optional joint specific properties table
---@overload fun(joint_type: number, collisionobject_a: string|hash|url, joint_id: string|hash, position_a: vector3, collisionobject_b: string|hash|url, position_b: vector3)
function physics.create_joint(joint_type, collisionobject_a, joint_id, position_a, collisionobject_b, position_b, properties) end

---Docs: https://defold.com/ref/stable/physics/?q=physics.destroy_joint#physics.destroy_joint
---
---Destroy an already physics joint. The joint has to be created before a
---destroy can be issued.
---Note: Currently only supported in 2D physics.
---@param collisionobject string|hash|url collision object where the joint exist
---@param joint_id string|hash id of the joint
function physics.destroy_joint(collisionobject, joint_id) end

---Docs: https://defold.com/ref/stable/physics/?q=physics.get_joint_properties#physics.get_joint_properties
---
---Get a table for properties for a connected joint. The joint has to be created before
---properties can be retrieved.
---Note: Currently only supported in 2D physics.
---@param collisionobject string|hash|url collision object where the joint exist
---@param joint_id string|hash id of the joint
---@return {collide_connected:boolean} properties properties table. See the joint types for what fields are available, the only field available for all types is
function physics.get_joint_properties(collisionobject, joint_id) end

---Docs: https://defold.com/ref/stable/physics/?q=physics.set_joint_properties#physics.set_joint_properties
---
---Updates the properties for an already connected joint. The joint has to be created before
---properties can be changed.
---Note: Currently only supported in 2D physics.
---@param collisionobject string|hash|url collision object where the joint exist
---@param joint_id string|hash id of the joint
---@param properties table joint specific properties table
function physics.set_joint_properties(collisionobject, joint_id, properties) end

---Docs: https://defold.com/ref/stable/physics/?q=physics.get_joint_reaction_force#physics.get_joint_reaction_force
---
---Get the reaction force for a joint. The joint has to be created before
---the reaction force can be calculated.
---Note: Currently only supported in 2D physics.
---@param collisionobject string|hash|url collision object where the joint exist
---@param joint_id string|hash id of the joint
---@return vector3 force reaction force for the joint
function physics.get_joint_reaction_force(collisionobject, joint_id) end

---Docs: https://defold.com/ref/stable/physics/?q=physics.get_joint_reaction_torque#physics.get_joint_reaction_torque
---
---Get the reaction torque for a joint. The joint has to be created before
---the reaction torque can be calculated.
---Note: Currently only supported in 2D physics.
---@param collisionobject string|hash|url collision object where the joint exist
---@param joint_id string|hash id of the joint
---@return float torque the reaction torque on bodyB in N*m.
function physics.get_joint_reaction_torque(collisionobject, joint_id) end

---Docs: https://defold.com/ref/stable/physics/?q=physics.set_gravity#physics.set_gravity
---
---Set the gravity in runtime. The gravity change is not global, it will only affect
---the collection that the function is called from.
---Note: For 2D physics the z component of the gravity vector will be ignored.
---@param gravity vector3 the new gravity vector
function physics.set_gravity(gravity) end

---Docs: https://defold.com/ref/stable/physics/?q=physics.get_gravity#physics.get_gravity
---
---Get the gravity in runtime. The gravity returned is not global, it will return
---the gravity for the collection that the function is called from.
---Note: For 2D physics the z component will always be zero.
---@return vector3 gravity gravity vector of collection
function physics.get_gravity() end

---Docs: https://defold.com/ref/stable/physics/?q=physics.set_hflip#physics.set_hflip
---
---Flips the collision shapes horizontally for a collision object
---@param url string|hash|url the collision object that should flip its shapes
---@param flip boolean <code>true</code> if the collision object should flip its shapes, <code>false</code> if not
function physics.set_hflip(url, flip) end

---Docs: https://defold.com/ref/stable/physics/?q=physics.set_vflip#physics.set_vflip
---
---Flips the collision shapes vertically for a collision object
---@param url string|hash|url the collision object that should flip its shapes
---@param flip boolean <code>true</code> if the collision object should flip its shapes, <code>false</code> if not
function physics.set_vflip(url, flip) end

---Docs: https://defold.com/ref/stable/physics/?q=physics.wakeup#physics.wakeup
---
---Collision objects tend to fall asleep when inactive for a small period of time for
---efficiency reasons. This function wakes them up.
---@param url string|hash|url the collision object to wake. <code>function on_input(self, action_id, action)     if action_id == hash(&quot;test&quot;) and action.pressed then         physics.wakeup(&quot;#collisionobject&quot;)     end end </code>
function physics.wakeup(url) end

---Docs: https://defold.com/ref/stable/physics/?q=physics.set_group#physics.set_group
---
---Updates the group property of a collision object to the specified
---string value. The group name should exist i.e. have been used in
---a collision object in the editor.
---@param url string|hash|url the collision object affected.
---@param group string the new group name to be assigned. <code>local function change_collision_group()      physics.set_group(&quot;#collisionobject&quot;, &quot;enemy&quot;) end </code>
function physics.set_group(url, group) end

---Docs: https://defold.com/ref/stable/physics/?q=physics.get_group#physics.get_group
---
---Returns the group name of a collision object as a hash.
---@param url string|hash|url the collision object to return the group of.
---@return hash group hash value of the group. <code>local function check_is_enemy()     local group = physics.get_group(&quot;#collisionobject&quot;)     return group == hash(&quot;enemy&quot;) end </code>
function physics.get_group(url) end

---Docs: https://defold.com/ref/stable/physics/?q=physics.set_maskbit#physics.set_maskbit
---
---Sets or clears the masking of a group (maskbit) in a collision object.
---@param url string|hash|url the collision object to change the mask of.
---@param group string the name of the group (maskbit) to modify in the mask.
---@param maskbit boolean boolean value of the new maskbit. 'true' to enable, 'false' to disable. <code>local function make_invincible()     -- no longer collide with the &quot;bullet&quot; group     physics.set_maskbit(&quot;#collisionobject&quot;, &quot;bullet&quot;, false) end </code>
function physics.set_maskbit(url, group, maskbit) end

---Docs: https://defold.com/ref/stable/physics/?q=physics.get_maskbit#physics.get_maskbit
---
---Returns true if the specified group is set in the mask of a collision
---object, false otherwise.
---@param url string|hash|url the collision object to check the mask of.
---@param group string the name of the group to check for.
---@return boolean maskbit boolean value of the maskbit. 'true' if present, 'false' otherwise. <code>local function is_invincible()     -- check if the collisionobject would collide with the &quot;bullet&quot; group     local invincible = physics.get_maskbit(&quot;#collisionobject&quot;, &quot;bullet&quot;)     return invincible end </code>
function physics.get_maskbit(url, group) end

---Docs: https://defold.com/ref/stable/physics/?q=physics.get_shape#physics.get_shape
---
---Gets collision shape data from a collision object
---@param url string|hash|url the collision object.
---@param shape string|hash the name of the shape to get data for.
---@return {type:number, diameter:number, dimensions:vector3, diameter:number, height:number} table A table containing meta data about the physics shape
function physics.get_shape(url, shape) end

---Docs: https://defold.com/ref/stable/physics/?q=physics.set_shape#physics.set_shape
---
---Sets collision shape data for a collision object. Please note that updating data in 3D
---can be quite costly for box and capsules. Because of the physics engine, the cost
---comes from having to recreate the shape objects when certain shapes needs to be updated.
---@param url string|hash|url the collision object.
---@param shape string|hash the name of the shape to get data for.
---@param table table the shape data to update the shape with.
function physics.set_shape(url, shape, table) end

---Docs: https://defold.com/ref/stable/physics/?q=physics.set_listener#physics.set_listener
---
---sets a physics world event listener. If a function is set, physics messages will no longer be sent.
---@param callback function(self, event, data)|nil A callback that receives information about all the physics interactions in this physics world.  <code>self</code> object The calling script <code>event</code> constant The type of event. Can be one of these messages:   contact_point_event  collision_event  trigger_event  ray_cast_response  ray_cast_missed   <code>data</code> table The callback value data is a table that contains event-related data. See the documentation for details on the messages. 
function physics.set_listener(callback) end

---Docs: https://defold.com/ref/stable/physics/?q=physics.update_mass#physics.update_mass
---
---The function recalculates the density of each shape based on the total area of all shapes and the specified mass, then updates the mass of the body accordingly.
---Note: Currently only supported in 2D physics.
---@param collisionobject string|hash|url the collision object whose mass needs to be updated.
---@param mass number the new mass value to set for the collision object.
function physics.update_mass(collisionobject, mass) end

---Post this message to a collision-object-component to apply the specified force on the collision object.
---The collision object must be dynamic.
---@class apply_force_msg
---@field force vector3 the force to be applied on the collision object, measured in Newton
---@field position vector3 the position where the force should be applied

---This message is broadcasted to every component of an instance that has a collision object,
---when the collision object collides with another collision object. For a script to take action
---when such a collision happens, it should check for this message in its <code>on_message</code> callback
---function.
---This message only reports that a collision actually happened and will only be sent once per
---colliding pair and frame.
---To retrieve more detailed information, check for the <code>contact_point_response</code> instead.
---@class collision_response_msg
---@field other_id hash the id of the instance the collision object collided with
---@field other_position vector3 the world position of the instance the collision object collided with
---@field other_group hash the collision group of the other collision object
---@field own_group hash the collision group of the own collision object

---This message is broadcasted to every component of an instance that has a collision object,
---when the collision object has contact points with respect to another collision object.
---For a script to take action when such contact points occur, it should check for this message
---in its <code>on_message</code> callback function.
---Since multiple contact points can occur for two colliding objects, this message can be sent
---multiple times in the same frame for the same two colliding objects. To only be notified once
---when the collision occurs, check for the <code>collision_response</code> message instead.
---@class contact_point_response_msg
---@field position vector3 world position of the contact point
---@field normal vector3 normal in world space of the contact point, which points from the other object towards the current object
---@field relative_velocity vector3 the relative velocity of the collision object as observed from the other object
---@field distance number the penetration distance between the objects, which is always positive
---@field applied_impulse number the impulse the contact resulted in
---@field life_time number life time of the contact, not currently used
---@field mass number the mass of the current collision object in kg
---@field other_mass number the mass of the other collision object in kg
---@field other_id hash the id of the instance the collision object is in contact with
---@field other_position vector3 the world position of the other collision object
---@field other_group hash the collision group of the other collision object
---@field own_group hash the collision group of the own collision object

---This message is broadcasted to every component of an instance that has a collision object,
---when the collision object interacts with another collision object and one of them is a trigger.
---For a script to take action when such an interaction happens, it should check for this message
---in its <code>on_message</code> callback function.
---This message only reports that an interaction actually happened and will only be sent once per
---colliding pair and frame. To retrieve more detailed information, check for the
---<code>contact_point_response</code> instead.
---@class trigger_response_msg
---@field other_id hash the id of the instance the collision object collided with
---@field enter boolean if the interaction was an entry or not
---@field other_group hash the collision group of the triggering collision object
---@field own_group hash the collision group of the own collision object

---This message is sent back to the sender of a ray_cast_request, or to the physics world listener
---if it is set (see physics.set_listener), if the ray hits a collision object.
---See physics.raycast_async for examples of how to use it.
---@class ray_cast_response_msg
---@field fraction number the fraction of the hit measured along the ray, where 0 is the start of the ray and 1 is the end
---@field position vector3 the world position of the hit
---@field normal vector3 the normal of the surface of the collision object where it was hit
---@field id hash the instance id of the hit collision object
---@field group hash the collision group of the hit collision object as a hashed name
---@field request_id number id supplied when the ray cast was requested

---This message is sent back to the sender of a ray_cast_request, or to the physics world listener
---if it is set (see physics.set_listener), if the ray didn't hit any collision object.
---See physics.raycast_async for examples of how to use it.
---@class ray_cast_missed_msg
---@field request_id number id supplied when the ray cast was requested

---See physics.set_listener.
---This message is sent to a function specified in physics.set_listener when
---a collision object has contact points with another collision object.
---Since multiple contact points can occur for two colliding objects, this event can be sent
---multiple times in the same frame for the same two colliding objects. To only be notified once
---when the collision occurs, check for the collision_event event instead.
---@class contact_point_event_msg
---@field applied_impulse number the impulse the contact resulted in
---@field distance number the penetration distance between the objects, which is always positive
---@field a {position:vector3, id:hash, group:hash, relative_velocity:vector3, mass:number, normal:vector3} contact point information for object A
---@field b {position:vector3, id:hash, group:hash, relative_velocity:vector3, mass:number, normal:vector3} contact point information for object B

---See physics.set_listener.
---This message is sent to a function specified in physics.set_listener
---when two collision objects collide.
---This message only reports that a collision has occurred and will be sent once per frame and per colliding pair.
---For more detailed information, check for the contact_point_event.
---@class collision_event_msg
---@field a {position:vector3, id:hash, group:hash} collision information for object A
---@field b {position:vector3, id:hash, group:hash} collision information for object B

---See physics.set_listener.
---This message is sent to a function specified in physics.set_listener
---when a collision object interacts with another collision object and one of them is a trigger.
---This message only reports that an interaction actually happened and will be sent once per colliding pair and frame.
---For more detailed information, check for the contact_point_event.
---@class trigger_event_msg
---@field enter boolean if the interaction was an entry or not
---@field a {id:hash, group:hash} 
---@field b {id:hash, group:hash} collision information for object B

---The following properties are available when connecting a joint of <code>JOINT_TYPE_SPRING</code> type:
physics.JOINT_TYPE_SPRING = nil

---The following properties are available when connecting a joint of <code>JOINT_TYPE_FIXED</code> type:
physics.JOINT_TYPE_FIXED = nil

---The following properties are available when connecting a joint of <code>JOINT_TYPE_HINGE</code> type:
physics.JOINT_TYPE_HINGE = nil

---The following properties are available when connecting a joint of <code>JOINT_TYPE_SLIDER</code> type:
physics.JOINT_TYPE_SLIDER = nil

---The following properties are available when connecting a joint of <code>JOINT_TYPE_WELD</code> type:
physics.JOINT_TYPE_WELD = nil

---The following properties are available when connecting a joint of <code>JOINT_TYPE_WHEEL</code> type:
physics.JOINT_TYPE_WHEEL = nil

---
physics.SHAPE_TYPE_SPHERE = nil

---
physics.SHAPE_TYPE_BOX = nil

---
physics.SHAPE_TYPE_CAPSULE = nil

---
physics.SHAPE_TYPE_HULL = nil

