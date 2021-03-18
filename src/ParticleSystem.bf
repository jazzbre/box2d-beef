using System;

namespace Box2D
{
	/// The particle type. Can be combined with the | operator.
	enum b2ParticleFlag : uint32
	{
		/// Water particle.
		b2_waterParticle = 0,
		/// Removed after next simulation step.
		b2_zombieParticle = 1 << 1,
		/// Zero velocity.
		b2_wallParticle = 1 << 2,
		/// With restitution from stretching.
		b2_springParticle = 1 << 3,
		/// With restitution from deformation.
		b2_elasticParticle = 1 << 4,
		/// With viscosity.
		b2_viscousParticle = 1 << 5,
		/// Without isotropic pressure.
		b2_powderParticle = 1 << 6,
		/// With surface tension.
		b2_tensileParticle = 1 << 7,
		/// Mix color between contacting particles.
		b2_colorMixingParticle = 1 << 8,
		/// Call b2DestructionListener on destruction.
		b2_destructionListenerParticle = 1 << 9,
		/// Prevents other particles from leaking.
		b2_barrierParticle = 1 << 10,
		/// Less compressibility.
		b2_staticPressureParticle = 1 << 11,
		/// Makes pairs or triads with other particles.
		b2_reactiveParticle = 1 << 12,
		/// With high repulsive force.
		b2_repulsiveParticle = 1 << 13,
		/// Call b2ContactListener when this particle is about to interact with
		/// a rigid body or stops interacting with a rigid body.
		/// This results in an expensive operation compared to using
		/// b2_fixtureContactFilterParticle to detect collisions between
		/// particles.
		b2_fixtureContactListenerParticle = 1 << 14,
		/// Call b2ContactListener when this particle is about to interact with
		/// another particle or stops interacting with another particle.
		/// This results in an expensive operation compared to using
		/// b2_particleContactFilterParticle to detect collisions between
		/// particles.
		b2_particleContactListenerParticle = 1 << 15,
		/// Call b2ContactFilter when this particle interacts with rigid bodies.
		b2_fixtureContactFilterParticle = 1 << 16,
		/// Call b2ContactFilter when this particle interacts with other
		/// particles.
		b2_particleContactFilterParticle = 1 << 17,
	}


	[CRepr]
	struct b2ParticleDef
	{
		/// \brief Specifies the type of particle (see #b2ParticleFlag).
		///
		/// A particle may be more than one type.
		/// Multiple types are chained by logical sums, for example:
		/// pd.flags = b2_elasticParticle | b2_viscousParticle
		public b2ParticleFlag flags;

		/// The world position of the particle.
		public b2Vec2 position;

		/// The linear velocity of the particle in world co-ordinates.
		public b2Vec2 velocity;

		/// The color of the particle.
		public b2ParticleColor color;

		/// Lifetime of the particle in seconds.  A value <= 0.0f indicates a
		/// particle with infinite lifetime.
		public float lifetime;

		/// Use this to store application-specific body data.
		public void* userData;

		/// An existing particle group to which the particle will be added.
		public b2ParticleGroup* group;
	}

	[CRepr]
	struct b2ParticleSystemDef
	{
		/// Enable strict Particle/Body contact check.
		/// See SetStrictContactCheck for details.
		public bool strictContactCheck;

		/// Set the particle density.
		/// See SetDensity for details.
		public float density = 1.0f;

		/// Change the particle gravity scale. Adjusts the effect of the global
		/// gravity vector on particles. Default value is 1.0f.
		public float gravityScale = 1.0f;

		/// Particles behave as circles with this radius. In Box2D units.
		public float radius = 1.0f;

		/// Set the maximum number of particles.
		/// By default, there is no maximum. The particle buffers can continue to
		/// grow while b2World's block allocator still has memory.
		/// See SetMaxParticleCount for details.
		public int32 maxCount;

		/// Increases pressure in response to compression
		/// Smaller values allow more compression
		public float pressureStrength = 0.05f;

		/// Reduces velocity along the collision normal
		/// Smaller value reduces less
		public float dampingStrength = 1.0f;

		/// Restores shape of elastic particle groups
		/// Larger values increase elastic particle velocity
		public float elasticStrength = 0.25f;

		/// Restores length of spring particle groups
		/// Larger values increase spring particle velocity
		public float springStrength = 0.25f;

		/// Reduces relative velocity of viscous particles
		/// Larger values slow down viscous particles more
		public float viscousStrength = 0.25f;

