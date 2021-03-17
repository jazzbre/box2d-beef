#include "box2dapi.h"

#define B2FIXTURE(_ret_, _name_, ...) BOX2DCAPI _ret_ b2Fixture##_name_(b2Fixture* fixture, ##__VA_ARGS__)

B2FIXTURE(b2Shape::Type, GetType) {
    return fixture->GetType();
}

B2FIXTURE(b2Shape*, GetShape) {
    return fixture->GetShape();
}

B2FIXTURE(void, SetSensor, bool v) {
    fixture->SetSensor(v);
}

B2FIXTURE(bool, IsSensor) {
    return fixture->IsSensor();
}

B2FIXTURE(void, SetFilterData, b2Filter v) {
    fixture->SetFilterData(v);
}

B2FIXTURE(b2Filter, GetFilterData) {
    return fixture->GetFilterData();
}

B2FIXTURE(void, Refilter) {
    fixture->Refilter();
}

B2FIXTURE(b2Body*, GetBody) {
    return fixture->GetBody();
}

B2FIXTURE(void, SetUserData, void* v) {
    fixture->GetUserData().pointer = (uintptr_t)v;
}

B2FIXTURE(void*, GetUserData) {
    return (void*)fixture->GetUserData().pointer;
}

B2FIXTURE(bool, TestPoint, const b2Vec2& v) {
    return fixture->TestPoint(v);
}

B2FIXTURE(void, ComputeDistance, const b2Vec2& p, float* distance, b2Vec2* normal, int32 childIndex) {
    fixture->ComputeDistance(p, distance, normal, childIndex);
}

B2FIXTURE(bool, RayCast, b2RayCastOutput* output, b2RayCastInput input, int32 childIndex) {
    return fixture->RayCast(output, input, childIndex);
}

B2FIXTURE(void, GetMassData, b2MassData* v) {
    fixture->GetMassData(v);
}

B2FIXTURE(void, SetDensity, float v) {
    fixture->SetDensity(v);
}

B2FIXTURE(float, GetDensity) {
    return fixture->GetDensity();
}

B2FIXTURE(float, GetFriction) {
    return fixture->GetFriction();
}

B2FIXTURE(void, SetFriction, float v) {
    fixture->SetFriction(v);
}

B2FIXTURE(float, GetRestitution) {
    return fixture->GetRestitution();
}

B2FIXTURE(void, SetRestitution, float v) {
    fixture->SetRestitution(v);
}

B2FIXTURE(float, GetRestitutionThreshold) {
    return fixture->GetRestitutionThreshold();
}

B2FIXTURE(void, SetRestitutionThreshold, float v) {
    fixture->SetRestitutionThreshold(v);
}

B2FIXTURE(b2AABB, GetAABB, int32 childIndex) {
    return fixture->GetAABB(childIndex);
}
