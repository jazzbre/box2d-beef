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

		public this()
		{
			s = 0.0f;
			c = 1.0f;
		}

		public this(float _s, float _c)
		{
			s = _s;
			c = _c;
		}

		public const b2Rot Identity = .(0.0f, 1.0f);

		/// Get the angle in radians
		public float Angle => Math.Atan2(s, c);

		/// Get the x-axis
		public b2Vec2 XAxis => .(c, s);

		/// Get the u-axis
		public b2Vec2 YAxis => .(-s, c);

		/// Set using an angle in radians.
		public void SetAngle(float angle) mut
		{
			s = Math.Sin(angle);
			c = Math.Cos(angle);
		}

		public b2Vec2 Rotate(b2Vec2 v)
		{
			return .(c * v.x - s * v.y, s * v.x + c * v.y);
		}

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
	struct b2ParticleColor
	{
		public uint8 r, g, b, a;
	}

	/// This describes the motion of a body/shape for TOI computation.
	/// Shapes are defined with respect to the body origin, which may
	/// no coincide with the center of mass. However, to support dynamics
	/// we must interpolate the center of mass position.
	[CRepr]
	struct b2Sweep
	{
		/// Get the interpolated transform at a specific time.
		/// @param transform the output transform
		/// @param beta is a factor in [0,1], where 0 indicates alpha0.
		public void GetTransform(ref b2Transform transform, float beta)
		{
			transform.p = (1.0f - beta) * c0 + beta * c;
			float angle = (1.0f - beta) * a0 + beta * a;
			transform.q.SetAngle(angle);

			// Shift to origin
			transform.p -= transform.q.Rotate(localCenter);
		}

		/// Advance the sweep forward, yielding a new initial state.
		/// @param alpha the new initial time.
		public void Advance(float alpha) mut
		{
			float beta = (alpha - alpha0) / (1.0f - alpha0);
			c0 += beta * (c - c0);
			a0 += beta * (a - a0);
			alpha0 = alpha;
		}

		/// Normalize the angles.
		public void Normalize() mut
		{
			float twoPi = 2.0f * Math.PI_f;
			float d = twoPi * Math.Floor(a0 / twoPi);
			a0 -= d;
			a -= d;
		}

		public b2Vec2 localCenter;///< local center of mass position
		public b2Vec2 c0, c;///< center world positions
		public float a0, a;///< world angles

		/// Fraction of the current time step in the range [0,1]
		/// c0 and a0 are the positions at alpha0.
		public float alpha0;
	}

	struct b2World { }
	struct b2Body { }
	struct b2Joint { }
	struct b2Shape { }
	struct b2Fixture { }
	struct b2Contact { }
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
}
