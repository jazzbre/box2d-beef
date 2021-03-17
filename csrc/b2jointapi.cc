#include "box2dapi.h"

#define B2JOINT(_ret_, _name_, ...) BOX2DCAPI _ret_ b2Joint##_name_(b2Joint* joint, ##__VA_ARGS__)

#define B2JOINTDER(_ret_, _typename_, _type_, _name_, ...) BOX2DCAPI _ret_ b2Joint##_typename_##_##_name_(_type_* joint, ##__VA_ARGS__)

// Common

B2JOINT(b2JointType, GetType) {
    return joint->GetType();
}

B2JOINT(b2Body*, GetBodyA) {
    return joint->GetBodyA();
}

B2JOINT(b2Body*, GetBodyB) {
    return joint->GetBodyB();
}

B2JOINT(b2Vec2, GetAnchorA) {
    return joint->GetAnchorA();
}

B2JOINT(b2Vec2, GetAnchorB) {
    return joint->GetAnchorB();
}

B2JOINT(b2Vec2, GetReactionForce, float v) {
    return joint->GetReactionForce(v);
}

B2JOINT(float, GetReactionTorque, float v) {
    return joint->GetReactionTorque(v);
}

B2JOINT(void, SetUserData, void* v) {
    joint->GetUserData().pointer = (uintptr_t)v;
}

B2JOINT(void*, GetUserData) {
    return (void*)joint->GetUserData().pointer;
}

B2JOINT(bool, IsEnabled) {
    return joint->IsEnabled();
}

B2JOINT(bool, GetCollideConnected) {
    return joint->GetCollideConnected();
}

// b2RevoluteJoint
B2JOINTDER(b2Vec2, RevoluteJoint, b2RevoluteJoint, GetLocalAnchorA) {
    return joint->GetLocalAnchorA();
}

B2JOINTDER(b2Vec2, RevoluteJoint, b2RevoluteJoint, GetLocalAnchorB) {
    return joint->GetLocalAnchorB();
}

B2JOINTDER(float, RevoluteJoint, b2RevoluteJoint, GetReferenceAngle) {
    return joint->GetReferenceAngle();
}

B2JOINTDER(float, RevoluteJoint, b2RevoluteJoint, GetJointAngle) {
    return joint->GetJointAngle();
}

B2JOINTDER(float, RevoluteJoint, b2RevoluteJoint, GetJointSpeed) {
    return joint->GetJointSpeed();
}

B2JOINTDER(bool, RevoluteJoint, b2RevoluteJoint, IsLimitEnabled) {
    return joint->IsLimitEnabled();
}

B2JOINTDER(void, RevoluteJoint, b2RevoluteJoint, EnableLimit, bool v) {
    joint->EnableLimit(v);
}

B2JOINTDER(float, RevoluteJoint, b2RevoluteJoint, GetLowerLimit) {
    return joint->GetLowerLimit();
}

B2JOINTDER(float, RevoluteJoint, b2RevoluteJoint, GetUpperLimit) {
    return joint->GetUpperLimit();
}

B2JOINTDER(void, RevoluteJoint, b2RevoluteJoint, SetLimits, float l, float u) {
    joint->SetLimits(l, u);
}

B2JOINTDER(bool, RevoluteJoint, b2RevoluteJoint, IsMotorEnabled) {
    return joint->IsMotorEnabled();
}

B2JOINTDER(void, RevoluteJoint, b2RevoluteJoint, EnableMotor, bool v) {
    joint->EnableMotor(v);
}

B2JOINTDER(void, RevoluteJoint, b2RevoluteJoint, SetMotorSpeed, float v) {
    joint->SetMotorSpeed(v);
}

B2JOINTDER(float, RevoluteJoint, b2RevoluteJoint, GetMotorSpeed) {
    return joint->GetMotorSpeed();
}

B2JOINTDER(void, RevoluteJoint, b2RevoluteJoint, SetMaxMotorTorque, float v) {
    joint->SetMaxMotorTorque(v);
}

B2JOINTDER(float, RevoluteJoint, b2RevoluteJoint, GetMaxMotorTorque) {
    return joint->GetMaxMotorTorque();
}

B2JOINTDER(b2Vec2, RevoluteJoint, b2RevoluteJoint, GetReactionForce, float v) {
    return joint->GetReactionForce(v);
}

