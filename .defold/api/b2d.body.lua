---@meta

---Box2D b2Body documentation
---@class b2d.body
b2d.body = {}

---Docs: https://defold.com/ref/stable/b2d.body/?q=b2d.body.set_transform#b2d.body.set_transform
---
---Set the position of the body's origin and rotation.
---This breaks any contacts and wakes the other bodies.
---Manipulating a body's transform may cause non-physical behavior.
---@param body b2Body body
---@param position vmath.vector3 the world position of the body's local origin.
---@param angle number the world position of the body's local origin.
function b2d.body.set_transform(body, position, angle) end

---Docs: https://defold.com/ref/stable/b2d.body/?q=b2d.body.get_position#b2d.body.get_position
---
---Get the world body origin position.
---@param body b2Body body
---@return vmath.vector3 position the world position of the body's origin.
function b2d.body.get_position(body) end

---Docs: https://defold.com/ref/stable/b2d.body/?q=b2d.body.get_world_center#b2d.body.get_world_center
---
---Get the angle in radians.
---@param body b2Body body
---@overload fun(body: b2Body): vmath.vector3
---@return number angle the current world rotation angle in radians.
function b2d.body.get_world_center(body) end

---Docs: https://defold.com/ref/stable/b2d.body/?q=b2d.body.get_local_center#b2d.body.get_local_center
---
---Get the local position of the center of mass.
---@param body b2Body body
---@return vmath.vector3 center Get the local position of the center of mass.
function b2d.body.get_local_center(body) end

---Docs: https://defold.com/ref/stable/b2d.body/?q=b2d.body.set_linear_velocity#b2d.body.set_linear_velocity
---
---Set the linear velocity of the center of mass.
---@param body b2Body body
---@param velocity vmath.vector3 the new linear velocity of the center of mass.
function b2d.body.set_linear_velocity(body, velocity) end

---Docs: https://defold.com/ref/stable/b2d.body/?q=b2d.body.get_linear_velocity#b2d.body.get_linear_velocity
---
---Get the linear velocity of the center of mass.
---@param body b2Body body
---@return vmath.vector3 velocity the linear velocity of the center of mass.
function b2d.body.get_linear_velocity(body) end

---Docs: https://defold.com/ref/stable/b2d.body/?q=b2d.body.get_angular_velocity#b2d.body.get_angular_velocity
---
---Set the angular velocity.
---@param body b2Body body
---@param omega number the new angular velocity in radians/second.
---@overload fun(body: b2Body): number
function b2d.body.get_angular_velocity(body, omega) end

---Docs: https://defold.com/ref/stable/b2d.body/?q=b2d.body.apply_force#b2d.body.apply_force
---
---Apply a force at a world point. If the force is not
---applied at the center of mass, it will generate a torque and
---affect the angular velocity. This wakes up the body.
---@param body b2Body body
---@param force vmath.vector3 the world force vector, usually in Newtons (N).
---@param point vmath.vector3 the world position of the point of application.
function b2d.body.apply_force(body, force, point) end

---Docs: https://defold.com/ref/stable/b2d.body/?q=b2d.body.apply_force_to_center#b2d.body.apply_force_to_center
---
---Apply a force to the center of mass. This wakes up the body.
---@param body b2Body body
---@param force vmath.vector3 the world force vector, usually in Newtons (N).
function b2d.body.apply_force_to_center(body, force) end

---Docs: https://defold.com/ref/stable/b2d.body/?q=b2d.body.apply_torque#b2d.body.apply_torque
---
---Apply a torque. This affects the angular velocity
---without affecting the linear velocity of the center of mass.
---This wakes up the body.
---@param body b2Body body
---@param torque number torque about the z-axis (out of the screen), usually in N-m.
function b2d.body.apply_torque(body, torque) end

---Docs: https://defold.com/ref/stable/b2d.body/?q=b2d.body.apply_linear_impulse#b2d.body.apply_linear_impulse
---
---Apply an impulse at a point. This immediately modifies the velocity.
---It also modifies the angular velocity if the point of application
---is not at the center of mass. This wakes up the body.
---@param body b2Body body
---@param impulse vmath.vector3 the world impulse vector, usually in N-seconds or kg-m/s.
---@param point vmath.vector3 the world position of the point of application.
function b2d.body.apply_linear_impulse(body, impulse, point) end

---Docs: https://defold.com/ref/stable/b2d.body/?q=b2d.body.apply_angular_impulse#b2d.body.apply_angular_impulse
---
---Apply an angular impulse.
---@param body b2Body body
---@param impulse number impulse the angular impulse in units of kgmm/s
function b2d.body.apply_angular_impulse(body, impulse) end

---Docs: https://defold.com/ref/stable/b2d.body/?q=b2d.body.get_mass#b2d.body.get_mass
---
---Get the total mass of the body.
---@param body b2Body body
---@return number mass the mass, usually in kilograms (kg).
function b2d.body.get_mass(body) end

