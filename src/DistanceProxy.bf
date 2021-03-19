using System;

namespace Box2D
{
	[CRepr]
	struct b2DistanceProxy
	{
		public b2Vec2[2] m_buffer;
		public b2Vec2* m_vertices;
		public int32 m_count;
		public float m_radius;
	}

	static class DistanceProxy
	{
		[LinkName("b2DistanceProxy_Set")] public static extern void Set(b2DistanceProxy* distanceProxy, b2Shape* shape, int32 index);
		[LinkName("b2DistanceProxy_SetVertices")] public static extern void SetVertices(b2DistanceProxy* distanceProxy, b2Vec2* vertices, int32 count, float radius);
		[LinkName("b2DistanceProxy_GetSupport")] public static extern int32 GetSupport(b2DistanceProxy* distanceProxy, ref b2Vec2 d);
		[LinkName("b2DistanceProxy_GetSupportVertex")] public static extern b2Vec2 GetSupportVertex(b2DistanceProxy* distanceProxy, ref b2Vec2 d);
		[LinkName("b2DistanceProxy_GetVertexCount")] public static extern int32 GetVertexCount(b2DistanceProxy* distanceProxy);
		[LinkName("b2DistanceProxy_GetVertex")] public static extern b2Vec2 GetVertex(b2DistanceProxy* distanceProxy, int32 index);
	}
}
