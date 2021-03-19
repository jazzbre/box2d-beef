using System;
using Box2D;

namespace example
{
	class Program
	{
		static int Main()
		{
			InitBox2D();
			UpdateBox2D();
			return 0;
		}

		static b2World* world;

		static void InitParticles()
		{
			b2ParticleSystemDef particleSystemDef = .();
			var m_particleSystem = World.CreateParticleSystem(world, &particleSystemDef);
			{
				b2BodyDef bd = .();
				b2Body* ground = World.CreateBody(world, &bd);
				{
					var shape = Shape.CreatePolygon();
					var vertices = b2Vec2[4](
						b2Vec2(-4, -1),
						b2Vec2(4, -1),
						b2Vec2(4, 0),
						b2Vec2(-4, 0)
						);
					Shape.PolygonSet(shape, &vertices[0], 4);
					Body.CreateFixture(ground, shape, 0.0f);
				}
				{
					var shape = Shape.CreatePolygon();
					var vertices = b2Vec2[4](
						b2Vec2(-4, -0.1f),
						b2Vec2(-2, -0.1f),
						b2Vec2(-2, 2),
						b2Vec2(-4, 3)
						);
					Shape.PolygonSet(shape, &vertices[0], 4);
					Body.CreateFixture(ground, shape, 0.0f);
				}
				{
					var shape = Shape.CreatePolygon();
					var vertices = b2Vec2[4](
						b2Vec2(2, -0.1f),
						b2Vec2(4, -0.1f),
						b2Vec2(4, 3),
						b2Vec2(2, 2)
						);
					Shape.PolygonSet(shape, &vertices[0], 4);
					Body.CreateFixture(ground, shape, 0.0f);
				}
			}

			Box2D.ParticleSystem.SetRadius(m_particleSystem, 0.035f);
			const uint32 particleType = 0;
			Box2D.ParticleSystem.SetDamping(m_particleSystem, 0.2f);
			{
				var shape = Shape.CreateCircle();
				b2Vec2 position = .(0, 3);
				Shape.CircleSetPosition(shape, ref position);
				Shape.SetRadius(shape, 2.0f);
				b2ParticleGroupDef pd = .();
				pd.flags = particleType;
				pd.shape = shape;
				Box2D.ParticleSystem.CreateParticleGroup(m_particleSystem, &pd);
			}
			{
				b2BodyDef bd = .();
				bd.type = .b2_dynamicBody;
				b2Body* body = World.CreateBody(world, &bd);
				var shape = Shape.CreateCircle();
				b2Vec2 position = .(0, 8);
				Shape.CircleSetPosition(shape, ref position);
				Shape.SetRadius(shape, 0.5f);
				Body.CreateFixture(body, shape, 0.5f);
			}
		}