B2JOINTDER(float, RevoluteJoint, b2RevoluteJoint, GetReactionTorque, float v) {
    return joint->GetReactionTorque(v);
}

B2JOINTDER(float, RevoluteJoint, b2RevoluteJoint, GetMotorTorque, float v) {
    return joint->GetMotorTorque(v);
}

// b2PrismaticJoint
B2JOINTDER(b2Vec2, PrismaticJoint, b2PrismaticJoint, GetReactionForce, float v) {
    return joint->GetReactionForce(v);
}

B2JOINTDER(float, PrismaticJoint, b2PrismaticJoint, GetReactionTorque, float v) {
    return joint->GetReactionTorque(v);
}

B2JOINTDER(b2Vec2, PrismaticJoint, b2PrismaticJoint, GetLocalAnchorA) {
    return joint->GetLocalAnchorA();
}

B2JOINTDER(b2Vec2, PrismaticJoint, b2PrismaticJoint, GetLocalAnchorB) {
    return joint->GetLocalAnchorB();
}

B2JOINTDER(b2Vec2, PrismaticJoint, b2PrismaticJoint, GetLocalAxisA) {
    return joint->GetLocalAxisA();
}

B2JOINTDER(float, PrismaticJoint, b2PrismaticJoint, GetReferenceAngle) {
    return joint->GetReferenceAngle();
}

B2JOINTDER(float, PrismaticJoint, b2PrismaticJoint, GetJointTranslation) {
    return joint->GetJointTranslation();
}

B2JOINTDER(float, PrismaticJoint, b2PrismaticJoint, GetJointSpeed) {
    return joint->GetJointSpeed();
}

B2JOINTDER(bool, PrismaticJoint, b2PrismaticJoint, IsLimitEnabled) {
    return joint->IsLimitEnabled();
}

B2JOINTDER(void, PrismaticJoint, b2PrismaticJoint, EnableLimit, bool v) {
    joint->EnableLimit(v);
}

B2JOINTDER(float, PrismaticJoint, b2PrismaticJoint, GetLowerLimit) {
    return joint->GetLowerLimit();
}

B2JOINTDER(float, PrismaticJoint, b2PrismaticJoint, GetUpperLimit) {
    return joint->GetUpperLimit();
}

B2JOINTDER(void, PrismaticJoint, b2PrismaticJoint, SetLimits, float l, float u) {
    joint->SetLimits(l, u);
}

B2JOINTDER(bool, PrismaticJoint, b2PrismaticJoint, IsMotorEnabled) {
    return joint->IsMotorEnabled();
}

B2JOINTDER(void, PrismaticJoint, b2PrismaticJoint, EnableMotor, bool v) {
    joint->EnableMotor(v);
}

B2JOINTDER(void, PrismaticJoint, b2PrismaticJoint, SetMotorSpeed, float v) {
    joint->SetMotorSpeed(v);
}

B2JOINTDER(float, PrismaticJoint, b2PrismaticJoint, GetMotorSpeed) {
    return joint->GetMotorSpeed();
}

B2JOINTDER(void, PrismaticJoint, b2PrismaticJoint, SetMaxMotorForce, float v) {
    joint->SetMaxMotorForce(v);
}

B2JOINTDER(float, PrismaticJoint, b2PrismaticJoint, GetMaxMotorForce) {
    return joint->GetMaxMotorForce();
}

B2JOINTDER(float, PrismaticJoint, b2PrismaticJoint, GetMotorForce, float v) {
    return joint->GetMotorForce(v);
}

// b2DistanceJoint
B2JOINTDER(b2Vec2, DistanceJoint, b2DistanceJoint, GetReactionForce, float v) {
    return joint->GetReactionForce(v);
}

B2JOINTDER(float, DistanceJoint, b2DistanceJoint, GetReactionTorque, float v) {
    return joint->GetReactionTorque(v);
}

B2JOINTDER(b2Vec2, DistanceJoint, b2DistanceJoint, GetLocalAnchorA) {
    return joint->GetLocalAnchorA();
}

B2JOINTDER(b2Vec2, DistanceJoint, b2DistanceJoint, GetLocalAnchorB) {
    return joint->GetLocalAnchorB();
}

B2JOINTDER(float, DistanceJoint, b2DistanceJoint, GetLength) {
    return joint->GetLength();
}

B2JOINTDER(float, DistanceJoint, b2DistanceJoint, SetLength, float v) {
    return joint->SetLength(v);
}

