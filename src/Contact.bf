using System;

namespace Box2D
{
	static class Contact
	{
		[LinkName("b2Contact_GetManifold")] public static extern b2Manifold* GetManifold(b2Contact* contact);
		[LinkName("b2Contact_GetWorldManifold")] public static extern void GetWorldManifold(b2Contact* contact, b2WorldManifold* worldManifold);
		[LinkName("b2Contact_IsTouching")] public static extern bool IsTouching(b2Contact* contact);
		[LinkName("b2Contact_SetEnabled")] public static extern void SetEnabled(b2Contact* contact, bool flag);
		[LinkName("b2Contact_IsEnabled")] public static extern bool IsEnabled(b2Contact* contact);
		[LinkName("b2Contact_GetFixtureA")] public static extern b2Fixture* GetFixtureA(b2Contact* contact);
		[LinkName("b2Contact_GetChildIndexA")] public static extern int32 GetChildIndexA(b2Contact* contact);
		[LinkName("b2Contact_GetFixtureB")] public static extern b2Fixture* GetFixtureB(b2Contact* contact);
		[LinkName("b2Contact_GetChildIndexB")] public static extern int32 GetChildIndexB(b2Contact* contact);
		[LinkName("b2Contact_SetFriction")] public static extern void SetFriction(b2Contact* contact, float friction);
		[LinkName("b2Contact_GetFriction")] public static extern float GetFriction(b2Contact* contact);
		[LinkName("b2Contact_ResetFriction")] public static extern void ResetFriction(b2Contact* contact);
		[LinkName("b2Contact_SetRestitution")] public static extern void SetRestitution(b2Contact* contact, float restitution);
		[LinkName("b2Contact_GetRestitution")] public static extern float GetRestitution(b2Contact* contact);
		[LinkName("b2Contact_ResetRestitution")] public static extern void ResetRestitution(b2Contact* contact);
		[LinkName("b2Contact_SetRestitutionThreshold")] public static extern void SetRestitutionThreshold(b2Contact* contact, float threshold);
		[LinkName("b2Contact_GetRestitutionThreshold")] public static extern float GetRestitutionThreshold(b2Contact* contact);
		[LinkName("b2Contact_ResetRestitutionThreshold")] public static extern void ResetRestitutionThreshold(b2Contact* contact);
		[LinkName("b2Contact_SetTangentSpeed")] public static extern void SetTangentSpeed(b2Contact* contact, float speed);
		[LinkName("b2Contact_GetTangentSpeed")] public static extern float GetTangentSpeed(b2Contact* contact);
	}
}
