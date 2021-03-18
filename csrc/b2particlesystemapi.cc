#include "box2dapi.h"

#define B2PARTICLESYSTEM(_ret_, _name_, ...) BOX2DCAPI _ret_ b2ParticleSystem_##_name_(b2ParticleSystem* particleSystem, ##__VA_ARGS__)

B2PARTICLESYSTEM(int32, CreateParticle, b2ParticleDef* def) {
    return particleSystem->CreateParticle(*def);
}

B2PARTICLESYSTEM(void, DestroyParticle, int32 index, bool callDestructionListener) {
    particleSystem->DestroyParticle(index, callDestructionListener);
}

B2PARTICLESYSTEM(void, DestroyOldestParticle, int32 index, bool callDestructionListener) {
    particleSystem->DestroyOldestParticle(index, callDestructionListener);
}

B2PARTICLESYSTEM(void, DestroyParticlesInShape, const b2Shape* shape, const b2Transform& xf, bool callDestructionListener) {
    particleSystem->DestroyParticlesInShape(*shape, xf, callDestructionListener);
}

B2PARTICLESYSTEM(b2ParticleGroup*, CreateParticleGroup, b2ParticleGroupDef* def) {
    return particleSystem->CreateParticleGroup(*def);
}

B2PARTICLESYSTEM(void, JoinParticleGroups, b2ParticleGroup* groupA, b2ParticleGroup* groupB) {
    particleSystem->JoinParticleGroups(groupA, groupB);
}

B2PARTICLESYSTEM(void, SplitParticleGroup, b2ParticleGroup* group) {
    particleSystem->SplitParticleGroup(group);
}

B2PARTICLESYSTEM(int32, GetParticleGroupCount) {
    return particleSystem->GetParticleGroupCount();
}

B2PARTICLESYSTEM(int32, GetParticleCount) {
    return particleSystem->GetParticleCount();
}

B2PARTICLESYSTEM(int32, GetMaxParticleCount) {
    return particleSystem->GetMaxParticleCount();
}

B2PARTICLESYSTEM(void, SetMaxParticleCount, int32 v) {
    particleSystem->SetMaxParticleCount(v);
}

B2PARTICLESYSTEM(uint32, GetAllParticleFlags) {
    return particleSystem->GetAllParticleFlags();
}

B2PARTICLESYSTEM(uint32, GetAllGroupFlags) {
    return particleSystem->GetAllGroupFlags();
}

B2PARTICLESYSTEM(void, SetPaused, bool v) {
    particleSystem->SetPaused(v);
}

B2PARTICLESYSTEM(bool, GetPaused) {
    return particleSystem->GetPaused();
}

B2PARTICLESYSTEM(void, SetDensity, float v) {
    particleSystem->SetDensity(v);
}

B2PARTICLESYSTEM(float, GetDensity) {
    return particleSystem->GetDensity();
}

B2PARTICLESYSTEM(void, SetGravityScale, float v) {
    particleSystem->SetGravityScale(v);
}

B2PARTICLESYSTEM(float, GetGravityScale) {
    return particleSystem->GetGravityScale();
}

B2PARTICLESYSTEM(void, SetDamping, float v) {
    particleSystem->SetDamping(v);
}

B2PARTICLESYSTEM(float, GetDamping) {
    return particleSystem->GetDamping();
}

B2PARTICLESYSTEM(void, SetStaticPressureIterations, int32 v) {
    particleSystem->SetStaticPressureIterations(v);
}

B2PARTICLESYSTEM(int32, GetStaticPressureIterations) {
    return particleSystem->GetStaticPressureIterations();
}

B2PARTICLESYSTEM(void, SetRadius, float v) {
    particleSystem->SetRadius(v);
}

B2PARTICLESYSTEM(float, GetRadius) {
    return particleSystem->GetRadius();
}

B2PARTICLESYSTEM(b2Vec2*, GetPositionBuffer) {
    return particleSystem->GetPositionBuffer();
}

