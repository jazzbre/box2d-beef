#include "box2dapi.h"
#include "box2d/b2_rope.h"

#define B2ROPE(_ret_, _name_, ...) BOX2DCAPI _ret_ b2Rope_##_name_(b2Rope* rope, ##__VA_ARGS__)

BOX2DCAPI b2Rope* b2Rope_Create(const b2RopeDef& def) {
    b2Rope* rope = new b2Rope();
    rope->Create(def);
    return rope;
}

BOX2DCAPI void b2Rope_Destroy(b2Rope* rope) {
    delete rope;
}

B2ROPE(void, SetTuning, const b2RopeTuning& v) {
    rope->SetTuning(v);
}

B2ROPE(void, Step, float timeStep, int32 iterations, const b2Vec2& position) {
    rope->Step(timeStep, iterations, position);
}

B2ROPE(void, Reset, const b2Vec2& v) {
    rope->Reset(v);
}

B2ROPE(int32, GetPointCount) {
    return rope->m_count;
}

B2ROPE(b2Vec2_C, GetPointPosition, int v) {
    RETURNPOD(b2Vec2_C, rope->m_ps[v]);
}

B2ROPE(float, GetPointInvMass, int v) {
    return rope->m_invMasses[v];
}
