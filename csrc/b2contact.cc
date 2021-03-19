#include "box2dapi.h"
#include "box2d/b2_rope.h"

#define B2CONTACT(_ret_, _name_, ...) BOX2DCAPI _ret_ b2Contact_##_name_(b2Contact* contact, ##__VA_ARGS__)

B2CONTACT(b2Manifold*, GetManifold) {
    return contact->GetManifold();
}

B2CONTACT(void, GetWorldManifold, b2WorldManifold* worldManifold) {
    contact->GetWorldManifold(worldManifold);
}
B2CONTACT(bool, IsTouching) {
    return contact->IsTouching();
}

B2CONTACT(void, SetEnabled, bool flag) {
    contact->SetEnabled(flag);
}

B2CONTACT(bool, IsEnabled) {
    return contact->IsEnabled();
}

B2CONTACT(b2Fixture*, GetFixtureA) {
    return contact->GetFixtureA();
}

B2CONTACT(int32, GetChildIndexA) {
    return contact->GetChildIndexA();
}

B2CONTACT(b2Fixture*, GetFixtureB) {
    return contact->GetFixtureB();
}

B2CONTACT(int32, GetChildIndexB) {
    return contact->GetChildIndexB();
}

B2CONTACT(void, SetFriction, float friction) {
    contact->SetFriction(friction);
}

B2CONTACT(float, GetFriction) {
    return contact->GetFriction();
}

B2CONTACT(void, ResetFriction) {
    contact->ResetFriction();
}

B2CONTACT(void, SetRestitution, float restitution) {
    contact->SetRestitution(restitution);
}

B2CONTACT(float, GetRestitution) {
    return contact->GetRestitution();
}

B2CONTACT(void, ResetRestitution) {
    contact->ResetRestitution();
}

B2CONTACT(void, SetRestitutionThreshold, float threshold) {
    contact->SetRestitutionThreshold(threshold);
}

B2CONTACT(float, GetRestitutionThreshold) {
    return contact->GetRestitutionThreshold();
}

B2CONTACT(void, ResetRestitutionThreshold) {
    contact->ResetRestitutionThreshold();
}

B2CONTACT(void, SetTangentSpeed, float speed) {
    contact->SetTangentSpeed(speed);
}

B2CONTACT(float, GetTangentSpeed) {
    return contact->GetTangentSpeed();
}
