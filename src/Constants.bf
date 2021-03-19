using System;

namespace Box2D
{
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
