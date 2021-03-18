using System;

namespace Box2D
{
	enum b2JointType
	{
		e_unknownJoint,
		e_revoluteJoint,
		e_prismaticJoint,
		e_distanceJoint,
		e_pulleyJoint,
		e_mouseJoint,
		e_gearJoint,
		e_wheelJoint,
		e_weldJoint,
		e_frictionJoint,
		e_ropeJoint,
		e_motorJoint
	}

	[CRepr]
	struct b2JointDef
	{
		/// The joint type is set automatically for concrete joint types.
		public b2JointType type;

		/// Use this to attach application specific data to your joints.
		public b2JointUserData userData;

		/// The first attached body.
		public b2Body* bodyA;

		/// The second attached body.
		public b2Body* bodyB;

		/// Set this flag to true if the attached bodies should collide.
		public bool collideConnected;
	}

	/// Distance joint definition. This requires defining an anchor point on both
	/// bodies and the non-zero distance of the distance joint. The definition uses
	/// local anchor points so that the initial configuration can violate the
	/// constraint slightly. This helps when saving and loading a game.
	[CRepr]
	struct b2DistanceJointDef : b2JointDef
	{
		public this()
		{
			type = .e_distanceJoint;
		}

		/// Initialize the bodies, anchors, and rest length using world space anchors.
		/// The minimum and maximum lengths are set to the rest length.
		public void Initialize(b2Body* _bodyA, b2Body* _bodyB, ref b2Vec2 anchorA, ref b2Vec2 anchorB) mut
		{
			bodyA = _bodyA;
			bodyB = _bodyB;
			localAnchorA = Body.GetLocalPoint(bodyA, ref anchorA);
			localAnchorB = Body.GetLocalPoint(bodyA, ref anchorB);
			b2Vec2 d = anchorB - anchorA;
			length = Math.Max(d.Length, Constants.b2_linearSlop);
			minLength = length;
			maxLength = length;
		}

		/// The local anchor point relative to bodyA's origin.
		public b2Vec2 localAnchorA = .Zero;

		/// The local anchor point relative to bodyB's origin.
		public b2Vec2 localAnchorB = .Zero;

		/// The rest length of this joint. Clamped to a stable minimum value.
		public float length = 1.0f;

		/// Minimum length. Clamped to a stable minimum value.
		public float minLength = 0.0f;

		/// Maximum length. Must be greater than or equal to the minimum length.
		public float maxLength = float.MaxValue;

		/// The linear stiffness in N/m.
		public float stiffness = 0.0f;

		/// The linear damping in N*s/m.
		public float damping = 0.0f;
	}

	/// Friction joint definition.
	[CRepr]
	struct b2FrictionJointDef : b2JointDef
	{
		public this()
		{
			type = .e_frictionJoint;
		}

		/// Initialize the bodies, anchors, axis, and reference angle using the world
		/// anchor and world axis.
		public void Initialize(b2Body* _bodyA, b2Body* _bodyB, ref b2Vec2 anchor) mut
		{
			bodyA = _bodyA;
			bodyB = _bodyB;
			localAnchorA = Body.GetLocalPoint(bodyA, ref anchor);
			localAnchorB = Body.GetLocalPoint(bodyB, ref anchor);
		}

		/// The local anchor point relative to bodyA's origin.
		b2Vec2 localAnchorA = .Zero;

		/// The local anchor point relative to bodyB's origin.
		b2Vec2 localAnchorB = .Zero;

		/// The maximum friction force in N.
		float maxForce = 0.0f;

		/// The maximum friction torque in N-m.
		float maxTorque = 0.0f;
	}

	/// Gear joint definition. This definition requires two existing
	/// revolute or prismatic joints (any combination will work).
	/// @warning bodyB on the input joints must both be dynamic
	[CRepr]
	struct b2GearJointDef : b2JointDef
	{
		public this()
		{
			type = .e_gearJoint;
		}

		/// The first revolute/prismatic joint attached to the gear joint.
		b2Joint* joint1 = null;

		/// The second revolute/prismatic joint attached to the gear joint.
		b2Joint* joint2 = null;

		/// The gear ratio.
		/// @see b2GearJoint for explanation.
		float ratio = 1.0f;
	}

	/// Motor joint definition.
	[CRepr]
	struct b2MotorJointDef : b2JointDef
	{
		public this()
		{
			type = .e_motorJoint;
		}

		public void Initialize(b2Body* _bodyA, b2Body* _bodyB) mut
		{
			bodyA = _bodyA;
			bodyB = _bodyB;
			b2Vec2 xB = Body.GetPosition(bodyB);
			linearOffset = Body.GetLocalPoint(bodyA, ref xB);
			float angleA = Body.GetAngle(bodyA);
			float angleB = Body.GetAngle(bodyB);
			angularOffset = angleB - angleA;
		}

		/// Position of bodyB minus the position of bodyA, in bodyA's frame, in meters.
		b2Vec2 linearOffset = .Zero;

		/// The bodyB angle minus bodyA angle in radians.
		float angularOffset = 0.0f;

