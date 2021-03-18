using System;

namespace Box2D
{
	enum b2ShapeType
	{
		e_circle = 0,
		e_edge = 1,
		e_polygon = 2,
		e_chain = 3,
		e_typeCount = 4
	}

	static class Shape
	{
		[LinkName("b2Shape_CreateCircle")] public static extern b2Shape* CreateCircle();
		[LinkName("b2Shape_CreateEdge")] public static extern b2Shape* CreateEdge();
		[LinkName("b2Shape_CreatePolygon")] public static extern b2Shape* CreatePolygon();
		[LinkName("b2Shape_CreateChain")] public static extern b2Shape* CreateChain();

		[LinkName("b2Shape_Destroy")] public static extern void Destroy(b2Shape* shape);

		[LinkName("b2Shape_SetRadius")] public static extern void SetRadius(b2Shape* shape, float v);
		[LinkName("b2Shape_GetRadius")] public static extern float GetRadius(b2Shape* shape);

		[LinkName("b2Shape_GetShapeType")] public static extern b2ShapeType GetShapeType(b2Shape* shape);

		[LinkName("b2Shape_GetChildCount")] public static extern int32 GetChildCount(b2Shape* shape);

		[LinkName("b2Shape_TestPoint")] public static extern bool TestPoint(b2Shape* shape, ref b2Transform xf, ref b2Vec2 p);

		[LinkName("b2Shape_ComputeDistance")] public static extern void ComputeDistance(b2Shape* shape, ref b2Transform xf, ref b2Vec2 p, float* distance, b2Vec2* normal, int32 childIndex);

		[LinkName("b2Shape_RayCast")] public static extern bool RayCast(b2Shape* shape, b2RayCastOutput* output, ref b2RayCastInput input, ref b2Transform transform, int32 childIndex);

		[LinkName("b2Shape_ComputeAABB")] public static extern void ComputeAABB(b2Shape* shape, b2AABB* aabb, ref b2Transform xf, int32 childIndex);
		[LinkName("b2Shape_ComputeMass")] public static extern void ComputeMass(b2Shape* shape, b2MassData* massData, float density);

		[LinkName("b2ShapeCircle_SetPosition")] public static extern void CircleSetPosition(b2Shape* shape, ref b2Vec2 p);

		[LinkName("b2ShapeEdge_SetOneSided")] public static extern void EdgeSetOneSided(b2Shape* shape, ref b2Vec2 v0, ref b2Vec2 v1, ref b2Vec2 v2, ref b2Vec2 v3);
		[LinkName("b2ShapeEdge_SetTwoSided")] public static extern void EdgeSetTwoSided(b2Shape* shape, ref b2Vec2 v1, ref b2Vec2 v2);

		[LinkName("b2ShapePolygon_Set")] public static extern void PolygonSet(b2Shape* shape, b2Vec2* points, int32 count);
		[LinkName("b2ShapePolygon_SetAsBox")] public static extern void PolygonSetAsBox(b2Shape* shape, float hx, float hy);
		[LinkName("b2ShapePolygon_SetAsBoxWithCenterAngle")] public static extern void PolygonSetAsBoxWithCenterAngle(b2Shape* shape, float hx, float hy, ref b2Vec2 center, float angle);

		[LinkName("b2ShapeChain_Clear")] public static extern void ChainClear(b2Shape* shape);
		[LinkName("b2ShapeChain_CreateLoop")] public static extern void ChainCreateLoop(b2Shape* shape, b2Vec2* vertices, int32 count);
		[LinkName("b2ShapeChain_CreateChain")] public static extern void ChainCreateChain(b2Shape* shape, b2Vec2* vertices, int32 count, ref b2Vec2 prevVertex, ref b2Vec2 nextVertex);
	}
}
