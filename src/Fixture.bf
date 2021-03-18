using System;

namespace Box2D
{
	[CRepr]
	struct b2FixtureDef
	{
		/// The shape, this must be set. The shape will be cloned, so you
		/// can create the shape on the stack.
		public b2Shape* shape;

		/// Use this to store application specific fixture data.
		public b2FixtureUserData userData;

		/// The friction coefficient, usually in the range [0,1].
		public float friction = 0.2f;

		/// The restitution (elasticity) usually in the range [0,1].
		public float restitution;

		/// Restitution velocity threshold, usually in m/s. Collisions above this
		/// speed have restitution applied (will bounce).
		public float restitutionThreshold = 1.0f;

		/// The density, usually in kg/m^2.
		public float density;

		/// A sensor shape collects contact information but never generates a collision
		/// response.
		public bool isSensor;

		/// Contact filtering data.
		public b2Filter filter = .();
	}

	static class Fixture
	{
		[LinkName("b2Fixture_GetFixtureType")] public static extern b2ShapeType GetFixtureType(b2Fixture* fixture);
		[LinkName("b2Fixture_GetShape")] public static extern b2Shape* GetShape(b2Fixture* fixture);

		[LinkName("b2Fixture_SetSensor")] public static extern void SetSensor(b2Fixture* fixture, bool v);
		[LinkName("b2Fixture_IsSensor")] public static extern bool IsSensor(b2Fixture* fixture);

		[LinkName("b2Fixture_SetFilterData")] public static extern void SetFilterData(b2Fixture* fixture, ref b2Filter v);
		[LinkName("b2Fixture_GetFilterData")] public static extern b2Filter GetFilterData(b2Fixture* fixture);
		[LinkName("b2Fixture_Refilter")] public static extern void Refilter(b2Fixture* fixture);

		[LinkName("b2Fixture_GetBody")] public static extern b2Body* GetBody(b2Fixture* fixture);

		[LinkName("b2Fixture_SetUserData")] public static extern void SetUserData(b2Fixture* fixture, void* v);
		[LinkName("b2Fixture_GetUserData")] public static extern void* GetUserData(b2Fixture* fixture);

		[LinkName("b2Fixture_TestPoint")] public static extern bool TestPoint(b2Fixture* fixture, ref b2Vec2 v);
		[LinkName("b2Fixture_ComputeDistance")] public static extern void ComputeDistance(b2Fixture* fixture, ref b2Vec2 p, float* distance, b2Vec2* normal, int32 childIndex);
		[LinkName("b2Fixture_RayCast")] public static extern bool RayCast(b2Fixture* fixture, b2RayCastOutput* output, b2RayCastInput input, int32 childIndex);

		[LinkName("b2Fixture_GetMassData")] public static extern void GetMassData(b2Fixture* fixture, b2MassData* v);

		[LinkName("b2Fixture_SetDensity")] public static extern void SetDensity(b2Fixture* fixture, float v);
		[LinkName("b2Fixture_GetDensity")] public static extern float GetDensity(b2Fixture* fixture);

		[LinkName("b2Fixture_GetFriction")] public static extern float GetFriction(b2Fixture* fixture);
		[LinkName("b2Fixture_SetFriction")] public static extern void SetFriction(b2Fixture* fixture, float v);

		[LinkName("b2Fixture_GetRestitution")] public static extern float GetRestitution(b2Fixture* fixture);
		[LinkName("b2Fixture_SetRestitution")] public static extern void SetRestitution(b2Fixture* fixture, float v);

		[LinkName("b2Fixture_GetRestitutionThreshold")] public static extern float GetRestitutionThreshold(b2Fixture* fixture);
		[LinkName("b2Fixture_SetRestitutionThreshold")] public static extern void SetRestitutionThreshold(b2Fixture* fixture, float v);

		[LinkName("b2Fixture_GetAABB")] public static extern b2AABB GetAABB(b2Fixture* fixture, int32 childIndex);
	}
}
