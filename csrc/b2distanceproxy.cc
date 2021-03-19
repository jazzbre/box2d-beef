#include "box2dapi.h"
#include "box2d/b2_distance.h"

#define B2DISTANCEPROXY(_ret_, _name_, ...) BOX2DCAPI _ret_ b2DistanceProxy_##_name_(b2DistanceProxy* distanceProxy, ##__VA_ARGS__)

B2DISTANCEPROXY(void, Set, const b2Shape* shape, int32 index) {
    distanceProxy->Set(shape, index);
}

B2DISTANCEPROXY(void, SetVertices, b2Vec2* vertices, int32 count, float radius) {
    distanceProxy->Set(vertices, count, radius);
}

B2DISTANCEPROXY(int32, GetSupport, const b2Vec2& d) {
    return distanceProxy->GetSupport(d);
}

B2DISTANCEPROXY(b2Vec2_C, GetSupportVertex, const b2Vec2& d) {
    RETURNPOD(b2Vec2_C, distanceProxy->GetSupportVertex(d));
}

B2DISTANCEPROXY(int32, GetVertexCount) {
    return distanceProxy->GetVertexCount();
}

B2DISTANCEPROXY(b2Vec2_C, GetVertex, int32 index) {
    RETURNPOD(b2Vec2_C, distanceProxy->GetVertex(index));
}