B2PARTICLESYSTEM(b2Vec2*, GetVelocityBuffer) {
    return particleSystem->GetVelocityBuffer();
}

B2PARTICLESYSTEM(b2ParticleColor*, GetColorBuffer) {
    return particleSystem->GetColorBuffer();
}

B2PARTICLESYSTEM(float*, GetWeightBuffer) {
    return particleSystem->GetWeightBuffer();
}

B2PARTICLESYSTEM(void**, GetUserDataBuffer) {
    return particleSystem->GetUserDataBuffer();
}

B2PARTICLESYSTEM(const uint32*, GetFlagsBuffer) {
    return particleSystem->GetFlagsBuffer();
}

B2PARTICLESYSTEM(void, SetParticleFlags, int32 index, uint32 v) {
    particleSystem->SetParticleFlags(index, v);
}

B2PARTICLESYSTEM(uint32, GetParticleFlags, int32 index) {
    return particleSystem->GetParticleFlags(index);
}

B2PARTICLESYSTEM(void, SetStuckThreshold, int32 v) {
    particleSystem->SetStuckThreshold(v);
}

B2PARTICLESYSTEM(float, ComputeCollisionEnergy) {
    return particleSystem->ComputeCollisionEnergy();
}

B2PARTICLESYSTEM(void, SetStrictContactCheck, bool v) {
    particleSystem->SetStrictContactCheck(v);
}

B2PARTICLESYSTEM(bool, GetStrictContactCheck) {
    return particleSystem->GetStrictContactCheck();
}

B2PARTICLESYSTEM(void, SetParticleLifetime, int32 index, float v) {
    particleSystem->SetParticleLifetime(index, v);
}

B2PARTICLESYSTEM(float, GetParticleLifetime, int32 index) {
    return particleSystem->GetParticleLifetime(index);
}

B2PARTICLESYSTEM(void, SetDestructionByAge, bool v) {
    particleSystem->SetDestructionByAge(v);
}

B2PARTICLESYSTEM(bool, GetDestructionByAge) {
    return particleSystem->GetDestructionByAge();
}

B2PARTICLESYSTEM(const int32*, GetExpirationTimeBuffer) {
    return particleSystem->GetExpirationTimeBuffer();
}

B2PARTICLESYSTEM(float, ExpirationTimeToLifetime, int32 v) {
    return particleSystem->ExpirationTimeToLifetime(v);
}

B2PARTICLESYSTEM(void, ParticleApplyLinearImpulse, int32 index, const b2Vec2& impulse) {
    particleSystem->ParticleApplyLinearImpulse(index, impulse);
}

B2PARTICLESYSTEM(void, ApplyLinearImpulse, int32 firstIndex, int32 lastIndex, const b2Vec2& impulse) {
    particleSystem->ApplyLinearImpulse(firstIndex, lastIndex, impulse);
}

B2PARTICLESYSTEM(void, ParticleApplyForce, int32 index, const b2Vec2& force) {
    particleSystem->ParticleApplyForce(index, force);
}

B2PARTICLESYSTEM(void, ApplyForce, int32 firstIndex, int32 lastIndex, const b2Vec2& force) {
    particleSystem->ApplyForce(firstIndex, lastIndex, force);
}

B2PARTICLESYSTEM(void, QueryAABB, b2QueryCallbackWrapper::Callbacks* callbacks, const b2AABB& aabb) {
    b2QueryCallbackWrapper callback(*callbacks);
    particleSystem->QueryAABB(&callback, aabb);
}

B2PARTICLESYSTEM(void, RayCast, b2RayCastCallbackWrapper::Callbacks* callbacks, const b2Vec2& point1, const b2Vec2& point2) {
    b2RayCastCallbackWrapper callback(*callbacks);
    particleSystem->RayCast(&callback, point1, point2);
}

B2PARTICLESYSTEM(void, ComputeAABB, b2AABB* const aabb) {
    particleSystem->ComputeAABB(aabb);
}
