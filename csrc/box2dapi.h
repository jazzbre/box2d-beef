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

    b2QueryCallbackWrapper(Callbacks _callbacks)
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

    Callbacks callbacks;
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

    b2RayCastCallbackWrapper(Callbacks _callbacks)
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

    Callbacks callbacks;
};