		/// The maximum motor force in N.
		float maxForce = 1.0f;

		/// The maximum motor torque in N-m.
		float maxTorque = 1.0f;

		/// Position correction factor in the range [0,1].
		float correctionFactor = 0.3f;
	}

	/// Mouse joint definition. This requires a world target point,
	/// tuning parameters, and the time step.
	[CRepr]
	struct b2MouseJointDef : b2JointDef
	{
		public this()
		{
			type = .e_mouseJoint;
		}

		/// The initial world target point. This is assumed
		/// to coincide with the body anchor initially.
		b2Vec2 target = .Zero;

		/// The maximum constraint force that can be exerted
		/// to move the candidate body. Usually you will express
		/// as some multiple of the weight (multiplier * mass * gravity).
		float maxForce = 0.0f;

		/// The linear stiffness in N/m
		float stiffness = 0.0f;

		/// The linear damping in N*s/m
		float damping = 0.0f;
	}

	/// Prismatic joint definition. This requires defining a line of
	/// motion using an axis and an anchor point. The definition uses local
	/// anchor points and a local axis so that the initial configuration
	/// can violate the constraint slightly. The joint translation is zero
	/// when the local anchor points coincide in world space. Using local
	/// anchors and a local axis helps when saving and loading a game.
	[CRepr]
	struct b2PrismaticJointDef : b2JointDef
	{
		public this()
		{
			type = .e_prismaticJoint;
			referenceAngle = 0.0f;
			enableLimit = false;
			lowerTranslation = 0.0f;
			upperTranslation = 0.0f;
			enableMotor = false;
			maxMotorForce = 0.0f;
			motorSpeed = 0.0f;
		}

		/// Initialize the bodies, anchors, axis, and reference angle using the world
		/// anchor and unit world axis.
		public void Initialize(b2Body* _bodyA, b2Body* _bodyB, ref b2Vec2 anchor, ref b2Vec2 axis) mut
		{
			bodyA = _bodyA;
			bodyB = _bodyB;
			localAnchorA = Body.GetLocalPoint(bodyA, ref anchor);
			localAnchorB = Body.GetLocalPoint(bodyB, ref anchor);
			localAxisA = Body.GetLocalVector(bodyA, ref axis);
			referenceAngle = Body.GetAngle(bodyB) - Body.GetAngle(bodyA);
		}

		/// The local anchor point relative to bodyA's origin.
		public b2Vec2 localAnchorA = .Zero;

		/// The local anchor point relative to bodyB's origin.
		public b2Vec2 localAnchorB = .Zero;

		/// The local translation unit axis in bodyA.
		public b2Vec2 localAxisA = .(1.0f, 0.0f);

		/// The constrained angle between the bodies: bodyB_angle - bodyA_angle.
		public float referenceAngle = 0.0f;

		/// Enable/disable the joint limit.
		public bool enableLimit = false;

		/// The lower translation limit, usually in meters.
		public float lowerTranslation = 0.0f;

		/// The upper translation limit, usually in meters.
		public float upperTranslation = 0.0f;

		/// Enable/disable the joint motor.
		public bool enableMotor = false;

		/// The maximum motor torque, usually in N-m.
		public float maxMotorForce = 0.0f;

		/// The desired motor speed in radians per second.
		public float motorSpeed = 0.0f;
	}

	/// Pulley joint definition. This requires two ground anchors,
	/// two dynamic body anchor points, and a pulley ratio.
	[CRepr]
	struct b2PulleyJointDef : b2JointDef
	{
		public const float b2_minPulleyLength = 2.0f;

		public this()
		{
			type = .e_pulleyJoint;
			collideConnected = true;
		}

		/// Initialize the bodies, anchors, lengths, max lengths, and ratio using the world anchors.
		public void Initialize(b2Body* _bodyA, b2Body* _bodyB, ref b2Vec2 _groundAnchorA, ref b2Vec2 _groundAnchorB, ref b2Vec2 anchorA, ref b2Vec2 anchorB, float _ratio) mut
		{
			bodyA = _bodyA;
			bodyB = _bodyB;
			groundAnchorA = _groundAnchorA;
			groundAnchorB = _groundAnchorB;
			localAnchorA = Body.GetLocalPoint(bodyA, ref anchorA);
			localAnchorB = Body.GetLocalPoint(bodyB, ref anchorB);
			var dA = anchorA - _groundAnchorA;
			lengthA = dA.Length;
			var dB = anchorB - _groundAnchorB;
			lengthB = dB.Length;
			ratio = _ratio;
		}

		/// The first ground anchor in world coordinates. This point never moves.
		public b2Vec2 groundAnchorA = .(-1.0f, 1.0f);

		/// The second ground anchor in world coordinates. This point never moves.
		public b2Vec2 groundAnchorB = .(1.0f, 1.0f);

		/// The local anchor point relative to bodyA's origin.
		public b2Vec2 localAnchorA = .(-1.0f, 0.0f);

		/// The local anchor point relative to bodyB's origin.
		public b2Vec2 localAnchorB = .(1.0f, 0.0f);

