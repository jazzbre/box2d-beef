using System;

namespace Box2D
{
	static class Utility
	{
		/// Friction mixing law. The idea is to allow either fixture to drive the friction to zero.
		/// For example, anything slides on ice.
		public static float b2MixFriction(float friction1, float friction2)
		{
			return Math.Sqrt(friction1 * friction2);
		}

		/// Restitution mixing law. The idea is allow for anything to bounce off an inelastic surface.
		/// For example, a superball bounces on anything.
		public static float MixRestitution(float restitution1, float restitution2)
		{
			return restitution1 > restitution2 ? restitution1 : restitution2;
		}

		/// Restitution mixing law. This picks the lowest value.
		public static float MixRestitutionThreshold(float threshold1, float threshold2)
		{
			return threshold1 < threshold2 ? threshold1 : threshold2;
		}

		[LinkName("b2Utility_LinearStiffness")] public static extern void LinearStiffness(ref float stiffness, ref float damping, float frequencyHertz, float dampingRatio, b2Body* bodyA, b2Body* bodyB);
		[LinkName("b2Utility_AngularStiffness")] public static extern void AngularStiffness(ref float stiffness, ref float damping, float frequencyHertz, float dampingRatio, b2Body* bodyA, b2Body* bodyB);
	}
}