		/// Produces pressure on tensile particles
		/// 0~0.2. Larger values increase the amount of surface tension.
		public float surfaceTensionPressureStrength = 0.2f;

		/// Smoothes outline of tensile particles
		/// 0~0.2. Larger values result in rounder, smoother, water-drop-like
		/// clusters of particles.
		public float surfaceTensionNormalStrength = 0.2f;

		/// Produces additional pressure on repulsive particles
		/// Larger values repulse more
		/// Negative values mean attraction. The range where particles behave
		/// stably is about -0.2 to 2.0.
		public float repulsiveStrength = 1.0f;

		/// Produces repulsion between powder particles
		/// Larger values repulse more
		public float powderStrength = 0.5f;

		/// Pushes particles out of solid particle group
		/// Larger values repulse more
		public float ejectionStrength = 0.5f;;

		/// Produces static pressure
		/// Larger values increase the pressure on neighboring partilces
		/// For a description of static pressure, see
		/// http://en.wikipedia.org/wiki/Static_pressure#Static_pressure_in_fluid_dynamics
		public float staticPressureStrength = 0.2f;

		/// Reduces instability in static pressure calculation
		/// Larger values make stabilize static pressure with fewer iterations
		public float staticPressureRelaxation = 0.2f;

		/// Computes static pressure more precisely
		/// See SetStaticPressureIterations for details
		public int32 staticPressureIterations = 8;

		/// Determines how fast colors are mixed
		/// 1.0f ==> mixed immediately
		/// 0.5f ==> mixed half way each simulation step (see b2World::Step())
		public float colorMixingStrength = 0.5f;

		/// Whether to destroy particles by age when no more particles can be
		/// created.  See #b2ParticleSystem::SetDestructionByAge() for
		/// more information.
		public bool destroyByAge = true;

		/// Granularity of particle lifetimes in seconds.  By default this is
		/// set to (1.0f / 60.0f) seconds.  b2ParticleSystem uses a 32-bit signed
		/// value to track particle lifetimes so the maximum lifetime of a
		/// particle is (2^32 - 1) / (1.0f / lifetimeGranularity) seconds.
		/// With the value set to 1/60 the maximum lifetime or age of a particle is
		/// 2.27 years.
		public float lifetimeGranularity = 1.0f / 60.0f;
	}

	/// The particle group type.  Can be combined with the | operator.
	enum b2ParticleGroupFlag
	{
		/// Prevents overlapping or leaking.
		b2_solidParticleGroup = 1 << 0,
		/// Keeps its shape.
		b2_rigidParticleGroup = 1 << 1,
		/// Won't be destroyed if it gets empty.
		b2_particleGroupCanBeEmpty = 1 << 2,
		/// Will be destroyed on next simulation step.
		b2_particleGroupWillBeDestroyed = 1 << 3,
		/// Updates depth data on next simulation step.
		b2_particleGroupNeedsUpdateDepth = 1 << 4,
		b2_particleGroupInternalMask = b2_particleGroupWillBeDestroyed | b2_particleGroupNeedsUpdateDepth,
	}

	/// A particle group definition holds all the data needed to construct a
	/// particle group.  You can safely re-use these definitions.
	[CRepr]
	struct b2ParticleGroupDef
	{
		/// The particle-behavior flags (See #b2ParticleFlag).
		public uint32 flags;

		/// The group-construction flags (See #b2ParticleGroupFlag).
		public uint32 groupFlags;

		/// The world position of the group.
		/// Moves the group's shape a distance equal to the value of position.
		public b2Vec2 position;

		/// The world angle of the group in radians.
		/// Rotates the shape by an angle equal to the value of angle.
		public float angle;

		/// The linear velocity of the group's origin in world co-ordinates.
		public b2Vec2 linearVelocity;

		/// The angular velocity of the group.
		public float angularVelocity;

		/// The color of all particles in the group.
		public b2ParticleColor color;

		/// The strength of cohesion among the particles in a group with flag
		/// b2_elasticParticle or b2_springParticle.
		public float strength = 1;

		/// The shape where particles will be added.
		public b2Shape* shape;

		/// A array of shapes where particles will be added.
		public b2Shape** shapes;

		/// The number of shapes.
		public int32 shapeCount;

		/// The interval of particles in the shape.
		/// If it is 0, b2_particleStride * particleDiameter is used instead.
		public float stride;

		/// The number of particles in addition to ones added in the shape.
		public int32 particleCount;

		/// The initial positions of the particleCount particles.
		public b2Vec2* positionData;

