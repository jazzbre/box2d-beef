#include "box2dapi.h"

#define B2WORLD(_ret_, _name_, ...) BOX2DCAPI _ret_ b2World_##_name_(b2World* world, ##__VA_ARGS__)

// b2DestructionListenerWrapper
class b2DestructionListenerWrapper : public b2DestructionListener {
public:
    using JointSayGoodbyeCallback = void (*)(b2Joint* joint, void* userData);
    using FixtureSayGoodbyeCallback = void (*)(b2Fixture* fixture, void* userData);
    using ParticleGroupSayGoodbyeCallback = void (*)(b2ParticleGroup* group, void* userData);
    using ParticleSystemSayGoodbyeCallback = void (*)(b2ParticleSystem* particleSystem, int32 index, void* userData);

    struct Callbacks {
        JointSayGoodbyeCallback jointSayGoodbyeCallback = nullptr;
        FixtureSayGoodbyeCallback fixterSayGoodbyeCallback = nullptr;
        ParticleGroupSayGoodbyeCallback particleGroupSayGoodbyeCallback = nullptr;
        ParticleSystemSayGoodbyeCallback particleSystemSayGoodbyeCallback = nullptr;
        void* userData;
    };

    b2DestructionListenerWrapper(Callbacks _callbacks)
        : callbacks(_callbacks) {
    }

    void SayGoodbye(b2Joint* joint) final {
        CALLBACKNORET(jointSayGoodbyeCallback, joint);
    }

    void SayGoodbye(b2Fixture* fixture) final {
        CALLBACKNORET(fixterSayGoodbyeCallback, fixture);
    }

    void SayGoodbye(b2ParticleGroup* group) final {
        CALLBACKNORET(particleGroupSayGoodbyeCallback, group);
    }

    void SayGoodbye(b2ParticleSystem* particleSystem, int32 index) final {
        CALLBACKNORET(particleSystemSayGoodbyeCallback, particleSystem, index);
    }

    Callbacks callbacks;
};

// b2ContactFilterWrapper
class b2ContactFilterWrapper : public b2ContactFilter {
public:
    using ShouldCollideFixtureFixtureCallback = bool (*)(b2Fixture* fixtureA, b2Fixture* fixtureB, void* userData);
    using ShouldCollideFixtureParticleSystemCallback = bool (*)(b2Fixture* fixture, b2ParticleSystem* particleSystem, int32 particleIndex, void* userData);
    using ShouldCollideParticleParticleCallback = bool (*)(b2ParticleSystem* particleSystem, int32 particleIndexA, int32 particleIndexB, void* userData);

    struct Callbacks {
        ShouldCollideFixtureFixtureCallback shouldCollideFixtureFixtureCallback = nullptr;
        ShouldCollideFixtureParticleSystemCallback shouldCollideFixtureParticleSystemCallback = nullptr;
        ShouldCollideParticleParticleCallback shouldCollideParticleParticleCallback = nullptr;
        void* userData;
    };

    b2ContactFilterWrapper(Callbacks _callbacks)
        : callbacks(_callbacks) {
    }

    bool ShouldCollide(b2Fixture* fixtureA, b2Fixture* fixtureB) final {
        CALLBACKRET(true, shouldCollideFixtureFixtureCallback, fixtureA, fixtureB);
    }

    bool ShouldCollide(b2Fixture* fixture, b2ParticleSystem* particleSystem, int32 particleIndex) final {
        CALLBACKRET(true, shouldCollideFixtureParticleSystemCallback, fixture, particleSystem, particleIndex);
    }

    bool ShouldCollide(b2ParticleSystem* particleSystem, int32 particleIndexA, int32 particleIndexB) final {
        CALLBACKRET(true, shouldCollideParticleParticleCallback, particleSystem, particleIndexA, particleIndexB);
    }

    Callbacks callbacks;
};

// b2ContactListenerWrapper
class b2ContactListenerWrapper : public b2ContactListener {
public:
    using BeginContactCallback = void (*)(b2Contact* contact, void* userData);
    using EndContactCallback = void (*)(b2Contact* contact, void* userData);
    using BeginContactParticleSystemBodyCallback = void (*)(b2ParticleSystem* particleSystem, b2ParticleBodyContact* particleBodyContact, void* userData);
    using EndContactParticleSystemBodyCallback = void (*)(b2Fixture* fixture, b2ParticleSystem* particleSystem, int32 index, void* userData);
    using BeginContactParticleSystemCallback = void (*)(b2ParticleSystem* particleSystem, b2ParticleContact* particleContact, void* userData);
    using EndContactParticleSystemCallback = void (*)(b2ParticleSystem* particleSystem, int32 indexA, int32 indexB, void* userData);
    using PreSolveCallback = void (*)(b2Contact* contact, const b2Manifold* oldManifold, void* userData);
    using PostSolveCallback = void (*)(b2Contact* contact, const b2ContactImpulse* impulse, void* userData);

