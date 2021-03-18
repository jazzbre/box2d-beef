#include "box2dapi.h"

#define B2SHAPE(_ret_, _name_, ...) BOX2DCAPI _ret_ b2Shape_##_name_(b2Shape* shape, ##__VA_ARGS__)

#define B2SHAPE_DER(_ret_, _typename_, _type_, _name_, ...) BOX2DCAPI _ret_ b2Shape##_typename_##_##_name_(_type_* shape, ##__VA_ARGS__)

BOX2DCAPI b2Shape* b2Shape_CreateCircle() {
    return new b2CircleShape();
}

BOX2DCAPI b2Shape* b2Shape_CreateEdge() {
    return new b2EdgeShape();
}

BOX2DCAPI b2Shape* b2Shape_CreatePolygon() {
    return new b2PolygonShape();
}

BOX2DCAPI b2Shape* b2Shape_CreateChain() {
    return new b2ChainShape();
}

BOX2DCAPI void b2Shape_Destroy(b2Shape* shape) {
    delete shape;
}

B2SHAPE(void, SetRadius, float v) {
    shape->m_radius = v;
}

B2SHAPE(float, GetRadius) {
    return shape->m_radius;
}

B2SHAPE(b2Shape::Type, GetShapeType) {
    return shape->GetType();
}

B2SHAPE(int32, GetChildCount) {
    return shape->GetChildCount();
}

B2SHAPE(bool, TestPoint, const b2Transform& xf, const b2Vec2& p) {
    return shape->TestPoint(xf, p);
}

B2SHAPE(void, ComputeDistance, const b2Transform& xf, const b2Vec2& p, float* distance, b2Vec2* normal, int32 childIndex) {
    shape->ComputeDistance(xf, p, distance, normal, childIndex);
}

B2SHAPE(bool, RayCast, b2RayCastOutput* output, const b2RayCastInput& input, const b2Transform& transform, int32 childIndex) {
    return shape->RayCast(output, input, transform, childIndex);
}

B2SHAPE(void, ComputeAABB, b2AABB* aabb, const b2Transform& xf, int32 childIndex) {
    shape->ComputeAABB(aabb, xf, childIndex);
}

B2SHAPE(void, ComputeMass, b2MassData* massData, float density) {
    shape->ComputeMass(massData, density);
}

// b2CircleShape
B2SHAPE_DER(void, Circle, b2CircleShape, SetPosition, const b2Vec2& p) {
    shape->m_p = p;
}

// b2EdgeShape
B2SHAPE_DER(void, Edge, b2EdgeShape, SetOneSided, const b2Vec2& v0, const b2Vec2& v1, const b2Vec2& v2, const b2Vec2& v3) {
    shape->SetOneSided(v0, v1, v2, v3);
}

B2SHAPE_DER(void, Edge, b2EdgeShape, SetTwoSided, const b2Vec2& v1, const b2Vec2& v2) {
    shape->SetTwoSided(v1, v2);
}

// b2PolygonShape
B2SHAPE_DER(void, Polygon, b2PolygonShape, Set, const b2Vec2* points, int32 count) {
    shape->Set(points, count);
}

B2SHAPE_DER(void, Polygon, b2PolygonShape, SetAsBox, float hx, float hy) {
    shape->SetAsBox(hx, hy);
}

B2SHAPE_DER(void, Polygon, b2PolygonShape, SetAsBoxWithCenterAngle, float hx, float hy, const b2Vec2& center, float angle) {
    shape->SetAsBox(hx, hy, center, angle);
}

// b2ChainShape
B2SHAPE_DER(void, Chain, b2ChainShape, Clear) {
    shape->Clear();
}

B2SHAPE_DER(void, Chain, b2ChainShape, CreateLoop, const b2Vec2* vertices, int32 count) {
    shape->CreateLoop(vertices, count);
}

B2SHAPE_DER(void, Chain, b2ChainShape, CreateChain, const b2Vec2* vertices, int32 count, const b2Vec2& prevVertex, const b2Vec2& nextVertex) {
    shape->CreateChain(vertices, count, prevVertex, nextVertex);
}