		/// The a reference length for the segment attached to bodyA.
		public float lengthA = 0.0f;

		/// The a reference length for the segment attached to bodyB.
		public float lengthB = 0.0f;

		/// The pulley ratio, used to simulate a block-and-tackle.
		public float ratio = 1.0f;
	}

	/// Revolute joint definition. This requires defining an anchor point where the
	/// bodies are joined. The definition uses local anchor points so that the
	/// initial configuration can violate the constraint slightly. You also need to
	/// specify the initial relative angle for joint limits. This helps when saving
	/// and loading a game.
	/// The local anchor points are measured from the body's origin
	/// rather than the center of mass because:
	/// 1. you might not know where the center of mass will be.
	/// 2. if you add/remove shapes from a body and recompute the mass,
	///    the joints will be broken.
	[CRepr]
	struct b2RevoluteJointDef : b2JointDef
	{
		public this()
		{
			type = .e_revoluteJoint;
		}

		/// Initialize the bodies, anchors, and reference angle using a world
		/// anchor point.
		public void Initialize(b2Body* _bodyA, b2Body* _bodyB, ref b2Vec2 anchor) mut
		{
			bodyA = _bodyA;
			bodyB = _bodyB;
			localAnchorA = Body.GetLocalPoint(bodyA, ref anchor);
			localAnchorB = Body.GetLocalPoint(bodyB, ref anchor);
			referenceAngle = Body.GetAngle(bodyB) - Body.GetAngle(bodyB);
		}

		/// The local anchor point relative to bodyA's origin.
		public b2Vec2 localAnchorA = .Zero;

		/// The local anchor point relative to bodyB's origin.
		public b2Vec2 localAnchorB = .Zero;

		/// The bodyB angle minus bodyA angle in the reference state (radians).
		public float referenceAngle = 0.0f;

		/// A flag to enable joint limits.
		public bool enableLimit = false;

		/// The lower angle for the joint limit (radians).
		public float lowerAngle = 0.0f;

		/// The upper angle for the joint limit (radians).
		public float upperAngle = 0.0f;

		/// A flag to enable the joint motor.
		public bool enableMotor = false;

		/// The desired motor speed. Usually in radians per second.
		public float motorSpeed = 0.0f;

		/// The maximum motor torque used to achieve the desired motor speed.
		/// Usually in N-m.
		public float maxMotorTorque = 0.0f;
	}

	/// Weld joint definition. You need to specify local anchor points
	/// where they are attached and the relative body angle. The position
	/// of the anchor points is important for computing the reaction torque.
	[CRepr]
	struct b2WeldJointDef : b2JointDef
	{
		public this()
		{
			type = .e_weldJoint;
		}

		/// Initialize the bodies, anchors, reference angle, stiffness, and damping.
		/// @param bodyA the first body connected by this joint
		/// @param bodyB the second body connected by this joint
		/// @param anchor the point of connection in world coordinates
		public void Initialize(b2Body* _bodyA, b2Body* _bodyB, ref b2Vec2 anchor) mut
		{
			bodyA = _bodyA;
			bodyB = _bodyB;
			localAnchorA = Body.GetLocalPoint(bodyA, ref anchor);
			localAnchorB = Body.GetLocalPoint(bodyB, ref anchor);
			referenceAngle = Body.GetAngle(bodyB) - Body.GetAngle(bodyB);
		}

		/// The local anchor point relative to bodyA's origin.
		public b2Vec2 localAnchorA = .Zero;

		/// The local anchor point relative to bodyB's origin.
		public b2Vec2 localAnchorB = .Zero;

		/// The bodyB angle minus bodyA angle in the reference state (radians).
		public float referenceAngle = 0.0f;

		/// The rotational stiffness in N*m
		/// Disable softness with a value of 0
		public float stiffness = 0.0f;

		/// The rotational damping in N*m*s
		public float damping = 0.0f;
	}

	/// Wheel joint definition. This requires defining a line of
	/// motion using an axis and an anchor point. The definition uses local
	/// anchor points and a local axis so that the initial configuration
	/// can violate the constraint slightly. The joint translation is zero
	/// when the local anchor points coincide in world space. Using local
	/// anchors and a local axis helps when saving and loading a game.
	[CRepr]
	struct b2WheelJointDef : b2JointDef
	{
		public this()
		{
			type = .e_wheelJoint;
		}

		/// Initialize the bodies, anchors, axis, and reference angle using the world
		/// anchor and world axis.
		public void Initialize(b2Body* _bodyA, b2Body* _bodyB, ref b2Vec2 anchor, ref b2Vec2 axis) mut
		{
			bodyA = _bodyA;
			bodyB = _bodyB;
			localAnchorA = Body.GetLocalPoint(bodyA, ref anchor);
			localAnchorB = Body.GetLocalPoint(bodyB, ref anchor);
			localAxisA = Body.GetLocalVector(bodyA, ref axis);
		}

		/// The local anchor point relative to bodyA's origin.
		public b2Vec2 localAnchorA = .Zero;