B2JOINTDER(float, DistanceJoint, b2DistanceJoint, GetMinLength) {
    return joint->GetMinLength();
}

B2JOINTDER(float, DistanceJoint, b2DistanceJoint, SetMinLength, float v) {
    return joint->SetMinLength(v);
}

B2JOINTDER(float, DistanceJoint, b2DistanceJoint, GetMaxLength) {
    return joint->GetMaxLength();
}

B2JOINTDER(float, DistanceJoint, b2DistanceJoint, SetMaxLength, float v) {
    return joint->SetMaxLength(v);
}

B2JOINTDER(float, DistanceJoint, b2DistanceJoint, GetCurrentLength) {
    return joint->GetCurrentLength();
}

B2JOINTDER(void, DistanceJoint, b2DistanceJoint, SetStiffness, float v) {
    joint->SetStiffness(v);
}

B2JOINTDER(float, DistanceJoint, b2DistanceJoint, GetStiffness) {
    return joint->GetStiffness();
}

B2JOINTDER(void, DistanceJoint, b2DistanceJoint, SetDamping, float v) {
    joint->SetDamping(v);
}

B2JOINTDER(float, DistanceJoint, b2DistanceJoint, GetDamping) {
    return joint->GetDamping();
}

// b2PulleyJoint
B2JOINTDER(b2Vec2, PulleyJoint, b2PulleyJoint, GetReactionForce, float v) {
    return joint->GetReactionForce(v);
}

B2JOINTDER(float, PulleyJoint, b2PulleyJoint, GetReactionTorque, float v) {
    return joint->GetReactionTorque(v);
}

B2JOINTDER(b2Vec2, PulleyJoint, b2PulleyJoint, GetGroundAnchorA) {
    return joint->GetGroundAnchorA();
}

B2JOINTDER(b2Vec2, PulleyJoint, b2PulleyJoint, GetGroundAnchorB) {
    return joint->GetGroundAnchorB();
}

B2JOINTDER(float, PulleyJoint, b2PulleyJoint, GetLengthA) {
    return joint->GetLengthA();
}

B2JOINTDER(float, PulleyJoint, b2PulleyJoint, GetLengthB) {
    return joint->GetLengthB();
}

B2JOINTDER(float, PulleyJoint, b2PulleyJoint, GetRatio) {
    return joint->GetRatio();
}

B2JOINTDER(float, PulleyJoint, b2PulleyJoint, GetCurrentLengthA) {
    return joint->GetCurrentLengthA();
}

B2JOINTDER(float, PulleyJoint, b2PulleyJoint, GetCurrentLengthB) {
    return joint->GetCurrentLengthB();
}

// b2MouseJoint
B2JOINTDER(b2Vec2, MouseJoint, b2MouseJoint, GetReactionForce, float v) {
    return joint->GetReactionForce(v);
}

B2JOINTDER(float, MouseJoint, b2MouseJoint, GetReactionTorque, float v) {
    return joint->GetReactionTorque(v);
}

B2JOINTDER(void, MouseJoint, b2MouseJoint, SetTarget, const b2Vec2& v) {
    joint->SetTarget(v);
}

B2JOINTDER(b2Vec2, MouseJoint, b2MouseJoint, GetTarget) {
    return joint->GetTarget();
}

B2JOINTDER(void, MouseJoint, b2MouseJoint, SetMaxForce, float v) {
    joint->SetMaxForce(v);
}

B2JOINTDER(float, MouseJoint, b2MouseJoint, GetMaxForce) {
    return joint->GetMaxForce();
}

B2JOINTDER(void, MouseJoint, b2MouseJoint, SetStiffness, float v) {
    joint->SetStiffness(v);
}

B2JOINTDER(float, MouseJoint, b2MouseJoint, GetStiffness) {
    return joint->GetStiffness();
}

B2JOINTDER(void, MouseJoint, b2MouseJoint, SetDamping, float v) {
    joint->SetDamping(v);
}

B2JOINTDER(float, MouseJoint, b2MouseJoint, GetDamping) {
    return joint->GetDamping();
}

// b2GearJoint
B2JOINTDER(b2Vec2, GearJoint, b2GearJoint, GetReactionForce, float v) {
    return joint->GetReactionForce(v);
}

