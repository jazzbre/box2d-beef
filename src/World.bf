using System;

namespace Box2D
{
	[CRepr]
	struct b2DestructionListener
	{
		public typealias JointSayGoodbyeCallback = function void(b2Joint* joint, void* userData);
		public typealias FixtureSayGoodbyeCallback = function void(b2Fixture* fixture, void* userData);
		public typealias ParticleGroupSayGoodbyeCallback = function void(b2ParticleGroup* group, void* userData);
		public typealias ParticleSystemSayGoodbyeCallback = function void(b2ParticleSystem* particleSystem, int32 index, void* userData);

		public JointSayGoodbyeCallback jointSayGoodbyeCallback;
		public FixtureSayGoodbyeCallback fixterSayGoodbyeCallback;
		public ParticleGroupSayGoodbyeCallback particleGroupSayGoodbyeCallback;
		public ParticleSystemSayGoodbyeCallback particleSystemSayGoodbyeCallback;
	}

	[CRepr]
	struct b2ContactFilter
	{
		public typealias ShouldCollideFixtureFixtureCallback = function bool(b2Fixture* fixtureA, b2Fixture* fixtureB, void* userData);
		public typealias ShouldCollideFixtureParticleSystemCallback = function bool(b2Fixture* fixture, b2ParticleSystem* particleSystem, int32 particleIndex, void* userData);
		public typealias ShouldCollideParticleParticleCallback = function bool(b2ParticleSystem* particleSystem, int32 particleIndexA, int32 particleIndexB, void* userData);

		public ShouldCollideFixtureFixtureCallback shouldCollideFixtureFixtureCallback;
		public ShouldCollideFixtureParticleSystemCallback shouldCollideFixtureParticleSystemCallback;
		public ShouldCollideParticleParticleCallback shouldCollideParticleParticleCallback;
		public void* userData;
	}

	[CRepr]
	struct b2ContactListener
	{
		public typealias BeginContactCallback = function void(b2Contact* contact, void* userData);
		public typealias EndContactCallback = function void(b2Contact* contact, void* userData);
		public typealias BeginContactParticleSystemBodyCallback = function void(b2ParticleSystem* particleSystem, b2ParticleBodyContact* particleBodyContact, void* userData);
		public typealias EndContactParticleSystemBodyCallback = function void(b2Fixture* fixture, b2ParticleSystem* particleSystem, int32 index, void* userData);
		public typealias BeginContactParticleSystemCallback = function void(b2ParticleSystem* particleSystem, b2ParticleContact* particleContact, void* userData);
		public typealias EndContactParticleSystemCallback = function void(b2ParticleSystem* particleSystem, int32 indexA, int32 indexB, void* userData);
		public typealias PreSolveCallback = function void(b2Contact* contact, b2Manifold* oldManifold, void* userData);
		public typealias PostSolveCallback = function void(b2Contact* contact, b2ContactImpulse* impulse, void* userData);

		public BeginContactCallback beginContactCallback;
		public EndContactCallback endContactCallback;
		public BeginContactParticleSystemBodyCallback beginContactParticleSystemBodyCallback;
		public EndContactParticleSystemBodyCallback endContactParticleSystemBodyCallback;
		public BeginContactParticleSystemCallback beginContactParticleSystemCallback;
		public EndContactParticleSystemCallback endContactParticleSystemCallback;
		public PreSolveCallback preSolveCallback;
		public PostSolveCallback postSolveCallback;
		public void* userData;
	}

	[CRepr]
	struct b2Draw
	{
		public typealias DrawPolygonCallback = function void(b2Vec2* vertices, int32 vertexCount, ref b2Color color, void* userData);
		public typealias DrawSolidPolygonCallback = function void(b2Vec2* vertices, int32 vertexCount, ref b2Color color, void* userData);
		public typealias DrawCircleCallback = function void(ref b2Vec2 center, float radius, ref b2Color color, void* userData);
		public typealias DrawSolidCircleCallback = function void(ref b2Vec2 center, float radius, ref b2Vec2 axis, ref b2Color color, void* userData);
		public typealias DrawSegmentCallback = function void(ref b2Vec2 p1, ref b2Vec2 p2, ref b2Color color, void* userData);
		public typealias DrawTransformCallback = function void(ref b2Transform xf, void* userData);
		public typealias DrawPointCallback = function void(ref b2Vec2 p, float size, ref b2Color color, void* userData);