    struct Callbacks {
        BeginContactCallback beginContactCallback;
        EndContactCallback endContactCallback;
        BeginContactParticleSystemBodyCallback beginContactParticleSystemBodyCallback;
        EndContactParticleSystemBodyCallback endContactParticleSystemBodyCallback;
        BeginContactParticleSystemCallback beginContactParticleSystemCallback;
        EndContactParticleSystemCallback endContactParticleSystemCallback;
        PreSolveCallback preSolveCallback;
        PostSolveCallback postSolveCallback;
        void* userData;
    };

    b2ContactListenerWrapper(Callbacks _callbacks)
        : callbacks(_callbacks) {
    }

    void BeginContact(b2Contact* contact) final {
        CALLBACKNORET(beginContactCallback, contact);
    }

    void EndContact(b2Contact* contact) final {
        CALLBACKNORET(endContactCallback, contact);
    }

    void BeginContact(b2ParticleSystem* particleSystem, b2ParticleBodyContact* particleBodyContact) final {
        CALLBACKNORET(beginContactParticleSystemBodyCallback, particleSystem, particleBodyContact);
    }

    void EndContact(b2Fixture* fixture, b2ParticleSystem* particleSystem, int32 index) final {
        CALLBACKNORET(endContactParticleSystemBodyCallback, fixture, particleSystem, index);
    }

    void BeginContact(b2ParticleSystem* particleSystem, b2ParticleContact* particleContact) final {
        CALLBACKNORET(beginContactParticleSystemCallback, particleSystem, particleContact);
    }

    void EndContact(b2ParticleSystem* particleSystem, int32 indexA, int32 indexB) final {
        CALLBACKNORET(endContactParticleSystemCallback, particleSystem, indexA, indexB);
    }

    void PreSolve(b2Contact* contact, const b2Manifold* oldManifold) final {
        CALLBACKNORET(preSolveCallback, contact, oldManifold);
    }

    void PostSolve(b2Contact* contact, const b2ContactImpulse* impulse) final {
        CALLBACKNORET(postSolveCallback, contact, impulse);
    }

    Callbacks callbacks;
};

// b2DrawWrapper
class b2DrawWrapper : public b2Draw {
public:
    using DrawPolygonCallback = void (*)(const b2Vec2* vertices, int32 vertexCount, const b2Color& color, void* userData);
    using DrawSolidPolygonCallback = void (*)(const b2Vec2* vertices, int32 vertexCount, const b2Color& color, void* userData);
    using DrawCircleCallback = void (*)(const b2Vec2& center, float radius, const b2Color& color, void* userData);
    using DrawSolidCircleCallback = void (*)(const b2Vec2& center, float radius, const b2Vec2& axis, const b2Color& color, void* userData);
    using DrawSegmentCallback = void (*)(const b2Vec2& p1, const b2Vec2& p2, const b2Color& color, void* userData);
    using DrawTransformCallback = void (*)(b2Transform xf, void* userData);
    using DrawPointCallback = void (*)(const b2Vec2& p, float size, const b2Color& color, void* userData);

    struct Callbacks {
        DrawPolygonCallback drawPolygonCallback;
        DrawSolidPolygonCallback drawSolidPolygonCallback;
        DrawCircleCallback drawCircleCallback;
        DrawSolidCircleCallback drawSolidCircleCallback;
        DrawSegmentCallback drawSegmentCallback;
        DrawTransformCallback drawTransformCallback;
        DrawPointCallback drawPointCallback;
        void* userData;
    };

    b2DrawWrapper(Callbacks _callbacks)
        : callbacks(_callbacks) {
    }

    void DrawPolygon(const b2Vec2* vertices, int32 vertexCount, const b2Color& color) final {
        CALLBACKNORET(drawPolygonCallback, vertices, vertexCount, color);
    }

    void DrawSolidPolygon(const b2Vec2* vertices, int32 vertexCount, const b2Color& color) final {
        CALLBACKNORET(drawSolidPolygonCallback, vertices, vertexCount, color);
    }

    void DrawCircle(const b2Vec2& center, float radius, const b2Color& color) final {
        CALLBACKNORET(drawCircleCallback, center, radius, color);
    }

    void DrawSolidCircle(const b2Vec2& center, float radius, const b2Vec2& axis, const b2Color& color) final {
        CALLBACKNORET(drawSolidCircleCallback, center, radius, axis, color);
    }

    void DrawSegment(const b2Vec2& p1, const b2Vec2& p2, const b2Color& color) final {
        CALLBACKNORET(drawSegmentCallback, p1, p2, color);
    }

    void DrawTransform(const b2Transform& xf) final {
        CALLBACKNORET(drawTransformCallback, xf);
    }

    void DrawPoint(const b2Vec2& p, float size, const b2Color& color) final {
        CALLBACKNORET(drawPointCallback, p, size, color);
    }

    Callbacks callbacks;
};

// b2World
BOX2DCAPI b2World* b2World_Create(const b2Vec2& gravity) {
    return new b2World(gravity);
}

BOX2DCAPI void b2World_Delete(b2World* world) {
    delete world;
}