B2JOINTDER(float, GearJoint, b2GearJoint, GetReactionTorque, float v) {
    return joint->GetReactionTorque(v);
}

B2JOINTDER(b2Joint*, GearJoint, b2GearJoint, GetJoint1) {
    return joint->GetJoint1();
}

B2JOINTDER(b2Joint*, GearJoint, b2GearJoint, GetJoint2) {
    return joint->GetJoint2();
}

B2JOINTDER(void, GearJoint, b2GearJoint, SetRatio, float v) {
    joint->SetRatio(v);
}

B2JOINTDER(float, GearJoint, b2GearJoint, GetRatio) {
    return joint->GetRatio();
}

// b2PrismaticJoint
B2JOINTDER(b2Vec2, WheelJoint, b2WheelJoint, GetReactionForce, float v) {
    return joint->GetReactionForce(v);
}

B2JOINTDER(float, WheelJoint, b2WheelJoint, GetReactionTorque, float v) {
    return joint->GetReactionTorque(v);
}

B2JOINTDER(b2Vec2, WheelJoint, b2WheelJoint, GetLocalAnchorA) {
    return joint->GetLocalAnchorA();
}

B2JOINTDER(b2Vec2, WheelJoint, b2WheelJoint, GetLocalAnchorB) {
    return joint->GetLocalAnchorB();
}

B2JOINTDER(b2Vec2, WheelJoint, b2WheelJoint, GetLocalAxisA) {
    return joint->GetLocalAxisA();
}

B2JOINTDER(float, WheelJoint, b2WheelJoint, GetJointTranslation) {
    return joint->GetJointTranslation();
}

B2JOINTDER(float, WheelJoint, b2WheelJoint, GetJointLinearSpeed) {
    return joint->GetJointLinearSpeed();
}

B2JOINTDER(float, WheelJoint, b2WheelJoint, GetJointAngularSpeed) {
    return joint->GetJointAngularSpeed();
}

B2JOINTDER(float, WheelJoint, b2WheelJoint, GetJointAngle) {
    return joint->GetJointAngle();
}

B2JOINTDER(bool, WheelJoint, b2WheelJoint, IsLimitEnabled) {
    return joint->IsLimitEnabled();
}

B2JOINTDER(void, WheelJoint, b2WheelJoint, EnableLimit, bool v) {
    joint->EnableLimit(v);
}

B2JOINTDER(float, WheelJoint, b2WheelJoint, GetLowerLimit) {
    return joint->GetLowerLimit();
}

B2JOINTDER(float, WheelJoint, b2WheelJoint, GetUpperLimit) {
    return joint->GetUpperLimit();
}

B2JOINTDER(void, WheelJoint, b2WheelJoint, SetLimits, float l, float u) {
    joint->SetLimits(l, u);
}

B2JOINTDER(bool, WheelJoint, b2WheelJoint, IsMotorEnabled) {
    return joint->IsMotorEnabled();
}

B2JOINTDER(void, WheelJoint, b2WheelJoint, EnableMotor, bool v) {
    joint->EnableMotor(v);
}

B2JOINTDER(void, WheelJoint, b2WheelJoint, SetMotorSpeed, float v) {
    joint->SetMotorSpeed(v);
}

B2JOINTDER(float, WheelJoint, b2WheelJoint, GetMotorSpeed) {
    return joint->GetMotorSpeed();
}

B2JOINTDER(void, WheelJoint, b2WheelJoint, SetMaxMotorTorque, float v) {
    joint->SetMaxMotorTorque(v);
}

B2JOINTDER(float, WheelJoint, b2WheelJoint, GetMaxMotorTorque) {
    return joint->GetMaxMotorTorque();
}

B2JOINTDER(float, WheelJoint, b2WheelJoint, GetMotorTorque, float v) {
    return joint->GetMotorTorque(v);
}

B2JOINTDER(void, WheelJoint, b2WheelJoint, SetStiffness, float v) {
    joint->SetStiffness(v);
}

B2JOINTDER(float, WheelJoint, b2WheelJoint, GetStiffness) {
    return joint->GetStiffness();
}

B2JOINTDER(void, WheelJoint, b2WheelJoint, SetDamping, float v) {
    joint->SetDamping(v);
}

B2JOINTDER(float, WheelJoint, b2WheelJoint, GetDamping) {
    return joint->GetDamping();
}