		/// The local anchor point relative to bodyB's origin.
		public b2Vec2 localAnchorB = .Zero;

		/// The local translation axis in bodyA.
		public b2Vec2 localAxisA = .(1.0f, 0.0f);

		/// Enable/disable the joint limit.
		public bool enableLimit = false;

		/// The lower translation limit, usually in meters.
		public float lowerTranslation = 0.0f;

		/// The upper translation limit, usually in meters.
		public float upperTranslation = 0.0f;

		/// Enable/disable the joint motor.
		public bool enableMotor = false;

		/// The maximum motor torque, usually in N-m.
		public float maxMotorTorque = 0.0f;

		/// The desired motor speed in radians per second.
		public float motorSpeed = 0.0f;

		/// Suspension stiffness. Typically in units N/m.
		public float stiffness = 0.0f;

		/// Suspension damping. Typically in units of N*s/m.
		public float damping = 0.0f;
	}

	static class Joint
	{
		[LinkName("b2Joint_GetJointType")] public static extern b2JointType GetJointType(b2Joint* joint);
		[LinkName("b2Joint_GetBodyA")] public static extern b2Body* GetBodyA(b2Joint* joint);
		[LinkName("b2Joint_GetBodyB")] public static extern b2Body* GetBodyB(b2Joint* joint);
		[LinkName("b2Joint_GetAnchorA")] public static extern b2Vec2 GetAnchorA(b2Joint* joint);
		[LinkName("b2Joint_GetAnchorB")] public static extern b2Vec2 GetAnchorB(b2Joint* joint);
		[LinkName("b2Joint_GetReactionForce")] public static extern b2Vec2 GetReactionForce(b2Joint* joint, float v);
		[LinkName("b2Joint_GetReactionTorque")] public static extern float GetReactionTorque(b2Joint* joint, float v);
		[LinkName("b2Joint_SetUserData")] public static extern void SetUserData(b2Joint* joint, void* v);
		[LinkName("b2Joint_GetUserData")] public static extern void* GetUserData(b2Joint* joint);
		[LinkName("b2Joint_IsEnabled")] public static extern bool IsEnabled(b2Joint* joint);
		[LinkName("b2Joint_GetCollideConnected")] public static extern bool GetCollideConnected(b2Joint* joint);

		/// A revolute joint constrains two bodies to share a common point while they
		/// are free to rotate about the point. The relative rotation about the shared
		/// point is the joint angle. You can limit the relative rotation with
		/// a joint limit that specifies a lower and upper angle. You can use a motor
		/// to drive the relative rotation about the shared point. A maximum motor torque
		/// is provided so that infinite forces are not generated.
		[LinkName("b2JointRevoluteJoint_GetLocalAnchorA")] public static extern b2Vec2 RevoluteJointGetLocalAnchorA(b2Joint* joint);
		[LinkName("b2JointRevoluteJoint_GetLocalAnchorB")] public static extern b2Vec2 RevoluteJointGetLocalAnchorB(b2Joint* joint);
		[LinkName("b2JointRevoluteJoint_GetReferenceAngle")] public static extern float RevoluteJointGetReferenceAngle(b2Joint* joint);
		[LinkName("b2JointRevoluteJoint_GetJointAngle")] public static extern float RevoluteJointGetJointAngle(b2Joint* joint);
		[LinkName("b2JointRevoluteJoint_GetJointSpeed")] public static extern float RevoluteJointGetJointSpeed(b2Joint* joint);
		[LinkName("b2JointRevoluteJoint_IsLimitEnabled")] public static extern bool RevoluteJointIsLimitEnabled(b2Joint* joint);
		[LinkName("b2JointRevoluteJoint_EnableLimit")] public static extern void RevoluteJointEnableLimit(b2Joint* joint, bool v);
		[LinkName("b2JointRevoluteJoint_GetLowerLimit")] public static extern float RevoluteJointGetLowerLimit(b2Joint* joint);
		[LinkName("b2JointRevoluteJoint_GetUpperLimit")] public static extern float RevoluteJointGetUpperLimit(b2Joint* joint);
		[LinkName("b2JointRevoluteJoint_SetLimits")] public static extern void RevoluteJointSetLimits(b2Joint* joint, float l, float u);
		[LinkName("b2JointRevoluteJoint_IsMotorEnabled")] public static extern bool RevoluteJointIsMotorEnabled(b2Joint* joint);
		[LinkName("b2JointRevoluteJoint_EnableMotor")] public static extern void RevoluteJointEnableMotor(b2Joint* joint, bool v);
		[LinkName("b2JointRevoluteJoint_SetMotorSpeed")] public static extern void RevoluteJointSetMotorSpeed(b2Joint* joint, float v);
		[LinkName("b2JointRevoluteJoint_GetMotorSpeed")] public static extern float RevoluteJointGetMotorSpeed(b2Joint* joint);
		[LinkName("b2JointRevoluteJoint_SetMaxMotorTorque")] public static extern void RevoluteJointSetMaxMotorTorque(b2Joint* joint, float v);
		[LinkName("b2JointRevoluteJoint_GetMaxMotorTorque")] public static extern float RevoluteJointGetMaxMotorTorque(b2Joint* joint);
		[LinkName("b2JointRevoluteJoint_GetReactionForce")] public static extern b2Vec2 RevoluteJointGetReactionForce(b2Joint* joint, float v);
		[LinkName("b2JointRevoluteJoint_GetReactionTorque")] public static extern float RevoluteJointGetReactionTorque(b2Joint* joint, float v);
		[LinkName("b2JointRevoluteJoint_GetMotorTorque")] public static extern float RevoluteJointGetMotorTorque(b2Joint* joint, float v);

