using System;

namespace Box2D
{
	/// The features that intersect to form the contact point
	/// This must be 4 bytes or less.
	[CRepr]
	struct b2ContactFeature
	{
		public enum Type
		{
			e_vertex = 0,
			e_face = 1
		};

		public uint8 indexA;///< Feature index on shapeA
		public uint8 indexB;///< Feature index on shapeB
		public uint8 typeA;///< The feature type on shapeA
		public uint8 typeB;///< The feature type on shapeB
	}

	/// Contact ids to facilitate warm starting.
	[CRepr, Union]
	struct b2ContactID
	{
		public b2ContactFeature cf;
		public uint32 key;///< Used to quickly compare contact ids.
	}

	/// A manifold point is a contact point belonging to a contact
	/// manifold. It holds details related to the geometry and dynamics
	/// of the contact points.
	/// The local point usage depends on the manifold type:
	/// -e_circles: the local center of circleB
	/// -e_faceA: the local center of cirlceB or the clip point of polygonB
	/// -e_faceB: the clip point of polygonA
	/// This structure is stored across time steps, so we keep it small.
	/// Note: the impulses are used for internal caching and may not
	/// provide reliable contact forces, especially for high speed collisions.
	[CRepr]
	struct b2ManifoldPoint
	{
		public b2Vec2 localPoint;///< usage depends on manifold type
		public float normalImpulse;///< the non-penetration impulse
		public float tangentImpulse;///< the friction impulse
		public b2ContactID id;///< uniquely identifies a contact point between two shapes
	}

	/// A manifold for two touching convex shapes.
	/// Box2D supports multiple types of contact:
	/// - clip point versus plane with radius
	/// - point versus point with radius (circles)
	/// The local point usage depends on the manifold type:
	/// -e_circles: the local center of circleA
	/// -e_faceA: the center of faceA
	/// -e_faceB: the center of faceB
	/// Similarly the local normal usage:
	/// -e_circles: not used
	/// -e_faceA: the normal on polygonA
	/// -e_faceB: the normal on polygonB
	/// We store contacts in this way so that position correction can
	/// account for movement, which is critical for continuous physics.
	/// All contact scenarios must be expressed in one of these types.
	/// This structure is stored across time steps, so we keep it small.
	[CRepr]
	struct b2Manifold
	{
		public enum Type
		{
			e_circles,
			e_faceA,
			e_faceB
		};

		public b2ManifoldPoint[Constants.b2_maxManifoldPoints] points;///< the points of contact
		public b2Vec2 localNormal;///< not use for Type::e_points
		public b2Vec2 localPoint;///< usage depends on manifold type
		public Type type;
		public int32 pointCount;///< the number of manifold points
	}

	/// This is used to compute the current state of a contact manifold.
	[CRepr]
	struct b2WorldManifold
	{
		public b2Vec2 normal;///< world vector pointing from A to B
		public b2Vec2 points;///< world contact point (point of intersection)
		public float separations;///< a negative value indicates overlap, in meters
	}

	/// This is used for determining the state of contact points.
	enum b2PointState
	{
		b2_nullState,///< point does not exist
		b2_addState,///< point was added in the update
		b2_persistState,///< point persisted across the update
		b2_removeState///< point was removed in the update
	}

	/// Used
	// for computing contact manifolds.
	[CRepr]
	struct b2ClipVertex
	{
		public b2Vec2 v;
		public b2ContactID id;
	}

	/// Ray-cast input data. The ray extends from p1 to p1 + maxFraction * (p2 - p1).
	[CRepr]
	struct b2RayCastInput
	{
		public b2Vec2 p1, p2;
		public float maxFraction;
	}

	/// Ray-cast output data. The ray hits at p1 + fraction * (p2 - p1), where p1 and p2
	/// come from b2RayCastInput.
	[CRepr]
	struct b2RayCastOutput
	{
		public b2Vec2 normal;
		public float fraction;
	}

	static class Collision
	{
		/// Evaluate the manifold with supplied transforms. This assumes
		/// modest motion from the original state. This does not change the
		/// point count, impulses, etc. The radii must come from the shapes
		/// that generated the manifold.
		[LinkName("b2WorldManifold_Initialize")] public static extern void InitializeWorldManifold(b2WorldManifold* worldManiforld, b2Manifold* manifold, ref b2Transform xfA, float radiusA, ref b2Transform xfB, float radiusB);

		/// Compute the point states given two manifolds. The states pertain to the transition from manifold1
		/// to manifold2. So state1 is either persist or remove while state2 is either add or persist.
		[LinkName("b2Collision_GetPointStates")] public static extern void GetPointStates(b2PointState* state1, b2PointState* state2, b2Manifold* manifold1, b2Manifold* manifold2);

		/// Compute the collision manifold between two circles.
		[LinkName("b2Collision_GetPointStates")] public static extern void CollideCircles(b2Manifold* manifold, b2Shape* circleA, ref b2Transform xfA, b2Shape* circleB, ref b2Transform xfB);

		/// Compute the collision manifold between a polygon and a circle.
		[LinkName("b2Collision_GetPointStates")] public static extern void CollidePolygonAndCircle(b2Manifold* manifold, b2Shape* polygonA, ref b2Transform xfA, b2Shape* circleB, ref b2Transform xfB);

		/// Compute the collision manifold between two polygons.
		[LinkName("b2Collision_GetPointStates")] public static extern void CollidePolygons(b2Manifold* manifold, b2Shape* polygonA, ref b2Transform xfA, b2Shape* polygonB, ref b2Transform xfB);

		/// Compute the collision manifold between an edge and a circle.
		[LinkName("b2Collision_GetPointStates")] public static extern void CollideEdgeAndCircle(b2Manifold* manifold, b2Shape* polygonA, ref b2Transform xfA, b2Shape* circleB, ref b2Transform xfB);

		/// Compute the collision manifold between an edge and a polygon.
		[LinkName("b2Collision_GetPointStates")] public static extern void CollideEdgeAndPolygon(b2Manifold* manifold, b2Shape* edgeA, ref b2Transform xfA, b2Shape* circleB, ref b2Transform xfB);

		/// Clipping for contact manifolds.
		[LinkName("b2Collision_GetPointStates")] public static extern int32 ClipSegmentToLine(b2ClipVertex* vOut, b2ClipVertex* vIn, ref b2Vec2 normal, float offset, int32 vertexIndexA);

		/// Determine if two generic shapes overlap.
		[LinkName("b2Collision_GetPointStates")] public static extern bool TestOverlap(b2Shape* shapeA, int32 indexA, b2Shape* shapeB, int32 indexB, ref b2Transform xfA, ref b2Transform xfB);

	}
}