		/// Lifetime of the particle group in seconds.  A value <= 0.0f indicates a
		/// particle group with infinite lifetime.
		public float lifetime;

		/// Use this to store application-specific group data.
		public void* userData;

		/// An existing particle group to which the particles will be added.
		public b2ParticleGroup* group;
	}


	static class ParticleSystem
	{
		[LinkName("b2ParticleSystem_CreateParticle")] public static extern int32 CreateParticle(b2ParticleSystem* particleSystem, b2ParticleDef* def);
		[LinkName("b2ParticleSystem_DestroyParticle")] public static extern void DestroyParticle(b2ParticleSystem* particleSystem, int32 index, bool callDestructionListener);
		[LinkName("b2ParticleSystem_DestroyOldestParticle")] public static extern void DestroyOldestParticle(b2ParticleSystem* particleSystem, int32 index, bool callDestructionListener);
		[LinkName("b2ParticleSystem_DestroyParticlesInShape")] public static extern void DestroyParticlesInShape(b2ParticleSystem* particleSystem, b2Shape* shape, ref b2Transform xf, bool callDestructionListener);
		[LinkName("b2ParticleSystem_CreateParticleGroup")] public static extern b2ParticleGroup* CreateParticleGroup(b2ParticleSystem* particleSystem, b2ParticleGroupDef* def);
		[LinkName("b2ParticleSystem_JoinParticleGroups")] public static extern void JoinParticleGroups(b2ParticleSystem* particleSystem, b2ParticleGroup* groupA, b2ParticleGroup* groupB);
		[LinkName("b2ParticleSystem_SplitParticleGroup")] public static extern void SplitParticleGroup(b2ParticleSystem* particleSystem, b2ParticleGroup* group);
		[LinkName("b2ParticleSystem_GetParticleGroupCount")] public static extern int32 GetParticleGroupCount(b2ParticleSystem* particleSystem);
		[LinkName("b2ParticleSystem_GetParticleCount")] public static extern int32 GetParticleCount(b2ParticleSystem* particleSystem);
		[LinkName("b2ParticleSystem_GetMaxParticleCount")] public static extern int32 GetMaxParticleCount(b2ParticleSystem* particleSystem);
		[LinkName("b2ParticleSystem_SetMaxParticleCount")] public static extern void SetMaxParticleCount(b2ParticleSystem* particleSystem, int32 v);
		[LinkName("b2ParticleSystem_GetAllParticleFlags")] public static extern b2ParticleFlag GetAllParticleFlags(b2ParticleSystem* particleSystem);
		[LinkName("b2ParticleSystem_GetAllGroupFlags")] public static extern b2ParticleFlag GetAllGroupFlags(b2ParticleSystem* particleSystem);
		[LinkName("b2ParticleSystem_SetPaused")] public static extern void SetPaused(b2ParticleSystem* particleSystem, bool v);
		[LinkName("b2ParticleSystem_GetPaused")] public static extern bool GetPaused(b2ParticleSystem* particleSystem);
		[LinkName("b2ParticleSystem_SetDensity")] public static extern void SetDensity(b2ParticleSystem* particleSystem, float v);
		[LinkName("b2ParticleSystem_GetDensity")] public static extern float GetDensity(b2ParticleSystem* particleSystem);
		[LinkName("b2ParticleSystem_SetGravityScale")] public static extern void SetGravityScale(b2ParticleSystem* particleSystem, float v);
		[LinkName("b2ParticleSystem_GetGravityScale")] public static extern float GetGravityScale(b2ParticleSystem* particleSystem);
		[LinkName("b2ParticleSystem_SetDamping")] public static extern void SetDamping(b2ParticleSystem* particleSystem, float v);
		[LinkName("b2ParticleSystem_GetDamping")] public static extern float GetDamping(b2ParticleSystem* particleSystem);
		[LinkName("b2ParticleSystem_SetStaticPressureIterations")] public static extern void SetStaticPressureIterations(b2ParticleSystem* particleSystem, int32 v);
		[LinkName("b2ParticleSystem_GetStaticPressureIterations")] public static extern int32 GetStaticPressureIterations(b2ParticleSystem* particleSystem);
		[LinkName("b2ParticleSystem_SetRadius")] public static extern void SetRadius(b2ParticleSystem* particleSystem, float v);
		[LinkName("b2ParticleSystem_GetRadius")] public static extern float GetRadius(b2ParticleSystem* particleSystem);
		[LinkName("b2ParticleSystem_GetPositionBuffer")] public static extern b2Vec2* GetPositionBuffer(b2ParticleSystem* particleSystem);
		[LinkName("b2ParticleSystem_GetVelocityBuffer")] public static extern b2Vec2* GetVelocityBuffer(b2ParticleSystem* particleSystem);
		[LinkName("b2ParticleSystem_GetColorBuffer")] public static extern b2ParticleColor* GetColorBuffer(b2ParticleSystem* particleSystem);
		[LinkName("b2ParticleSystem_GetWeightBuffer")] public static extern float* GetWeightBuffer(b2ParticleSystem* particleSystem);
		[LinkName("b2ParticleSystem_GetUserDataBuffer")] public static extern void** GetUserDataBuffer(b2ParticleSystem* particleSystem);
		[LinkName("b2ParticleSystem_GetFlagsBuffer")] public static extern b2ParticleFlag* GetFlagsBuffer(b2ParticleSystem* particleSystem);
		[LinkName("b2ParticleSystem_SetParticleFlags")] public static extern void SetParticleFlags(b2ParticleSystem* particleSystem, int32 index, b2ParticleFlag v);
		[LinkName("b2ParticleSystem_GetParticleFlags")] public static extern b2ParticleFlag GetParticleFlags(b2ParticleSystem* particleSystem, int32 index);
		[LinkName("b2ParticleSystem_SetStuckThreshold")] public static extern void SetStuckThreshold(b2ParticleSystem* particleSystem, int32 v);
		[LinkName("b2ParticleSystem_ComputeCollisionEnergy")] public static extern float ComputeCollisionEnergy(b2ParticleSystem* particleSystem);
		[LinkName("b2ParticleSystem_SetStrictContactCheck")] public static extern void SetStrictContactCheck(b2ParticleSystem* particleSystem, bool v);
		[LinkName("b2ParticleSystem_GetStrictContactCheck")] public static extern bool GetStrictContactCheck(b2ParticleSystem* particleSystem);
		[LinkName("b2ParticleSystem_SetParticleLifetime")] public static extern void SetParticleLifetime(b2ParticleSystem* particleSystem, int32 index, float v);
		[LinkName("b2ParticleSystem_GetParticleLifetime")] public static extern float GetParticleLifetime(b2ParticleSystem* particleSystem, int32 index);
		[LinkName("b2ParticleSystem_SetDestructionByAge")] public static extern void SetDestructionByAge(b2ParticleSystem* particleSystem, bool v);
		[LinkName("b2ParticleSystem_GetDestructionByAge")] public static extern bool GetDestructionByAge(b2ParticleSystem* particleSystem);
		[LinkName("b2ParticleSystem_GetExpirationTimeBuffer")] public static extern int32* GetExpirationTimeBuffer(b2ParticleSystem* particleSystem);
		[LinkName("b2ParticleSystem_ExpirationTimeToLifetime")] public static extern float ExpirationTimeToLifetime(b2ParticleSystem* particleSystem, int32 v);
		[LinkName("b2ParticleSystem_ParticleApplyLinearImpulse")] public static extern void ParticleApplyLinearImpulse(b2ParticleSystem* particleSystem, int32 index, ref b2Vec2 impulse);
		[LinkName("b2ParticleSystem_ApplyLinearImpulse")] public static extern void ApplyLinearImpulse(b2ParticleSystem* particleSystem, int32 firstIndex, int32 lastIndex, ref b2Vec2 impulse);
		[LinkName("b2ParticleSystem_ParticleApplyForce")] public static extern void ParticleApplyForce(b2ParticleSystem* particleSystem, int32 index, ref b2Vec2 force);
		[LinkName("b2ParticleSystem_ApplyForce")] public static extern void ApplyForce(b2ParticleSystem* particleSystem, int32 firstIndex, int32 lastIndex, ref b2Vec2 force);
		[LinkName("b2ParticleSystem_QueryAABB")] public static extern void QueryAABB(b2ParticleSystem* particleSystem, b2QueryCallback* callbacks, ref b2AABB aabb);
		[LinkName("b2ParticleSystem_RayCast")] public static extern void RayCast(b2ParticleSystem* particleSystem, b2RayCastCallback* callbacks, ref b2Vec2 point1, ref b2Vec2 point2);
		[LinkName("b2ParticleSystem_ComputeAABB")] public static extern void ComputeAABB(b2ParticleSystem* particleSystem, b2AABB* aabb);
	}
}
