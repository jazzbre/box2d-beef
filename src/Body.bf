using System;

namespace Box2D
{
	enum b2BodyType
	{
		b2_staticBody = 0,
		b2_kinematicBody,
		b2_dynamicBody
	}

	[CRepr]
	struct b2BodyDef
	{
		/// The body type: static, kinematic, or dynamic.
		/// Note: if a dynamic body would have zero mass, the mass is set to one.
		public b2BodyType type = .b2_staticBody;

		/// The world position of the body. Avoid creating bodies at the origin
		/// since this can lead to many overlapping shapes.
		public b2Vec2 position;

		/// The world angle of the body in radians.
		public float angle;

		/// The linear velocity of the body's origin in world co-ordinates.
		public b2Vec2 linearVelocity;

		/// The angular velocity of the body.
		public float angularVelocity;

		/// Linear damping is use to reduce the linear velocity. The damping parameter
		/// can be larger than 1.0f but the damping effect becomes sensitive to the
		/// time step when the damping parameter is large.
		/// Units are 1/time
		public float linearDamping;

		/// Angular damping is use to reduce the angular velocity. The damping parameter
		/// can be larger than 1.0f but the damping effect becomes sensitive to the
		/// time step when the damping parameter is large.
		/// Units are 1/time
		public float angularDamping;

		/// Set this flag to false if this body should never fall asleep. Note that
		/// this increases CPU usage.
		public bool allowSleep = true;

		/// Is this body initially awake or sleeping?
		public bool awake = true;

		/// Should this body be prevented from rotating? Useful for characters.
		public bool fixedRotation;

		/// Is this a fast moving body that should be prevented from tunneling through
		/// other moving bodies? Note that all bodies are prevented from tunneling through
		/// kinematic and static bodies. This setting is only considered on dynamic bodies.
		/// @warning You should use this flag sparingly since it increases processing time.
		public bool bullet;

		/// Does this body start out enabled?
		public bool enabled = true;

		/// Use this to store application specific body data.
		public b2BodyUserData userData;

		/// Scale the gravity applied to this body.
		public float gravityScale = 1.0f;
	}

	static class Body
	{
		[LinkName("b2Body_CreateFixture")] public static extern b2Fixture* CreateFixture(b2Body* body, b2FixtureDef* def);
		[LinkName("b2Body_CreateFixtureWithShapeDensity")] public static extern b2Fixture* CreateFixture(b2Body* body, b2Shape* shape, float density);
		[LinkName("b2Body_DestroyFixture")] public static extern void DestroyFixture(b2Body* body, b2Fixture* fixture);

		[LinkName("b2Body_SetTransform")] public static extern void SetTransform(b2Body* body, ref b2Vec2 position, float angle);
		[LinkName("b2Body_GetPreviousTransform")] public static extern b2Transform GetPreviousTransform(b2Body* body);
		[LinkName("b2Body_GetTransform")] public static extern b2Transform GetTransform(b2Body* body);

		[LinkName("b2Body_GetPosition")] public static extern b2Vec2 GetPosition(b2Body* body);

		[LinkName("b2Body_GetAngle")] public static extern float GetAngle(b2Body* body);

		[LinkName("b2Body_GetWorldCenter")] public static extern b2Vec2 GetWorldCenter(b2Body* body);
		[LinkName("b2Body_GetLocalCenter")] public static extern b2Vec2 GetLocalCenter(b2Body* body);

		[LinkName("b2Body_SetLinearVelocity")] public static extern void SetLinearVelocity(b2Body* body, ref b2Vec2 v);
		[LinkName("b2Body_GetLinearVelocity")] public static extern b2Vec2 GetLinearVelocity(b2Body* body);

		[LinkName("b2Body_SetAngularVelocity")] public static extern void SetAngularVelocity(b2Body* body, float omega);
		[LinkName("b2Body_GetAngularVelocity")] public static extern float GetAngularVelocity(b2Body* body);

		[LinkName("b2Body_ApplyForce")] public static extern void ApplyForce(b2Body* body, ref b2Vec2 force, ref b2Vec2 point, bool wake);
		[LinkName("b2Body_ApplyForceToCenter")] public static extern void ApplyForceToCenter(b2Body* body, ref b2Vec2 force, bool wake);

		[LinkName("b2Body_ApplyTorque")] public static extern void ApplyTorque(b2Body* body, float torque, bool wake);