		/// A prismatic joint. This joint provides one degree of freedom: translation
		/// along an axis fixed in bodyA. Relative rotation is prevented. You can
		/// use a joint limit to restrict the range of motion and a joint motor to
		/// drive the motion or to model joint friction.
		[LinkName("b2JointPrismaticJoint_GetReactionForce")] public static extern b2Vec2 PrismaticJointGetReactionForce(b2Joint* joint, float v);
		[LinkName("b2JointPrismaticJoint_GetReactionTorque")] public static extern float PrismaticJointGetReactionTorque(b2Joint* joint, float v);
		[LinkName("b2JointPrismaticJoint_GetLocalAnchorA")] public static extern b2Vec2 PrismaticJointGetLocalAnchorA(b2Joint* joint);
		[LinkName("b2JointPrismaticJoint_GetLocalAnchorB")] public static extern b2Vec2 PrismaticJointGetLocalAnchorB(b2Joint* joint);
		[LinkName("b2JointPrismaticJoint_GetLocalAxisA")] public static extern b2Vec2 PrismaticJointGetLocalAxisA(b2Joint* joint);
		[LinkName("b2JointPrismaticJoint_GetReferenceAngle")] public static extern float PrismaticJointGetReferenceAngle(b2Joint* joint);
		[LinkName("b2JointPrismaticJoint_GetJointTranslation")] public static extern float PrismaticJointGetJointTranslation(b2Joint* joint);
		[LinkName("b2JointPrismaticJoint_GetJointSpeed")] public static extern float PrismaticJointGetJointSpeed(b2Joint* joint);
		[LinkName("b2JointPrismaticJoint_IsLimitEnabled")] public static extern bool PrismaticJointIsLimitEnabled(b2Joint* joint);
		[LinkName("b2JointPrismaticJoint_EnableLimit")] public static extern void PrismaticJointEnableLimit(b2Joint* joint, bool v);
		[LinkName("b2JointPrismaticJoint_GetLowerLimit")] public static extern float PrismaticJointGetLowerLimit(b2Joint* joint);
		[LinkName("b2JointPrismaticJoint_GetUpperLimit")] public static extern float PrismaticJointGetUpperLimit(b2Joint* joint);
		[LinkName("b2JointPrismaticJoint_SetLimits")] public static extern void PrismaticJointSetLimits(b2Joint* joint, float l, float u);
		[LinkName("b2JointPrismaticJoint_IsMotorEnabled")] public static extern bool PrismaticJointIsMotorEnabled(b2Joint* joint);
		[LinkName("b2JointPrismaticJoint_EnableMotor")] public static extern void PrismaticJointEnableMotor(b2Joint* joint, bool v);
		[LinkName("b2JointPrismaticJoint_SetMotorSpeed")] public static extern void PrismaticJointSetMotorSpeed(b2Joint* joint, float v);
		[LinkName("b2JointPrismaticJoint_GetMotorSpeed")] public static extern float PrismaticJointGetMotorSpeed(b2Joint* joint);
		[LinkName("b2JointPrismaticJoint_SetMaxMotorForce")] public static extern void PrismaticJointSetMaxMotorForce(b2Joint* joint, float v);
		[LinkName("b2JointPrismaticJoint_GetMaxMotorForce")] public static extern float PrismaticJointGetMaxMotorForce(b2Joint* joint);
		[LinkName("b2JointPrismaticJoint_GetMotorForce")] public static extern float PrismaticJointGetMotorForce(b2Joint* joint, float v);