B2WORLD(void, SetDestructionListenerCallbacks, b2DestructionListenerWrapper::Callbacks* callbacks) {
    world->SetDestructionListener(new b2DestructionListenerWrapper(*callbacks));
}

B2WORLD(void, SetContactFilter, b2ContactFilterWrapper::Callbacks* callbacks) {
    world->SetContactFilter(new b2ContactFilterWrapper(*callbacks));
}

B2WORLD(void, SetContactListener, b2ContactFilterWrapper::Callbacks* callbacks) {
    world->SetContactFilter(new b2ContactFilterWrapper(*callbacks));
}

B2WORLD(void, SetDebugDraw, b2DrawWrapper::Callbacks* callbacks) {
    world->SetDebugDraw(new b2DrawWrapper(*callbacks));
}

B2WORLD(b2Body*, CreateBody, b2BodyDef* def) {
    return world->CreateBody(def);
}

B2WORLD(void, DestroyBody, b2Body* body) {
    world->DestroyBody(body);
}

B2WORLD(b2Joint*, CreateJoint, b2JointDef* def) {
    return world->CreateJoint(def);
}

B2WORLD(void, DestroyJoint, b2Joint* joint) {
    world->DestroyJoint(joint);
}

B2WORLD(b2ParticleSystem*, CreateParticleSystem, b2ParticleSystemDef* def) {
    return world->CreateParticleSystem(def);
}

B2WORLD(void, DestroyParticleSystem, b2ParticleSystem* p) {
    world->DestroyParticleSystem(p);
}

B2WORLD(void, Step, float timeStep, int32 velocityIterations, int32 positionIterations, int32 particleIterations) {
    world->Step(timeStep, velocityIterations, positionIterations, particleIterations);
}

B2WORLD(int, CalculateReasonableParticleIterations, float timeStep) {
    return world->CalculateReasonableParticleIterations(timeStep);
}

B2WORLD(void, ClearForces) {
    world->ClearForces();
}

B2WORLD(void, DebugDraw) {
    world->DebugDraw();
}

B2WORLD(void, QueryAABB, b2QueryCallbackWrapper::Callbacks callbacks, const b2AABB& aabb) {
    b2QueryCallbackWrapper callback(callbacks);
    world->QueryAABB(&callback, aabb);
}

B2WORLD(void, RayCast, b2RayCastCallbackWrapper::Callbacks callbacks, const b2Vec2& point1, const b2Vec2& point2) {
    b2RayCastCallbackWrapper callback(callbacks);
    world->RayCast(&callback, point1, point2);
}

B2WORLD(b2Body*, GetBodyList) {
    return world->GetBodyList();
}

B2WORLD(b2Joint*, GetJointList) {
    return world->GetJointList();
}

B2WORLD(b2ParticleSystem*, GetParticleSystemList) {
    return world->GetParticleSystemList();
}

B2WORLD(b2Contact*, GetContactList) {
    return world->GetContactList();
}

B2WORLD(void, SetAllowSleeping, bool flag) {
    world->SetAllowSleeping(flag);
}

B2WORLD(bool, GetAllowSleeping) {
    return world->GetAllowSleeping();
}

B2WORLD(void, SetWarmStarting, bool flag) {
    world->SetWarmStarting(flag);
}

B2WORLD(bool, GetWarmStarting) {
    return world->GetWarmStarting();
}

B2WORLD(void, SetContinuousPhysics, bool flag) {
    world->SetContinuousPhysics(flag);
}

B2WORLD(bool, GetContinuousPhysics) {
    return world->GetContinuousPhysics();
}

B2WORLD(void, SetSubStepping, bool flag) {
    world->SetSubStepping(flag);
}

B2WORLD(bool, GetSubStepping) {
    return world->GetSubStepping();
}

B2WORLD(int32, GetProxyCount) {
    return world->GetProxyCount();
}

B2WORLD(int32, GetBodyCount) {
    return world->GetBodyCount();
}

B2WORLD(int32, GetJointCount) {
    return world->GetJointCount();
}

B2WORLD(int32, GetContactCount) {
    return world->GetContactCount();
}

B2WORLD(int32, GetTreeHeight) {
    return world->GetTreeHeight();
}

B2WORLD(int32, GetTreeBalance) {
    return world->GetTreeBalance();
}

B2WORLD(float, GetTreeQuality) {
    return world->GetTreeQuality();
}

B2WORLD(void, SetGravity, const b2Vec2& gravity) {
    world->SetGravity(gravity);
}

B2WORLD(b2Vec2, GetGravity) {
    return world->GetGravity();
}

B2WORLD(bool, IsLocked) {
    return world->IsLocked();
}

B2WORLD(void, SetAutoClearForces, bool flag) {
    world->SetAutoClearForces(flag);
}

B2WORLD(bool, GetAutoClearForces) {
    return world->GetAutoClearForces();
}

B2WORLD(void, ShiftOrigin, const b2Vec2& newOrigin) {
    world->ShiftOrigin(newOrigin);
}