		public DrawPolygonCallback drawPolygonCallback;
		public DrawSolidPolygonCallback drawSolidPolygonCallback;
		public DrawCircleCallback drawCircleCallback;
		public DrawSolidCircleCallback drawSolidCircleCallback;
		public DrawSegmentCallback drawSegmentCallback;
		public DrawTransformCallback drawTransformCallback;
		public DrawPointCallback drawPointCallback;
		public void* userData;
	}


	[CRepr]
	struct b2QueryCallback
	{
		public typealias ReportFixtureCallback = function bool(b2Fixture* fixture, void* userData);
		public typealias ReportParticleCallback = function bool(b2ParticleSystem* particleSystem, int32 index, void* userData);
		public typealias ShouldQueryParticleSystemCallback = function bool(b2ParticleSystem* particleSystem, void* userData);

		public ReportFixtureCallback reportFixtureCallback;
		public ReportParticleCallback reportParticleCallback;
		public ShouldQueryParticleSystemCallback shouldQueryParticleSystemCallback;
		public void* userData;
	}

	[CRepr]
	struct b2RayCastCallback
	{
		public typealias ReportFixtureCallback = function float(b2Fixture* fixture, ref b2Vec2 point, ref b2Vec2 normal, float fraction, void* userData);
		public typealias ReportParticleCallback = function float(b2ParticleSystem* particleSystem, int32 index, ref b2Vec2 point, ref b2Vec2 normal, float fraction, void* userData);
		public typealias ShouldQueryParticleSystemCallback = function bool(b2ParticleSystem* particleSystem, void* userData);

		public ReportFixtureCallback reportFixtureCallback;
		public ReportParticleCallback reportParticleCallback;
		public ShouldQueryParticleSystemCallback shouldQueryParticleSystemCallback;
		public void* userData;
	}

	static class World
	{
		[LinkName("b2World_Create")] public static extern b2World* Create(ref b2Vec2 gravity);
		[LinkName("b2World_Delete")] public static extern void Delete(b2World* world);

		[LinkName("b2World_SetDestructionListenerCallbacks")] public static extern void SetDestructionListenerCallbacks(b2World* world, b2DestructionListener* callbacks);
		[LinkName("b2World_SetContactFilter")] public static extern void SetContactFilter(b2World* world, b2ContactFilter* callbacks);
		[LinkName("b2World_SetContactListener")] public static extern void SetContactListener(b2World* world, b2ContactListener* callbacks);

		[LinkName("b2World_SetDebugDraw")] public static extern void SetDebugDraw(b2World* world, b2Draw* callbacks);
		[LinkName("b2World_SetDebugDrawFlags")] public static extern void SetDebugDrawFlags(b2World* world, b2DrawFlags flags);
		[LinkName("b2World_GetDebugDrawFlags")] public static extern b2DrawFlags GetDebugDrawFlags(b2World* world);

		[LinkName("b2World_CreateBody")] public static extern b2Body* CreateBody(b2World* world, b2BodyDef* def);
		[LinkName("b2World_DestroyBody")] public static extern void DestroyBody(b2World* world, b2Body* body);

		[LinkName("b2World_CreateJoint")] public static extern b2Joint* CreateJoint(b2World* world, b2JointDef* def);
		[LinkName("b2World_DestroyJoint")] public static extern void DestroyJoint(b2World* world, b2Joint* joint);

		[LinkName("b2World_CreateParticleSystem")] public static extern b2ParticleSystem* CreateParticleSystem(b2World* world, b2ParticleSystemDef* def);
		[LinkName("b2World_DestroyParticleSystem")] public static extern void DestroyParticleSystem(b2World* world, b2ParticleSystem* p);