		/// A distance joint constrains two points on two bodies to remain at a fixed
		/// distance from each other. You can view this as a massless, rigid rod.
		[LinkName("b2JointDistanceJoint_GetReactionForce")] public static extern b2Vec2 DistanceJointGetReactionForce(b2Joint* joint, float v);
		[LinkName("b2JointDistanceJoint_GetReactionTorque")] public static extern float DistanceJointGetReactionTorque(b2Joint* joint, float v);
		[LinkName("b2JointDistanceJoint_GetLocalAnchorA")] public static extern b2Vec2 DistanceJointGetLocalAnchorA(b2Joint* joint);
		[LinkName("b2JointDistanceJoint_GetLocalAnchorB")] public static extern b2Vec2 DistanceJointGetLocalAnchorB(b2Joint* joint);
		[LinkName("b2JointDistanceJoint_GetLength")] public static extern float DistanceJointGetLength(b2Joint* joint);
		[LinkName("b2JointDistanceJoint_SetLength")] public static extern float DistanceJointSetLength(b2Joint* joint, float v);
		[LinkName("b2JointDistanceJoint_GetMinLength")] public static extern float DistanceJointGetMinLength(b2Joint* joint);
		[LinkName("b2JointDistanceJoint_SetMinLength")] public static extern float DistanceJointSetMinLength(b2Joint* joint, float v);
		[LinkName("b2JointDistanceJoint_GetMaxLength")] public static extern float DistanceJointGetMaxLength(b2Joint* joint);
		[LinkName("b2JointDistanceJoint_SetMaxLength")] public static extern float DistanceJointSetMaxLength(b2Joint* joint, float v);
		[LinkName("b2JointDistanceJoint_GetCurrentLength")] public static extern float DistanceJointGetCurrentLength(b2Joint* joint);
		[LinkName("b2JointDistanceJoint_SetStiffness")] public static extern void DistanceJointSetStiffness(b2Joint* joint, float v);
		[LinkName("b2JointDistanceJoint_GetStiffness")] public static extern float DistanceJointGetStiffness(b2Joint* joint);
		[LinkName("b2JointDistanceJoint_SetDamping")] public static extern void DistanceJointSetDamping(b2Joint* joint, float v);
		[LinkName("b2JointDistanceJoint_GetDamping")] public static extern float DistanceJointGetDamping(b2Joint* joint);

		/// The pulley joint is connected to two bodies and two fixed ground points.
		/// The pulley supports a ratio such that:
		/// length1 + ratio * length2 <= constant
		/// Yes, the force transmitted is scaled by the ratio.
		/// Warning: the pulley joint can get a bit squirrelly by itself. They often
		/// work better when combined with prismatic joints. You should also cover the
		/// the anchor points with static shapes to prevent one side from going to
		/// zero length.
		[LinkName("b2JointPulleyJoint_GetReactionForce")] public static extern b2Vec2 PulleyJointGetReactionForce(b2Joint* joint, float v);
		[LinkName("b2JointPulleyJoint_GetReactionTorque")] public static extern float PulleyJointGetReactionTorque(b2Joint* joint, float v);
		[LinkName("b2JointPulleyJoint_GetGroundAnchorA")] public static extern b2Vec2 PulleyJointGetGroundAnchorA(b2Joint* joint);
		[LinkName("b2JointPulleyJoint_GetGroundAnchorB")] public static extern b2Vec2 PulleyJointGetGroundAnchorB(b2Joint* joint);
		[LinkName("b2JointPulleyJoint_GetLengthA")] public static extern float PulleyJointGetLengthA(b2Joint* joint);
		[LinkName("b2JointPulleyJoint_GetLengthB")] public static extern float PulleyJointGetLengthB(b2Joint* joint);
		[LinkName("b2JointPulleyJoint_GetRatio")] public static extern float PulleyJointGetRatio(b2Joint* joint);
		[LinkName("b2JointPulleyJoint_GetCurrentLengthA")] public static extern float PulleyJointGetCurrentLengthA(b2Joint* joint);
		[LinkName("b2JointPulleyJoint_GetCurrentLengthB")] public static extern float PulleyJointGetCurrentLengthB(b2Joint* joint);

		/// A mouse joint is used to make a point on a body track a
		/// specified world point. This a soft constraint with a maximum
		/// force. This allows the constraint to stretch and without
		/// applying huge forces.
		/// NOTE: this joint is not documented in the manual because it was
		/// developed to be used in the testbed. If you want to learn how to
		/// use the mouse joint, look at the testbed.
		[LinkName("b2JointMouseJoint_GetReactionForce")] public static extern b2Vec2 MouseJointGetReactionForce(b2Joint* joint, float v);
		[LinkName("b2JointMouseJoint_GetReactionTorque")] public static extern float MouseJointGetReactionTorque(b2Joint* joint, float v);
		[LinkName("b2JointMouseJoint_SetTarget")] public static extern void MouseJointSetTarget(b2Joint* joint, ref b2Vec2 v);
		[LinkName("b2JointMouseJoint_GetTarget")] public static extern b2Vec2 MouseJointGetTarget(b2Joint* joint);
		[LinkName("b2JointMouseJoint_SetMaxForce")] public static extern void MouseJointSetMaxForce(b2Joint* joint, float v);
		[LinkName("b2JointMouseJoint_GetMaxForce")] public static extern float MouseJointGetMaxForce(b2Joint* joint);
		[LinkName("b2JointMouseJoint_SetStiffness")] public static extern void MouseJointSetStiffness(b2Joint* joint, float v);
		[LinkName("b2JointMouseJoint_GetStiffness")] public static extern float MouseJointGetStiffness(b2Joint* joint);
		[LinkName("b2JointMouseJoint_SetDamping")] public static extern void MouseJointSetDamping(b2Joint* joint, float v);
		[LinkName("b2JointMouseJoint_GetDamping")] public static extern float MouseJointGetDamping(b2Joint* joint);

