#include "box2dapi.h"

BOX2DCAPI void b2Utility_LinearStiffness(float& stiffness, float& damping, float frequencyHertz, float dampingRatio, const b2Body* bodyA, const b2Body* bodyB) {
    b2LinearStiffness(stiffness, damping, frequencyHertz, dampingRatio, bodyA, bodyB);
}

BOX2DCAPI void b2Utility_AngularStiffness(float& stiffness, float& damping, float frequencyHertz, float dampingRatio, const b2Body* bodyA, const b2Body* bodyB) {
    b2AngularStiffness(stiffness, damping, frequencyHertz, dampingRatio, bodyA, bodyB);
}