		[LinkName("b2World_Step")] public static extern void Step(b2World* world, float timeStep, int32 velocityIterations, int32 positionIterations, int32 particleIterations);

		[LinkName("b2World_CalculateReasonableParticleIterations")] public static extern int CalculateReasonableParticleIterations(b2World* world, float timeStep);

		[LinkName("b2World_ClearForces")] public static extern void ClearForces(b2World* world);

		[LinkName("b2World_DebugDraw")] public static extern void DebugDraw(b2World* world);

		[LinkName("b2World_QueryAABB")] public static extern void QueryAABB(b2World* world, b2QueryCallback* callbacks, ref b2AABB aabb);
		[LinkName("b2World_RayCast")] public static extern void RayCast(b2World* world, b2RayCastCallback* callbacks, ref b2Vec2 point1, ref b2Vec2 point2);

		[LinkName("b2World_GetBodyList")] public static extern b2Body* GetBodyList(b2World* world);
		[LinkName("b2World_GetJointList")] public static extern b2Joint* GetJointList(b2World* world);
		[LinkName("b2World_GetParticleSystemList")] public static extern b2ParticleSystem* GetParticleSystemList(b2World* world);
		[LinkName("b2World_GetContactList")] public static extern b2Contact* GetContactList(b2World* world);

		[LinkName("b2World_SetAllowSleeping")] public static extern void SetAllowSleeping(b2World* world, bool flag);
		[LinkName("b2World_GetAllowSleeping")] public static extern bool GetAllowSleeping(b2World* world);

		[LinkName("b2World_SetWarmStarting")] public static extern void SetWarmStarting(b2World* world, bool flag);
		[LinkName("b2World_GetWarmStarting")] public static extern bool GetWarmStarting(b2World* world);

		[LinkName("b2World_SetContinuousPhysics")] public static extern void SetContinuousPhysics(b2World* world, bool flag);
		[LinkName("b2World_GetContinuousPhysics")] public static extern bool GetContinuousPhysics(b2World* world);

		[LinkName("b2World_SetSubStepping")] public static extern void SetSubStepping(b2World* world, bool flag);
		[LinkName("b2World_GetSubStepping")] public static extern bool GetSubStepping(b2World* world);

		[LinkName("b2World_GetProxyCount")] public static extern int32 GetProxyCount(b2World* world);
		[LinkName("b2World_GetBodyCount")] public static extern int32 GetBodyCount(b2World* world);
		[LinkName("b2World_GetJointCount")] public static extern int32 GetJointCount(b2World* world);
		[LinkName("b2World_GetContactCount")] public static extern int32 GetContactCount(b2World* world);

		[LinkName("b2World_GetTreeHeight")] public static extern int32 GetTreeHeight(b2World* world);
		[LinkName("b2World_GetTreeBalance")] public static extern int32 GetTreeBalance(b2World* world);
		[LinkName("b2World_GetTreeQuality")] public static extern float GetTreeQuality(b2World* world);

		[LinkName("b2World_SetGravity")] public static extern void SetGravity(b2World* world, ref b2Vec2 gravity);
		[LinkName("b2World_GetGravity")] public static extern b2Vec2 GetGravity(b2World* world);

		[LinkName("b2World_IsLocked")] public static extern bool IsLocked(b2World* world);

		[LinkName("b2World_SetAutoClearForces")] public static extern void SetAutoClearForces(b2World* world, bool flag);
		[LinkName("b2World_GetAutoClearForces")] public static extern bool GetAutoClearForces(b2World* world);

		[LinkName("b2World_ShiftOrigin")] public static extern void ShiftOrigin(b2World* world, ref b2Vec2 newOrigin);

		[LinkName("b2World_LinearStiffness")] public static extern void LinearStiffness(ref float stiffness, ref float damping, float frequencyHertz, float dampingRatio, b2Body* bodyA, b2Body* bodyB);
		[LinkName("b2World_AngularStiffness")] public static extern void AngularStiffness(ref float stiffness, ref float damping, float frequencyHertz, float dampingRatio, b2Body* bodyA, b2Body* bodyB);
	}
}