		[LinkName("b2Body_ApplyLinearImpulse")] public static extern void ApplyLinearImpulse(b2Body* body, ref b2Vec2 impulse, ref b2Vec2 point, bool wake);
		[LinkName("b2Body_ApplyLinearImpulseToCenter")] public static extern void ApplyLinearImpulseToCenter(b2Body* body, ref b2Vec2 impulse, bool wake);

		[LinkName("b2Body_ApplyAngularImpulse")] public static extern void ApplyAngularImpulse(b2Body* body, float impulse, bool wake);

		[LinkName("b2Body_GetMass")] public static extern float GetMass(b2Body* body);
		[LinkName("b2Body_GetInertia")] public static extern float GetInertia(b2Body* body);

		[LinkName("b2Body_GetMassData")] public static extern b2MassData GetMassData(b2Body* body);
		[LinkName("b2Body_SetMassData")] public static extern void SetMassData(b2Body* body, ref b2MassData data);
		[LinkName("b2Body_ResetMassData")] public static extern void ResetMassData(b2Body* body);

		[LinkName("b2Body_GetWorldPoint")] public static extern b2Vec2 GetWorldPoint(b2Body* body, ref b2Vec2 v);
		[LinkName("b2Body_GetWorldVector")] public static extern b2Vec2 GetWorldVector(b2Body* body, ref b2Vec2 v);

		[LinkName("b2Body_GetLocalPoint")] public static extern b2Vec2 GetLocalPoint(b2Body* body, ref b2Vec2 v);
		[LinkName("b2Body_GetLocalVector")] public static extern b2Vec2 GetLocalVector(b2Body* body, ref b2Vec2 v);

		[LinkName("b2Body_GetLinearVelocityFromWorldPoint")] public static extern b2Vec2 GetLinearVelocityFromWorldPoint(b2Body* body, ref b2Vec2 v);
		[LinkName("b2Body_GetLinearVelocityFromLocalPoint")] public static extern b2Vec2 GetLinearVelocityFromLocalPoint(b2Body* body, ref b2Vec2 v);

		[LinkName("b2Body_GetLinearDamping")] public static extern float GetLinearDamping(b2Body* body);
		[LinkName("b2Body_SetLinearDamping")] public static extern void SetLinearDamping(b2Body* body, float v);

		[LinkName("b2Body_GetAngularDamping")] public static extern float GetAngularDamping(b2Body* body);
		[LinkName("b2Body_SetAngularDamping")] public static extern void SetAngularDamping(b2Body* body, float v);

		[LinkName("b2Body_GetGravityScale")] public static extern float GetGravityScale(b2Body* body);
		[LinkName("b2Body_SetGravityScale")] public static extern void SetGravityScale(b2Body* body, float v);

		[LinkName("b2Body_SetBodyType")] public static extern void SetBodyType(b2Body* body, b2BodyType v);
		[LinkName("b2Body_GetBodyType")] public static extern b2BodyType GetBodyType(b2Body* body);

		[LinkName("b2Body_SetBullet")] public static extern void SetBullet(b2Body* body, bool v);
		[LinkName("b2Body_IsBullet")] public static extern bool IsBullet(b2Body* body);

		[LinkName("b2Body_SetSleepingAllowed")] public static extern void SetSleepingAllowed(b2Body* body, bool v);
		[LinkName("b2Body_IsSleepingAllowed")] public static extern bool IsSleepingAllowed(b2Body* body);

		[LinkName("b2Body_SetAwake")] public static extern void SetAwake(b2Body* body, bool v);
		[LinkName("b2Body_IsAwake")] public static extern bool IsAwake(b2Body* body);

		[LinkName("b2Body_SetEnabled")] public static extern void SetEnabled(b2Body* body, bool v);
		[LinkName("b2Body_IsEnabled")] public static extern bool IsEnabled(b2Body* body);

		[LinkName("b2Body_SetFixedRotation")] public static extern void SetFixedRotation(b2Body* body, bool v);
		[LinkName("b2Body_IsFixedRotation")] public static extern bool IsFixedRotation(b2Body* body);

		[LinkName("b2Body_GetFixtureList")] public static extern b2Fixture* GetFixtureList(b2Body* body);
		[LinkName("b2Body_GetJointList")] public static extern b2JointEdge* GetJointList(b2Body* body);
		[LinkName("b2Body_GetContactList")] public static extern b2ContactEdge* GetContactList(b2Body* body);

		[LinkName("b2Body_SetUserData")] public static extern void SetUserData(b2Body* body, void* v);
		[LinkName("b2Body_GetUserData")] public static extern void* GetUserData(b2Body* body);

		[LinkName("b2Body_GetWorld")] public static extern b2World* GetWorld(b2Body* body);
	}
}
