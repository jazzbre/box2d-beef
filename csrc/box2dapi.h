#pragma once
#include <box2d/box2d.h>

// Macros
#define BOX2DCAPI extern "C"

#define CALLBACKNORET(_func_, ...)                                                                                                                                                                     \
    if (callbacks._func_) {                                                                                                                                                                            \
        callbacks._func_(__VA_ARGS__, callbacks.userData);                                                                                                                                             \
    }

#define CALLBACKRET(_default_ret_, _func_, ...)                                                                                                                                                        \
    if (callbacks._func_) {                                                                                                                                                                            \
        return callbacks._func_(__VA_ARGS__, callbacks.userData);                                                                                                                                      \
    }                                                                                                                                                                                                  \
    return _default_ret_;

#define RETURNPOD(_type_, _func_)                                                                                                                                                                      \
    auto ret_value = _func_;                                                                                                                                                                           \
    _type_ ret_c_value = (const _type_&)ret_value;                                                                                                                                                     \
    return ret_c_value;

// b2Vec2_C
struct b2Vec2_C {
    float x, y;
};

// b2Rot_C
struct b2Rot_C {
    float s, c;
};

// b2Transform_C
struct b2Transform_C {
    b2Vec2_C p;
    b2Rot_C q;
};

// b2Filter_C
struct b2Filter_C {
    uint16 categoryBits;
    uint16 maskBits;
    int16 groupIndex;
};

// b2QueryCallbackWrapper
class b2QueryCallbackWrapper : public b2QueryCallback {
public:
    using ReportFixtureCallback = bool (*)(b2Fixture* fixture, void* userData);
    using ReportParticleCallback = bool (*)(const b2ParticleSystem* particleSystem, int32 index, void* userData);
    using ShouldQueryParticleSystemCallback = bool (*)(const b2ParticleSystem* particleSystem, void* userData);

    struct Callbacks {
        ReportFixtureCallback reportFixtureCallback;
        ReportParticleCallback reportParticleCallback;
        ShouldQueryParticleSystemCallback shouldQueryParticleSystemCallback;
        void* userData;
    };

    b2QueryCallbackWrapper(Callbacks& _callbacks)
        : callbacks(_callbacks) {
    }

    bool ReportFixture(b2Fixture* fixture) final {
        CALLBACKRET(false, reportFixtureCallback, fixture);
    }

    bool ReportParticle(const b2ParticleSystem* particleSystem, int32 index) final {
        CALLBACKRET(false, reportParticleCallback, particleSystem, index);
    }

    bool ShouldQueryParticleSystem(const b2ParticleSystem* particleSystem) final {
        CALLBACKRET(false, shouldQueryParticleSystemCallback, particleSystem);
    }

    Callbacks& callbacks;
};

// b2RayCastCallbackWrapper
class b2RayCastCallbackWrapper : public b2RayCastCallback {
public:
    using ReportFixtureCallback = float (*)(b2Fixture* fixture, const b2Vec2& point, const b2Vec2& normal, float fraction, void* userData);
    using ReportParticleCallback = float (*)(const b2ParticleSystem* particleSystem, int32 index, const b2Vec2& point, const b2Vec2& normal, float fraction, void* userData);
    using ShouldQueryParticleSystemCallback = bool (*)(const b2ParticleSystem* particleSystem, void* userData);

    struct Callbacks {
        ReportFixtureCallback reportFixtureCallback;
        ReportParticleCallback reportParticleCallback;
        ShouldQueryParticleSystemCallback shouldQueryParticleSystemCallback;
        void* userData;
    };

    b2RayCastCallbackWrapper(Callbacks& _callbacks)
        : callbacks(_callbacks) {
    }

    float ReportFixture(b2Fixture* fixture, const b2Vec2& point, const b2Vec2& normal, float fraction) final {
        CALLBACKRET(0.0f, reportFixtureCallback, fixture, point, normal, fraction);
    }

    float ReportParticle(const b2ParticleSystem* particleSystem, int32 index, const b2Vec2& point, const b2Vec2& normal, float fraction) final {
        CALLBACKRET(0.0f, reportParticleCallback, particleSystem, index, point, normal, fraction);
    }

    bool ShouldQueryParticleSystem(const b2ParticleSystem* particleSystem) final {
        CALLBACKRET(true, shouldQueryParticleSystemCallback, particleSystem);
    }

    Callbacks& callbacks;
};