// b2WeldJoint
B2JOINTDER(b2Vec2, WeldJoint, b2WeldJoint, GetReactionForce, float v) {
    return joint->GetReactionForce(v);
}

B2JOINTDER(float, WeldJoint, b2WeldJoint, GetReactionTorque, float v) {
    return joint->GetReactionTorque(v);
}

B2JOINTDER(b2Vec2, WeldJoint, b2WeldJoint, GetLocalAnchorA) {
    return joint->GetLocalAnchorA();
}

B2JOINTDER(b2Vec2, WeldJoint, b2WeldJoint, GetLocalAnchorB) {
    return joint->GetLocalAnchorB();
}

B2JOINTDER(float, WeldJoint, b2WeldJoint, GetReferenceAngle) {
    return joint->GetReferenceAngle();
}

B2JOINTDER(void, WeldJoint, b2WeldJoint, SetStiffness, float v) {
    joint->SetStiffness(v);
}

B2JOINTDER(float, WeldJoint, b2WeldJoint, GetStiffness) {
    return joint->GetStiffness();
}

B2JOINTDER(void, WeldJoint, b2WeldJoint, SetDamping, float v) {
    joint->SetDamping(v);
}

B2JOINTDER(float, WeldJoint, b2WeldJoint, GetDamping) {
    return joint->GetDamping();
}

// b2FrictionJoint
B2JOINTDER(b2Vec2, FrictionJoint, b2FrictionJoint, GetReactionForce, float v) {
    return joint->GetReactionForce(v);
}

B2JOINTDER(float, FrictionJoint, b2FrictionJoint, GetReactionTorque, float v) {
    return joint->GetReactionTorque(v);
}

B2JOINTDER(b2Vec2, FrictionJoint, b2FrictionJoint, GetLocalAnchorA) {
    return joint->GetLocalAnchorA();
}

B2JOINTDER(b2Vec2, FrictionJoint, b2FrictionJoint, GetLocalAnchorB) {
    return joint->GetLocalAnchorB();
}

B2JOINTDER(void, FrictionJoint, b2FrictionJoint, SetMaxForce, float v) {
    joint->SetMaxForce(v);
}

B2JOINTDER(float, FrictionJoint, b2FrictionJoint, GetMaxForce) {
    return joint->GetMaxForce();
}

B2JOINTDER(void, FrictionJoint, b2FrictionJoint, SetMaxTorque, float v) {
    joint->SetMaxTorque(v);
}

B2JOINTDER(float, FrictionJoint, b2FrictionJoint, GetMaxTorque) {
    return joint->GetMaxTorque();
}

// b2MotorJoint
B2JOINTDER(b2Vec2, MotorJoint, b2MotorJoint, GetReactionForce, float v) {
    return joint->GetReactionForce(v);
}

B2JOINTDER(float, MotorJoint, b2MotorJoint, GetReactionTorque, float v) {
    return joint->GetReactionTorque(v);
}

B2JOINTDER(void, MotorJoint, b2MotorJoint, SetLinearOffset, const b2Vec2& v) {
    joint->SetLinearOffset(v);
}

B2JOINTDER(b2Vec2, MotorJoint, b2MotorJoint, GetLinearOffset) {
    return joint->GetLinearOffset();
}

B2JOINTDER(void, MotorJoint, b2MotorJoint, SetAngularOffset, float v) {
    joint->SetAngularOffset(v);
}

B2JOINTDER(float, MotorJoint, b2MotorJoint, GetAngularOffset) {
    return joint->GetAngularOffset();
}

B2JOINTDER(void, MotorJoint, b2MotorJoint, SetMaxForce, float v) {
    joint->SetMaxForce(v);
}

B2JOINTDER(float, MotorJoint, b2MotorJoint, GetMaxForce) {
    return joint->GetMaxForce();
}

B2JOINTDER(void, MotorJoint, b2MotorJoint, SetMaxTorque, float v) {
    joint->SetMaxTorque(v);
}

B2JOINTDER(float, MotorJoint, b2MotorJoint, GetMaxTorque) {
    return joint->GetMaxTorque();
}

B2JOINTDER(void, MotorJoint, b2MotorJoint, SetCorrectionFactor, float v) {
    joint->SetCorrectionFactor(v);
}

B2JOINTDER(float, MotorJoint, b2MotorJoint, GetCorrectionFactor) {
    return joint->GetCorrectionFactor();
}
