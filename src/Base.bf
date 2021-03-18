using System;

namespace Box2D
{
	enum b2DrawFlags
	{
		e_shapeBit = 0x0001,///< draw shapes
		e_jointBit = 0x0002,///< draw joint connections
		e_aabbBit = 0x0004,///< draw axis aligned bounding boxes
		e_pairBit = 0x0008,///< draw broad-phase pairs
		e_centerOfMassBit = 0x0010,///< draw center of mass frame
		e_particleBit = 0x0020///< draw particles
	}

	[CRepr]
	struct b2Vec2
	{
		public float x, y;

		public const b2Vec2 Zero = .(0.0f, 0.0f);
		public const b2Vec2 One = .(1.0f, 1.0f);

		public this()
		{
			x = y = 0.0f;
		}

		public this(float _x, float _y)
		{
			x = _x;
			y = _y;
		}

		public float Length
		{
			get
			{
				return (float)Math.Sqrt(x * x + y * y);
			}
		}

		public float LengthSquared
		{
			get
			{
				return x * x + y * y;
			}
		}

		public float Angle
		{
			get
			{
				return Math.Atan2(y, x);
			}
		}

		public static b2Vec2 Round(b2Vec2 vector)
		{
			return .(Math.Round(vector.x), Math.Round(vector.y));
		}

		public static b2Vec2 Floor(b2Vec2 vector)
		{
			return .(Math.Floor(vector.x), Math.Floor(vector.y));
		}

		public static b2Vec2 Ceiling(b2Vec2 vector)
		{
			return .(Math.Ceiling(vector.x), Math.Ceiling(vector.y));
		}

		public static b2Vec2 Min(b2Vec2 vec1, b2Vec2 vec2)
		{
			return .(Math.Min(vec1.x, vec2.x), Math.Min(vec1.y, vec2.y));
		}

		public static b2Vec2 Max(b2Vec2 vec1, b2Vec2 vec2)
		{
			return .(Math.Max(vec1.x, vec2.x), Math.Max(vec1.y, vec2.y));
		}

		public static b2Vec2 Abs(b2Vec2 vec1)
		{
			return .(Math.Abs(vec1.x), Math.Abs(vec1.y));
		}

		public static b2Vec2 Normalize(b2Vec2 vector)
		{
			b2Vec2 newVec;
			Normalize(vector, out newVec);
			return newVec;
		}

		public static void Normalize(b2Vec2 value, out b2Vec2 result)
		{
			float factor = value.Length;
			factor = 1f / factor;
			result.x = value.x * factor;
			result.y = value.y * factor;
		}

		public static b2Vec2 Lerp(b2Vec2 a, b2Vec2 b, float delta)
		{
			return a + (b - a) * delta;
		}

		public static b2Vec2 Lerp(b2Vec2 a, b2Vec2 b, b2Vec2 delta)
		{
			return a + (b - a) * delta;
		}

		public static b2Vec2 Reflect(b2Vec2 v, b2Vec2 n)
		{
			return v - 2 * Dot(v, n) * n;
		}

		public static float DistanceSquared(b2Vec2 value1, b2Vec2 value2)
		{
			return (value1.x - value2.x) * (value1.x - value2.x) + (value1.y - value2.y) * (value1.y - value2.y);
		}

		public static float Distance(b2Vec2 vector1, b2Vec2 vector2)
		{
			float result = DistanceSquared(vector1, vector2);
			return (float)Math.Sqrt(result);
		}

		public static float Dot(b2Vec2 vec1, b2Vec2 vec2)
		{
			return vec1.x * vec2.x + vec1.y * vec2.y;
		}

		public static float ScalarCross(b2Vec2 vector1, b2Vec2 vector2)
		{
			return vector1.x * vector2.y - vector1.y * vector2.x;
		}

		public static b2Vec2 FromAngle(float angle, float length = 1.0f)
		{
			return .((float)Math.Cos(angle) * length, (float)Math.Sin(angle) * length);
		}

		public static b2Vec2 operator-(b2Vec2 vec1)
		{
			return .(-vec1.x, -vec1.y);
		}

		public static b2Vec2 operator+(b2Vec2 vec1, b2Vec2 vec2)
		{
			return .(vec1.x + vec2.x, vec1.y + vec2.y);
		}

		public static b2Vec2 operator-(b2Vec2 vec1, b2Vec2 vec2)
		{
			return .(vec1.x - vec2.x, vec1.y - vec2.y);
		}

		public static b2Vec2 operator*(b2Vec2 vec1, b2Vec2 vec2)
		{
			return .(vec1.x * vec2.x, vec1.y * vec2.y);
		}

		public static b2Vec2 operator/(b2Vec2 vec1, b2Vec2 vec2)
		{
			return .(vec1.x / vec2.x, vec1.y / vec2.y);
		}

		[Commutable]
		public static b2Vec2 operator*(b2Vec2 vec, float scale)
		{
			return .(vec.x * scale, vec.y * scale);
		}

		public static b2Vec2 operator/(b2Vec2 vec, float scale)
		{
			return .(vec.x / scale, vec.y / scale);
		}

		public override void ToString(String str)
		{
			str.AppendF("{0:0.0#}, {1:0.0#}", x, y);
		}
	}

