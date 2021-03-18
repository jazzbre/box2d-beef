#include "box2dapi.h"

#define B2BODY(_ret_, _name_, ...) BOX2DCAPI _ret_ b2Body_##_name_(b2Body* body, ##__VA_ARGS__)

B2BODY(b2Fixture*, CreateFixture, b2FixtureDef* def) {
    return body->CreateFixture(def);
}

B2BODY(b2Fixture*, CreateFixtureWithShapeDensity, const b2Shape* shape, float density) {
    return body->CreateFixture(shape, density);
}

B2BODY(void, DestroyFixture, b2Fixture* fixture) {
    return body->DestroyFixture(fixture);
}

B2BODY(void, SetTransform, const b2Vec2& position, float angle) {
    body->SetTransform(position, angle);
}
B2BODY(b2Transform_C, GetPreviousTransform) {
    RETURNPOD(b2Transform_C, body->GetPreviousTransform());
}

B2BODY(b2Transform_C, GetTransform) {
    RETURNPOD(b2Transform_C, body->GetTransform());
}

B2BODY(b2Vec2_C, GetPosition) {
    RETURNPOD(b2Vec2_C, body->GetPosition());
}

B2BODY(float, GetAngle) {
    return body->GetAngle();
}

B2BODY(b2Vec2_C, GetWorldCenter) {
    RETURNPOD(b2Vec2_C, body->GetWorldCenter());
}

B2BODY(b2Vec2_C, GetLocalCenter) {
    RETURNPOD(b2Vec2_C, body->GetLocalCenter());
}

B2BODY(void, SetLinearVelocity, const b2Vec2& v) {
    body->SetLinearVelocity(v);
}

B2BODY(b2Vec2_C, GetLinearVelocity) {
    RETURNPOD(b2Vec2_C, body->GetLinearVelocity());
}

B2BODY(void, SetAngularVelocity, float omega) {
    body->SetAngularVelocity(omega);
}

B2BODY(float, GetAngularVelocity) {
    return body->GetAngularVelocity();
}

B2BODY(void, ApplyForce, const b2Vec2& force, const b2Vec2& point, bool wake) {
    body->ApplyForce(force, point, wake);
}

B2BODY(void, ApplyForceToCenter, const b2Vec2& force, bool wake) {
    body->ApplyForceToCenter(force, wake);
}

B2BODY(void, ApplyTorque, float torque, bool wake) {
    body->ApplyTorque(torque, wake);
}

B2BODY(void, ApplyLinearImpulse, const b2Vec2& impulse, const b2Vec2& point, bool wake) {
    body->ApplyLinearImpulse(impulse, point, wake);
}

B2BODY(void, ApplyLinearImpulseToCenter, const b2Vec2& impulse, bool wake) {
    body->ApplyLinearImpulseToCenter(impulse, wake);
}

B2BODY(void, ApplyAngularImpulse, float impulse, bool wake) {
    body->ApplyAngularImpulse(impulse, wake);
}

B2BODY(float, GetMass) {
    return body->GetMass();
}

B2BODY(float, GetInertia) {
    return body->GetInertia();
}

B2BODY(b2MassData, GetMassData) {
    b2MassData data;
    body->GetMassData(&data);
    return data;
}

B2BODY(void, SetMassData, const b2MassData& data) {
    body->SetMassData(&data);
}

B2BODY(void, ResetMassData) {
    body->ResetMassData();
}

B2BODY(b2Vec2_C, GetWorldPoint, const b2Vec2& v) {
    RETURNPOD(b2Vec2_C, body->GetWorldPoint(v));
}

B2BODY(b2Vec2_C, GetWorldVector, const b2Vec2& v) {
    RETURNPOD(b2Vec2_C, body->GetWorldVector(v));
}

B2BODY(b2Vec2_C, GetLocalPoint, const b2Vec2& v) {
    RETURNPOD(b2Vec2_C, body->GetLocalPoint(v));
}

B2BODY(b2Vec2_C, GetLocalVector, const b2Vec2& v) {
    RETURNPOD(b2Vec2_C, body->GetLocalVector(v));
}

B2BODY(b2Vec2_C, GetLinearVelocityFromWorldPoint, const b2Vec2& v) {
    RETURNPOD(b2Vec2_C, body->GetLinearVelocityFromWorldPoint(v));
}

B2BODY(b2Vec2_C, GetLinearVelocityFromLocalPoint, const b2Vec2& v) {
    RETURNPOD(b2Vec2_C, body->GetLinearVelocityFromLocalPoint(v));
}

B2BODY(float, GetLinearDamping) {
    return body->GetLinearDamping();
}

B2BODY(void, SetLinearDamping, float v) {
    body->SetLinearDamping(v);
}

B2BODY(float, GetAngularDamping) {
    return body->GetAngularDamping();
}

B2BODY(void, SetAngularDamping, float v) {
    body->SetAngularDamping(v);
}

B2BODY(float, GetGravityScale) {
    return body->GetGravityScale();
}

B2BODY(void, SetGravityScale, float v) {
    body->SetGravityScale(v);
}

B2BODY(void, SetBodyType, b2BodyType v) {
    body->SetType(v);
}

B2BODY(b2BodyType, GetBodyType) {
    return body->GetType();
}

B2BODY(void, SetBullet, bool v) {
    body->SetBullet(v);
}

B2BODY(bool, IsBullet) {
    return body->IsBullet();
}

B2BODY(void, SetSleepingAllowed, bool v) {
    body->SetSleepingAllowed(v);
}

B2BODY(bool, IsSleepingAllowed) {
    return body->IsSleepingAllowed();
}

B2BODY(void, SetAwake, bool v) {
    body->SetAwake(v);
}

B2BODY(bool, IsAwake) {
    return body->IsAwake();
}

B2BODY(void, SetEnabled, bool v) {
    body->SetEnabled(v);
}

B2BODY(bool, IsEnabled) {
    return body->IsEnabled();
}

B2BODY(void, SetFixedRotation, bool v) {
    body->SetFixedRotation(v);
}

B2BODY(bool, IsFixedRotation) {
    return body->IsFixedRotation();
}

B2BODY(b2Fixture*, GetFixtureList) {
    return body->GetFixtureList();
}

B2BODY(b2JointEdge*, GetJointList) {
    return body->GetJointList();
}

B2BODY(b2ContactEdge*, GetContactList) {
    return body->GetContactList();
}

B2BODY(void, SetUserData, void* v) {
    body->GetUserData().pointer = (uintptr_t)v;
}

B2BODY(void*, GetUserData) {
    return (void*)body->GetUserData().pointer;
}

B2BODY(b2World*, GetWorld) {
    return body->GetWorld();
}