---Docs: https://defold.com/ref/stable/b2d.body/?q=b2d.body.get_inertia#b2d.body.get_inertia
---
---Get the rotational inertia of the body about the local origin.
---@param body b2Body body
---@return number inertia the rotational inertia, usually in kg-m^2.
function b2d.body.get_inertia(body) end

---Docs: https://defold.com/ref/stable/b2d.body/?q=b2d.body.reset_mass_data#b2d.body.reset_mass_data
---
---This resets the mass properties to the sum of the mass properties of the fixtures.
---This normally does not need to be called unless you called SetMassData to override
---@param body b2Body body
function b2d.body.reset_mass_data(body) end

---Docs: https://defold.com/ref/stable/b2d.body/?q=b2d.body.get_world_point#b2d.body.get_world_point
---
---Get the world coordinates of a point given the local coordinates.
---@param body b2Body body
---@param local_vector vmath.vector3 localPoint a point on the body measured relative the the body's origin.
---@return vmath.vector3 vector the same point expressed in world coordinates.
function b2d.body.get_world_point(body, local_vector) end

---Docs: https://defold.com/ref/stable/b2d.body/?q=b2d.body.get_world_vector#b2d.body.get_world_vector
---
---Get the world coordinates of a vector given the local coordinates.
---@param body b2Body body
---@param local_vector vmath.vector3 a vector fixed in the body.
---@return vmath.vector3 vector the same vector expressed in world coordinates.
function b2d.body.get_world_vector(body, local_vector) end

---Docs: https://defold.com/ref/stable/b2d.body/?q=b2d.body.get_local_point#b2d.body.get_local_point
---
---Gets a local point relative to the body's origin given a world point.
---@param body b2Body body
---@param world_point vmath.vector3 a point in world coordinates.
---@return vmath.vector3 vector the corresponding local point relative to the body's origin.
function b2d.body.get_local_point(body, world_point) end

---Docs: https://defold.com/ref/stable/b2d.body/?q=b2d.body.get_local_vector#b2d.body.get_local_vector
---
---Gets a local vector given a world vector.
---@param body b2Body body
---@param world_vector vmath.vector3 a vector in world coordinates.
---@return vmath.vector3 vector the corresponding local vector.
function b2d.body.get_local_vector(body, world_vector) end

---Docs: https://defold.com/ref/stable/b2d.body/?q=b2d.body.get_linear_velocity_from_world_point#b2d.body.get_linear_velocity_from_world_point
---
---Get the world linear velocity of a world point attached to this body.
---@param body b2Body body
---@param world_point vmath.vector3 a point in world coordinates.
---@return vmath.vector3 velocity the world velocity of a point.
function b2d.body.get_linear_velocity_from_world_point(body, world_point) end

---Docs: https://defold.com/ref/stable/b2d.body/?q=b2d.body.get_linear_velocity_from_local_point#b2d.body.get_linear_velocity_from_local_point
---
---Get the world velocity of a local point.
---@param body b2Body body
---@param local_point vmath.vector3 a point in local coordinates.
---@return vmath.vector3 velocity the world velocity of a point.
function b2d.body.get_linear_velocity_from_local_point(body, local_point) end

---Docs: https://defold.com/ref/stable/b2d.body/?q=b2d.body.set_linear_damping#b2d.body.set_linear_damping
---
---Set the linear damping of the body.
---@param body b2Body body
---@param damping number the damping
function b2d.body.set_linear_damping(body, damping) end

---Docs: https://defold.com/ref/stable/b2d.body/?q=b2d.body.get_linear_damping#b2d.body.get_linear_damping
---
---Get the linear damping of the body.
---@param body b2Body body
---@return number damping the damping
function b2d.body.get_linear_damping(body) end

---Docs: https://defold.com/ref/stable/b2d.body/?q=b2d.body.set_angular_damping#b2d.body.set_angular_damping
---
---Set the angular damping of the body.
---@param body b2Body body
---@param damping number the damping
function b2d.body.set_angular_damping(body, damping) end

---Docs: https://defold.com/ref/stable/b2d.body/?q=b2d.body.get_angular_damping#b2d.body.get_angular_damping
---
---Get the angular damping of the body.
---@param body b2Body body
---@return number damping the damping
function b2d.body.get_angular_damping(body) end

---Docs: https://defold.com/ref/stable/b2d.body/?q=b2d.body.set_gravity_scale#b2d.body.set_gravity_scale
---
---Set the gravity scale of the body.
---@param body b2Body body
---@param scale number the scale
function b2d.body.set_gravity_scale(body, scale) end

---Docs: https://defold.com/ref/stable/b2d.body/?q=b2d.body.get_gravity_scale#b2d.body.get_gravity_scale
---
---Get the gravity scale of the body.
---@param body b2Body body
---@return number scale the scale
function b2d.body.get_gravity_scale(body) end

---Docs: https://defold.com/ref/stable/b2d.body/?q=b2d.body.set_type#b2d.body.set_type
---
---Set the type of this body. This may alter the mass and velocity.
---@param body b2Body body
---@param type b2BodyType the body type
function b2d.body.set_type(body, type) end

