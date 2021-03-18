using System;

namespace Box2D
{
	enum b2StretchingModel : int32
	{
		b2_pbdStretchingModel,
		b2_xpbdStretchingModel
	}

	enum b2BendingModel : int32
	{
		b2_springAngleBendingModel = 0,
		b2_pbdAngleBendingModel,
		b2_xpbdAngleBendingModel,
		b2_pbdDistanceBendingModel,
		b2_pbdHeightBendingModel,
		b2_pbdTriangleBendingModel
	}

	[CRepr]
	struct b2RopeTuning
	{
		public b2StretchingModel stretchingModel = .b2_pbdStretchingModel;
		public b2BendingModel bendingModel = .b2_pbdAngleBendingModel;
		public float damping;
		public float stretchStiffness = 1.0f;
		public float stretchHertz;
		public float stretchDamping;
		public float bendStiffness = 0.5f;
		public float bendHertz = 1.0f;
		public float bendDamping;
		public bool isometric;
		public bool fixedEffectiveMass;
		public bool warmStart;
	}

	[CRepr]
	struct b2RopeDef
	{
		public b2Vec2 position;
		public b2Vec2* vertices;
		public int32 count;
		public float* masses;
		public b2Vec2 gravity;
		public b2RopeTuning tuning;
	}

	static class Rope
	{
		[LinkName("b2Rope_Create")] public static extern b2Rope* Create(ref b2RopeDef def);
		[LinkName("b2Rope_Destroy")] public static extern void Destroy(b2Rope* rope);
		[LinkName("b2Rope_SetTuning")] public static extern void SetTuning(b2Rope* rope, ref b2RopeTuning v);
		[LinkName("b2Rope_Step")] public static extern void Step(b2Rope* rope, float timeStep, int32 iterations, ref b2Vec2 position);
		[LinkName("b2Rope_Reset")] public static extern void Reset(b2Rope* rope, ref b2Vec2 v);
		[LinkName("b2Rope_GetPointCount")] public static extern int32 GetPointCount(b2Rope* rope);
		[LinkName("b2Rope_GetPointPosition")] public static extern b2Vec2 GetPointPosition(b2Rope* rope, int v);
		[LinkName("b2Rope_GetPointInvMass")] public static extern float GetPointInvMass(b2Rope* rope, int v);

	}
}