	[CRepr]
	struct b2Rot
	{
		public float s, c;
	}

	[CRepr]
	struct b2AABB
	{
		public b2Vec2 lowerBound;
		public b2Vec2 upperBound;
	}

	[CRepr]
	struct b2Transform
	{
		public b2Vec2 p;
		public b2Rot q;
	}

	[CRepr]
	struct b2Color
	{
		public float r, g, b, a;
	}

	[CRepr]
	struct b2Filter
	{
		public uint16 categoryBits = 1;
		public uint16 maskBits = 0xffff;
		public int16 groupIndex = 0;
	}

	[CRepr]
	struct b2MassData
	{
		/// The mass of the shape, usually in kilograms.
		public float mass;

		/// The position of the shape's centroid relative to the shape's origin.
		public b2Vec2 center;

		/// The rotational inertia of the shape about the local origin.
		public float I;
	}

	[CRepr]
	struct b2RayCastInput
	{
		public b2Vec2 p1, p2;
		public float maxFraction;
	}

	[CRepr]
	struct b2RayCastOutput
	{
		public b2Vec2 normal;
		public float fraction;
	}

	[CRepr]
	struct b2ParticleColor
	{
		public uint8 r, g, b, a;
	}

	struct b2World { }
	struct b2Body { }
	struct b2Joint { }
	struct b2Shape { }
	struct b2Fixture { }
	struct b2Contact { }
	struct b2Manifold { }
	struct b2ContactImpulse { }
	struct b2ParticleGroup { }
	struct b2ParticleSystem { }
	struct b2ParticleContact { }
	struct b2ParticleBodyContact { }
	struct b2JointEdge { }
	struct b2ContactEdge { }
	struct b2Rope { }
	typealias b2BodyUserData = void*;
	typealias b2FixtureUserData = void*;
	typealias b2JointUserData = void*;

	static class Constants
	{
		public const float b2_lengthUnitsPerMeter = 1.0f;

		/// The maximum number of contact points between two convex shapes. Do
		/// not change this value.
		public const int b2_maxManifoldPoints = 2;

		/// This is used to fatten AABBs in the dynamic tree. This allows proxies
		/// to move by a small amount without triggering a tree adjustment.
		/// This is in meters.
		public const float b2_aabbExtension = (0.1f * b2_lengthUnitsPerMeter);

		/// This is used to fatten AABBs in the dynamic tree. This is used to predict
		/// the future position based on the current displacement.
		/// This is a dimensionless multiplier.
		public const float b2_aabbMultiplier = 4.0f;

		/// A small length used as a collision and constraint tolerance. Usually it is
		/// chosen to be numerically significant, but visually insignificant. In meters.
		public const float b2_linearSlop = (0.005f * b2_lengthUnitsPerMeter);

		/// A small angle used as a collision and constraint tolerance. Usually it is
		/// chosen to be numerically significant, but visually insignificant.
		public const float b2_angularSlop = (2.0f / 180.0f * Math.PI_f);

		/// The radius of the polygon/edge shape skin. This should not be modified. Making
		/// this smaller means polygons will have an insufficient buffer for continuous collision.
		/// Making it larger may create artifacts for vertex collision.
		public const float b2_polygonRadius = (2.0f * b2_linearSlop);

		/// Maximum number of sub-steps per contact in continuous physics simulation.
		public const int b2_maxSubSteps = 8;


		// Dynamics

		/// Maximum number of contacts to be handled to solve a TOI impact.
		public const int b2_maxTOIContacts = 32;

		/// The maximum linear position correction used when solving constraints. This helps to
		/// prevent overshoot. Meters.
		public const float b2_maxLinearCorrection = (0.2f * b2_lengthUnitsPerMeter);

		/// The maximum angular position correction used when solving constraints. This helps to
		/// prevent overshoot.
		public const float b2_maxAngularCorrection = (8.0f / 180.0f * Math.PI_f);

		/// The maximum linear translation of a body per step. This limit is very large and is used
		/// to prevent numerical problems. You shouldn't need to adjust this. Meters.
		public const float b2_maxTranslation = (2.0f * b2_lengthUnitsPerMeter);
		public const float b2_maxTranslationSquared = (b2_maxTranslation * b2_maxTranslation);

		/// The maximum angular velocity of a body. This limit is very large and is used
		/// to prevent numerical problems. You shouldn't need to adjust this.
		public const float b2_maxRotation = (0.5f * Math.PI_f);
		public const float b2_maxRotationSquared = (b2_maxRotation * b2_maxRotation);

		/// This scale factor controls how fast overlap is resolved. Ideally this would be 1 so
		/// that overlap is removed in one time step. However using values close to 1 often lead
		/// to overshoot.
		public const float b2_baumgarte = 0.2f;
		public const float b2_toiBaumgarte = 0.75f;


		// Sleep

		/// The time that a body must be still before it will go to sleep.
		public const float b2_timeToSleep = 0.5f;

		/// A body cannot sleep if its linear velocity is above this tolerance.
		public const float b2_linearSleepTolerance = (0.01f * b2_lengthUnitsPerMeter);

		/// A body cannot sleep if its angular velocity is above this tolerance.
		public const float b2_angularSleepTolerance = (2.0f / 180.0f * Math.PI_f);
	}
}