---Docs: https://defold.com/ref/stable/b2d.body/?q=b2d.body.get_type#b2d.body.get_type
---
---Get the type of this body.
---@param body b2Body body
---@return b2BodyType type the body type
function b2d.body.get_type(body) end

---Docs: https://defold.com/ref/stable/b2d.body/?q=b2d.body.set_bullet#b2d.body.set_bullet
---
---Should this body be treated like a bullet for continuous collision detection?
---@param body b2Body body
---@param enable bool if true, the body will be in bullet mode
function b2d.body.set_bullet(body, enable) end

---Docs: https://defold.com/ref/stable/b2d.body/?q=b2d.body.is_bullet#b2d.body.is_bullet
---
---Is this body in bullet mode
---@param body b2Body body
---@return bool enabled true if the body is in bullet mode
function b2d.body.is_bullet(body) end

---Docs: https://defold.com/ref/stable/b2d.body/?q=b2d.body.set_sleeping_allowed#b2d.body.set_sleeping_allowed
---
---You can disable sleeping on this body. If you disable sleeping, the body will be woken.
---@param body b2Body body
---@param enable bool if false, the body will never sleep, and consume more CPU
function b2d.body.set_sleeping_allowed(body, enable) end

---Docs: https://defold.com/ref/stable/b2d.body/?q=b2d.body.is_sleeping_allowed#b2d.body.is_sleeping_allowed
---
---Is this body allowed to sleep
---@param body b2Body body
---@return bool enabled true if the body is allowed to sleep
function b2d.body.is_sleeping_allowed(body) end

---Docs: https://defold.com/ref/stable/b2d.body/?q=b2d.body.set_awake#b2d.body.set_awake
---
---Set the sleep state of the body. A sleeping body has very low CPU cost.
---@param body b2Body body
---@param enable bool flag set to false to put body to sleep, true to wake it.
function b2d.body.set_awake(body, enable) end

---Docs: https://defold.com/ref/stable/b2d.body/?q=b2d.body.is_awake#b2d.body.is_awake
---
---Get the sleeping state of this body.
---@param body b2Body body
---@return bool enabled true if the body is awake, false if it's sleeping.
function b2d.body.is_awake(body) end

---Docs: https://defold.com/ref/stable/b2d.body/?q=b2d.body.set_active#b2d.body.set_active
---
---Set the active state of the body. An inactive body is not
---simulated and cannot be collided with or woken up.
---If you pass a flag of true, all fixtures will be added to the
---broad-phase.
---If you pass a flag of false, all fixtures will be removed from
---the broad-phase and all contacts will be destroyed.
---Fixtures and joints are otherwise unaffected. You may continue
---to create/destroy fixtures and joints on inactive bodies.
---Fixtures on an inactive body are implicitly inactive and will
---not participate in collisions, ray-casts, or queries.
---Joints connected to an inactive body are implicitly inactive.
---An inactive body is still owned by a b2World object and remains
---in the body list.
---@param body b2Body body
---@param enable bool true if the body should be active
function b2d.body.set_active(body, enable) end

---Docs: https://defold.com/ref/stable/b2d.body/?q=b2d.body.is_active#b2d.body.is_active
---
---Get the active state of the body.
---@param body b2Body body
---@return bool enabled is the body active
function b2d.body.is_active(body) end

---Docs: https://defold.com/ref/stable/b2d.body/?q=b2d.body.set_fixed_rotation#b2d.body.set_fixed_rotation
---
---Set this body to have fixed rotation. This causes the mass to be reset.
---@param body b2Body body
---@param enable bool true if the rotation should be fixed
function b2d.body.set_fixed_rotation(body, enable) end

---Docs: https://defold.com/ref/stable/b2d.body/?q=b2d.body.is_fixed_rotation#b2d.body.is_fixed_rotation
---
---Does this body have fixed rotation?
---@param body b2Body body
---@return bool enabled is the rotation fixed
function b2d.body.is_fixed_rotation(body) end

---Docs: https://defold.com/ref/stable/b2d.body/?q=b2d.body.get_next#b2d.body.get_next
---
---Get the next body in the world's body list.
---@param body b2Body body
---@return b2Body body the next body
function b2d.body.get_next(body) end

---Docs: https://defold.com/ref/stable/b2d.body/?q=b2d.body.get_world#b2d.body.get_world
---
---Get the parent world of this body.
---@param body b2Body body
---@return b2World world 
function b2d.body.get_world(body) end

---Docs: https://defold.com/ref/stable/b2d.body/?q=b2d.body.dump#b2d.body.dump
---
---Print the body representation to the log output
---@param body b2Body body
function b2d.body.dump(body) end

---Static (immovable) body
b2d.body.B2_STATIC_BODY = nil

---Kinematic body
b2d.body.B2_KINEMATIC_BODY = nil

---Dynamic body
b2d.body.B2_DYNAMIC_BODY = nil