		/// A gear joint is used to connect two joints together. Either joint
		/// can be a revolute or prismatic joint. You specify a gear ratio
		/// to bind the motions together:
		/// coordinate1 + ratio * coordinate2 = constant
		/// The ratio can be negative or positive. If one joint is a revolute joint
		/// and the other joint is a prismatic joint, then the ratio will have units
		/// of length or units of 1/length.
		/// @warning You have to manually destroy the gear joint if joint1 or joint2
		/// is destroyed.
		[LinkName("b2JointGearJoint_GetReactionForce")] public static extern b2Vec2 GearJointGetReactionForce(b2Joint* joint, float v);
		[LinkName("b2JointGearJoint_GetReactionTorque")] public static extern float GearJointGetReactionTorque(b2Joint* joint, float v);
		[LinkName("b2JointGearJoint_GetJoint1")] public static extern b2Joint* GearJointGetJoint1(b2Joint* joint);
		[LinkName("b2JointGearJoint_GetJoint2")] public static extern b2Joint* GearJointGetJoint2(b2Joint* joint);
		[LinkName("b2JointGearJoint_SetRatio")] public static extern void GearJointSetRatio(b2Joint* joint, float v);
		[LinkName("b2JointGearJoint_GetRatio")] public static extern float GearJointGetRatio(b2Joint* joint);

		/// A wheel joint. This joint provides two degrees of freedom: translation
		/// along an axis fixed in bodyA and rotation in the plane. In other words, it is a point to
		/// line constraint with a rotational motor and a linear spring/damper. The spring/damper is
		/// initialized upon creation. This joint is designed for vehicle suspensions.
		[LinkName("b2JointWheelJoint_GetReactionForce")] public static extern b2Vec2 WheelJointGetReactionForce(b2Joint* joint, float v);
		[LinkName("b2JointWheelJoint_GetReactionTorque")] public static extern float WheelJointGetReactionTorque(b2Joint* joint, float v);
		[LinkName("b2JointWheelJoint_GetLocalAnchorA")] public static extern b2Vec2 WheelJointGetLocalAnchorA(b2Joint* joint);
		[LinkName("b2JointWheelJoint_GetLocalAnchorB")] public static extern b2Vec2 WheelJointGetLocalAnchorB(b2Joint* joint);
		[LinkName("b2JointWheelJoint_GetLocalAxisA")] public static extern b2Vec2 WheelJointGetLocalAxisA(b2Joint* joint);
		[LinkName("b2JointWheelJoint_GetJointTranslation")] public static extern float WheelJointGetJointTranslation(b2Joint* joint);
		[LinkName("b2JointWheelJoint_GetJointLinearSpeed")] public static extern float WheelJointGetJointLinearSpeed(b2Joint* joint);
		[LinkName("b2JointWheelJoint_GetJointAngularSpeed")] public static extern float WheelJointGetJointAngularSpeed(b2Joint* joint);
		[LinkName("b2JointWheelJoint_GetJointAngle")] public static extern float WheelJointGetJointAngle(b2Joint* joint);
		[LinkName("b2JointWheelJoint_IsLimitEnabled")] public static extern bool WheelJointIsLimitEnabled(b2Joint* joint);
		[LinkName("b2JointWheelJoint_EnableLimit")] public static extern void WheelJointEnableLimit(b2Joint* joint, bool v);
		[LinkName("b2JointWheelJoint_GetLowerLimit")] public static extern float WheelJointGetLowerLimit(b2Joint* joint);
		[LinkName("b2JointWheelJoint_GetUpperLimit")] public static extern float WheelJointGetUpperLimit(b2Joint* joint);
		[LinkName("b2JointWheelJoint_SetLimits")] public static extern void WheelJointSetLimits(b2Joint* joint, float l, float u);
		[LinkName("b2JointWheelJoint_IsMotorEnabled")] public static extern bool WheelJointIsMotorEnabled(b2Joint* joint);
		[LinkName("b2JointWheelJoint_EnableMotor")] public static extern void WheelJointEnableMotor(b2Joint* joint, bool v);
		[LinkName("b2JointWheelJoint_SetMotorSpeed")] public static extern void WheelJointSetMotorSpeed(b2Joint* joint, float v);
		[LinkName("b2JointWheelJoint_GetMotorSpeed")] public static extern float WheelJointGetMotorSpeed(b2Joint* joint);
		[LinkName("b2JointWheelJoint_SetMaxMotorTorque")] public static extern void WheelJointSetMaxMotorTorque(b2Joint* joint, float v);
		[LinkName("b2JointWheelJoint_GetMaxMotorTorque")] public static extern float WheelJointGetMaxMotorTorque(b2Joint* joint);
		[LinkName("b2JointWheelJoint_GetMotorTorque")] public static extern float WheelJointGetMotorTorque(b2Joint* joint, float v);
		[LinkName("b2JointWheelJoint_SetStiffness")] public static extern void WheelJointSetStiffness(b2Joint* joint, float v);
		[LinkName("b2JointWheelJoint_GetStiffness")] public static extern float WheelJointGetStiffness(b2Joint* joint);
		[LinkName("b2JointWheelJoint_SetDamping")] public static extern void WheelJointSetDamping(b2Joint* joint, float v);
		[LinkName("b2JointWheelJoint_GetDamping")] public static extern float WheelJointGetDamping(b2Joint* joint);