		static void InitDominos()
		{
			b2Body* b1;
			{
				var shape = Shape.CreateEdge();
				b2Vec2 a = .(-40.0f, 0.0f);
				b2Vec2 b = .(40.0f, 0.0f);
				Shape.EdgeSetTwoSided(shape, ref a, ref b);

				b2BodyDef bd = .();
				b1 = World.CreateBody(world, &bd);
				Body.CreateFixture(b1, shape, 0.0f);
			}
			{
				var shape = Shape.CreatePolygon();
				Shape.PolygonSetAsBox(shape, 6.0f, 0.25f);

				b2BodyDef bd = .();
				bd.position = .(-1.5f, 10.0f);
				b2Body* ground = World.CreateBody(world, &bd);
				Body.CreateFixture(ground, shape, 0.0f);
			}
			{
				var shape = Shape.CreatePolygon();
				Shape.PolygonSetAsBox(shape, 0.1f, 1.0f);

				b2FixtureDef fd = .();
				fd.shape = shape;
				fd.density = 20.0f;
				fd.friction = 0.1f;

				for (int i = 0; i < 10; ++i)
				{
					b2BodyDef bd = .();
					bd.type = .b2_dynamicBody;
					bd.position = .(-6.0f + 1.0f * i, 11.25f);
					var body = World.CreateBody(world, &bd);
					Body.CreateFixture(body, &fd);
				}
			}
			{
				var shape = Shape.CreatePolygon();
				var zero = b2Vec2.Zero;
				Shape.PolygonSetAsBoxWithCenterAngle(shape, 7.0f, 0.25f, ref zero, 0.3f);

				b2BodyDef bd = .();
				bd.position = .(1.0f, 6.0f);
				var ground = World.CreateBody(world, &bd);
				Body.CreateFixture(ground, shape, 0.0f);
			}

			b2Body* b2;
			{
				var shape = Shape.CreatePolygon();
				Shape.PolygonSetAsBox(shape, 0.25f, 1.5f);

				b2BodyDef bd = .();
				bd.position = .(-7.0f, 4.0f);
				b2 = World.CreateBody(world, &bd);
				Body.CreateFixture(b2, shape, 0.0f);
			}

			b2Body* b3;
			{
				var shape = Shape.CreatePolygon();
				Shape.PolygonSetAsBox(shape, 6.0f, 0.125f);

				b2BodyDef bd = .();
				bd.type = .b2_dynamicBody;
				bd.position = .(-0.9f, 1.0f);
				bd.angle = -0.15f;

				b3 = World.CreateBody(world, &bd);
				Body.CreateFixture(b3, shape, 10.0f);
			}

			b2RevoluteJointDef jd = .();
			b2Vec2 anchor;

			anchor = .(-2.0f, 1.0f);
			jd.Initialize(b1, b3, ref anchor);
			jd.collideConnected = true;
			World.CreateJoint(world, &jd);

			b2Body* b4;
			{
				var shape = Shape.CreatePolygon();
				Shape.PolygonSetAsBox(shape, 0.25f, 0.25f);

				b2BodyDef bd = .();
				bd.type = .b2_dynamicBody;
				bd.position = .(-10.0f, 15.0f);
				b4 = World.CreateBody(world, &bd);
				Body.CreateFixture(b4, shape, 10.0f);
			}

			anchor = .(-7.0f, 15.0f);
			jd.Initialize(b2, b4, ref anchor);
			World.CreateJoint(world, &jd);

			b2Body* b5;
			{
				b2BodyDef bd = .();
				bd.type = .b2_dynamicBody;
				bd.position = .(6.5f, 3.0f);
				b5 = World.CreateBody(world, &bd);

				var shape = Shape.CreatePolygon();
				b2FixtureDef fd = .();

				fd.shape = shape;
				fd.density = 10.0f;
				fd.friction = 0.1f;

				b2Vec2 centerA = .(0.0f, -0.9f);
				Shape.PolygonSetAsBoxWithCenterAngle(shape, 1.0f, 0.1f, ref centerA, 0.0f);
				Body.CreateFixture(b5, &fd);

				b2Vec2 centerB = .(-0.9f, 0.0f);
				Shape.PolygonSetAsBoxWithCenterAngle(shape, 0.1f, 1.0f, ref centerB, 0.0f);
				Body.CreateFixture(b5, &fd);

				b2Vec2 centerC = .(0.9f, 0.0f);
				Shape.PolygonSetAsBoxWithCenterAngle(shape, 0.1f, 1.0f, ref centerC, 0.0f);
				Body.CreateFixture(b5, &fd);
			}

			anchor = .(6.0f, 2.0f);
			jd.Initialize(b1, b5, ref anchor);
			World.CreateJoint(world, &jd);

			b2Body* b6;
			{
				var shape = Shape.CreatePolygon();
				Shape.PolygonSetAsBox(shape, 1.0f, 0.1f);

				b2BodyDef bd = .();
				bd.type = .b2_dynamicBody;
				bd.position = .(6.5f, 4.1f);
				b6 = World.CreateBody(world, &bd);
				Body.CreateFixture(b6, shape, 30.0f);
			}

			anchor = .(7.5f, 4.0f);
			jd.Initialize(b5, b6, ref anchor);
			World.CreateJoint(world, &jd);

			b2Body* b7;
			{
				var shape = Shape.CreatePolygon();
				Shape.PolygonSetAsBox(shape, 0.1f, 1.0f);

				b2BodyDef bd = .();
				bd.type = .b2_dynamicBody;
				bd.position = .(7.4f, 1.0f);

				b7 = World.CreateBody(world, &bd);
				Body.CreateFixture(b7, shape, 10.0f);
			}

			b2DistanceJointDef djd = .();
			djd.bodyA = b3;
			djd.bodyB = b7;
			djd.localAnchorA = .(6.0f, 0.0f);
			djd.localAnchorB = .(0.0f, -1.0f);
			b2Vec2 d = Body.GetWorldPoint(djd.bodyB, ref djd.localAnchorB) - Body.GetWorldPoint(djd.bodyA, ref
				djd.localAnchorA); djd.length = d.Length;

			Utility.LinearStiffness(ref djd.stiffness, ref djd.damping, 1.0f, 1.0f, djd.bodyA, djd.bodyB);
			World.CreateJoint(world, &djd);
			{
				float radius = 0.2f;

				var shape = Shape.CreateCircle();
				Shape.SetRadius(shape, radius);

				for (int32 i = 0; i < 4; ++i)
				{
					b2BodyDef bd = .();
					bd.type = .b2_dynamicBody;
					bd.position = .(5.9f + 2.0f * radius * i, 2.4f);
					b2Body* body = World.CreateBody(world, &bd);
					Body.CreateFixture(body, shape, 10.0f);
				}
			}
		}

		static void InitBox2D()
		{
			b2Vec2 gravity = .(0.0f, -10.0f);
			world = World.Create(ref gravity);
			// Select demo
			if (true)
			{
				InitParticles();
			} else
			{
				InitDominos();
			}

			b2Draw draw = .();
			draw.drawPolygonCallback = (vertices, vertexCount, color, userData) =>
				{
				};
			draw.drawSolidPolygonCallback = (vertices, vertexCount, color, userData) =>
				{
				};
			draw.drawCircleCallback = (center, radius, color, userData) =>
				{
				};
			draw.drawSolidCircleCallback = (center, radius, axis, color, userData) =>
				{
				};
			draw.drawSegmentCallback = (p1, p2, color, userData) =>
				{
				};
			draw.drawPointCallback = (p, size, color, userData) =>
				{
				};
			draw.drawTransformCallback = (xf, userData) =>
				{
				};
			draw.userData = Internal.UnsafeCastToPtr(world);

			World.SetDebugDraw(world, &draw);
			World.SetDebugDrawFlags(world, .e_aabbBit | .e_jointBit | .e_particleBit | .e_aabbBit);
		}

		static void UpdateBox2D()
		{
			World.Step(world, 1.0f / 60.0f, 8, 3, 3);
			World.DebugDraw(world);
		}
	}
}
