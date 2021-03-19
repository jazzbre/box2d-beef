#include "box2dapi.h"

BOX2DCAPI void b2WorldManifold_Initialize(b2WorldManifold* worldManiforld, const b2Manifold* manifold, const b2Transform& xfA, float radiusA, const b2Transform& xfB, float radiusB) {
    worldManiforld->Initialize(manifold, xfA, radiusA, xfB, radiusB);
}

BOX2DCAPI void b2Collision_GetPointStates(b2PointState* state1, b2PointState* state2, const b2Manifold* manifold1, const b2Manifold* manifold2) {
    b2GetPointStates(state1, state2, manifold1, manifold2);
}

BOX2DCAPI void b2Collision_CollideCircles(b2Manifold* manifold, const b2CircleShape* circleA, const b2Transform& xfA, const b2CircleShape* circleB, const b2Transform& xfB) {
    b2CollideCircles(manifold, circleA, xfA, circleB, xfB);
}

BOX2DCAPI void b2Collision_CollidePolygonAndCircle(b2Manifold* manifold, const b2PolygonShape* polygonA, const b2Transform& xfA, const b2CircleShape* circleB, const b2Transform& xfB) {
    b2CollidePolygonAndCircle(manifold, polygonA, xfA, circleB, xfB);
}

BOX2DCAPI void b2Collision_CollidePolygons(b2Manifold* manifold, const b2PolygonShape* polygonA, const b2Transform& xfA, const b2PolygonShape* polygonB, const b2Transform& xfB) {
    b2CollidePolygons(manifold, polygonA, xfA, polygonB, xfB);
}

BOX2DCAPI void b2Collision_CollideEdgeAndCircle(b2Manifold* manifold, const b2EdgeShape* polygonA, const b2Transform& xfA, const b2CircleShape* circleB, const b2Transform& xfB) {
    b2CollideEdgeAndCircle(manifold, polygonA, xfA, circleB, xfB);
}

BOX2DCAPI void b2Collision_CollideEdgeAndPolygon(b2Manifold* manifold, const b2EdgeShape* edgeA, const b2Transform& xfA, const b2PolygonShape* circleB, const b2Transform& xfB) {
    b2CollideEdgeAndPolygon(manifold, edgeA, xfA, circleB, xfB);
}

BOX2DCAPI int32 b2Collision_ClipSegmentToLine(b2ClipVertex* vOut, const b2ClipVertex* vIn, const b2Vec2& normal, float offset, int32 vertexIndexA) {
    return b2ClipSegmentToLine(vOut, vIn, normal, offset, vertexIndexA);
}

BOX2DCAPI bool b2Collision_TestOverlap(const b2Shape* shapeA, int32 indexA, const b2Shape* shapeB, int32 indexB, const b2Transform& xfA, const b2Transform& xfB) {
    return b2TestOverlap(shapeA, indexA, shapeB, indexB, xfA, xfB);
}