		/// A weld joint essentially glues two bodies together. A weld joint may
		/// distort somewhat because the island constraint solver is approximate.
		[LinkName("b2JointWeldJoint_GetReactionForce")] public static extern b2Vec2 WeldJointGetReactionForce(b2Joint* joint, float v);
		[LinkName("b2JointWeldJoint_GetReactionTorque")] public static extern float WeldJointGetReactionTorque(b2Joint* joint, float v);
		[LinkName("b2JointWeldJoint_GetLocalAnchorA")] public static extern b2Vec2 WeldJointGetLocalAnchorA(b2Joint* joint);
		[LinkName("b2JointWeldJoint_GetLocalAnchorB")] public static extern b2Vec2 WeldJointGetLocalAnchorB(b2Joint* joint);
		[LinkName("b2JointWeldJoint_GetReferenceAngle")] public static extern float WeldJointGetReferenceAngle(b2Joint* joint);
		[LinkName("b2JointWeldJoint_SetStiffness")] public static extern void WeldJointSetStiffness(b2Joint* joint, float v);
		[LinkName("b2JointWeldJoint_GetStiffness")] public static extern float WeldJointGetStiffness(b2Joint* joint);
		[LinkName("b2JointWeldJoint_SetDamping")] public static extern void WeldJointSetDamping(b2Joint* joint, float v);
		[LinkName("b2JointWeldJoint_GetDamping")] public static extern float WeldJointGetDamping(b2Joint* joint);

		/// Friction joint. This is used for top-down friction.
		/// It provides 2D translational friction and angular friction.
		[LinkName("b2JointFrictionJoint_GetReactionForce")] public static extern b2Vec2 FrictionJointGetReactionForce(b2Joint* joint, float v);
		[LinkName("b2JointFrictionJoint_GetReactionTorque")] public static extern float FrictionJointGetReactionTorque(b2Joint* joint, float v);
		[LinkName("b2JointFrictionJoint_GetLocalAnchorA")] public static extern b2Vec2 FrictionJointGetLocalAnchorA(b2Joint* joint);
		[LinkName("b2JointFrictionJoint_GetLocalAnchorB")] public static extern b2Vec2 FrictionJointGetLocalAnchorB(b2Joint* joint);
		[LinkName("b2JointFrictionJoint_SetMaxForce")] public static extern void FrictionJointSetMaxForce(b2Joint* joint, float v);
		[LinkName("b2JointFrictionJoint_GetMaxForce")] public static extern float FrictionJointGetMaxForce(b2Joint* joint);
		[LinkName("b2JointFrictionJoint_SetMaxTorque")] public static extern void FrictionJointSetMaxTorque(b2Joint* joint, float v);
		[LinkName("b2JointFrictionJoint_GetMaxTorque")] public static extern float FrictionJointGetMaxTorque(b2Joint* joint);

		/// A motor joint is used to control the relative motion
		/// between two bodies. A typical usage is to control the movement
		/// of a dynamic body with respect to the ground.
		[LinkName("b2JointMotorJoint_GetReactionForce")] public static extern b2Vec2 MotorJointGetReactionForce(b2Joint* joint, float v);
		[LinkName("b2JointMotorJoint_GetReactionTorque")] public static extern float MotorJointGetReactionTorque(b2Joint* joint, float v);
		[LinkName("b2JointMotorJoint_SetLinearOffset")] public static extern void MotorJointSetLinearOffset(b2Joint* joint, ref b2Vec2 v);
		[LinkName("b2JointMotorJoint_GetLinearOffset")] public static extern b2Vec2 MotorJointGetLinearOffset(b2Joint* joint);
		[LinkName("b2JointMotorJoint_SetAngularOffset")] public static extern void MotorJointSetAngularOffset(b2Joint* joint, float v);
		[LinkName("b2JointMotorJoint_GetAngularOffset")] public static extern float MotorJointGetAngularOffset(b2Joint* joint);
		[LinkName("b2JointMotorJoint_SetMaxForce")] public static extern void MotorJointSetMaxForce(b2Joint* joint, float v);
		[LinkName("b2JointMotorJoint_GetMaxForce")] public static extern float MotorJointGetMaxForce(b2Joint* joint);
		[LinkName("b2JointMotorJoint_SetMaxTorque")] public static extern void MotorJointSetMaxTorque(b2Joint* joint, float v);
		[LinkName("b2JointMotorJoint_GetMaxTorque")] public static extern float MotorJointGetMaxTorque(b2Joint* joint);
		[LinkName("b2JointMotorJoint_SetCorrectionFactor")] public static extern void MotorJointSetCorrectionFactor(b2Joint* joint, float v);
		[LinkName("b2JointMotorJoint_GetCorrectionFactor")] public static extern float MotorJointGetCorrectionFactor(b2Joint* joint);
	}
}