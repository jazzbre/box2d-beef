using System;

namespace Box2D
{
	/// Input parameters for b2TimeOfImpact
	[CRepr]
	struct b2TOIInput
	{
		public b2DistanceProxy proxyA;
		public b2DistanceProxy proxyB;
		public b2Sweep sweepA;
		public b2Sweep sweepB;
		public float tMax;// defines sweep interval [0, tMax]
	}

	/// Output parameters for b2TimeOfImpact.
	[CRepr]
	struct b2TOIOutput
	{
		public enum State
		{
			e_unknown,
			e_failed,
			e_overlapped,
			e_touching,
			e_separated
		};

		public State state;
		public float t;
	}

	static class TimeOfImpact
	{
		[LinkName("b2TimeOfImpact_TimeOfImpact")] public static extern void Compute(b2TOIOutput* output, b2TOIInput* input);
	}
}
