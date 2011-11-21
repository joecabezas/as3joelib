package com.as3joelib.box2d.dynamics.joints
{
	import Box2D.Common.b2Settings;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2TimeStep;
	import Box2D.Dynamics.b2World;
	import Box2D.Dynamics.Joints.b2DistanceJoint;
	import Box2D.Dynamics.Joints.b2DistanceJointDef;
	import Box2D.Dynamics.Joints.b2Joint;
	
	/**
	 * ...
	 * @author Joe Cabezas
	 */
	
	//implementation from:
	// http://jbox2d.svn.sourceforge.net/viewvc/jbox2d/trunk/src/org/jbox2d/dynamics/joints/ConstantVolumeJoint.java?view=markup
	public class ConstantVolumeJoint extends b2Joint
	{
		//settings that are not in b2Settings
		public static const EPSILON:Number = 1.1920928955078125E-7;
		
		//Body[] bodies;
		public var bodies:Vector.<b2Body>;
		
		//float[] targetLengths;
		public var targetLengths:Vector.<Number>;
		
		//float targetVolume;
		public var targetVolume:Number;
		
		//World world;
		public var world:b2World;
		
		//Vec2[] normals;
		public var normals:Vector.<b2Vec2> = new Vector.<b2Vec2>;
		
		//TimeStep m_step;
		public var m_step:b2TimeStep;
		
		//private float m_impulse = 0.0f;
		private var m_impulse:Number = 0;
		
		//DistanceJoint[] distanceJoints;
		private var distanceJoints:Vector.<b2DistanceJoint>;
		
		public function getBodies():Vector.<b2Body>
		{
			return this.bodies;
		}
		
		public function inflate(factor:Number):void
		{
			this.targetVolume *= factor;
		}
		
		public function ConstantVolumeJoint(def:ConstantVolumeJointDef)
		{
			super(def);
			if (def.bodies.length <= 2)
			{
				throw new ArgumentError("You cannot create a constant volume joint with less than three bodies.");
			}
			
			this.world = def.bodies[0].GetWorld();
			
			this.bodies = def.bodies;
			
			this.targetLengths = new Vector.<Number>(this.bodies.length);
			
			for (var i:int = 0; i < this.targetLengths.length; ++i)
			{
				var next:int = (i == this.targetLengths.length - 1) ? 0 : i + 1;
				
				var centro_actual:b2Vec2 = this.bodies[i].GetWorldCenter();
				var centro_siguiente:b2Vec2 = this.bodies[next].GetWorldCenter();
				
				centro_actual.Subtract(centro_siguiente);
				var dist:Number = centro_actual.Length();
				
				this.targetLengths[i] = dist;
			}
			
			targetVolume = this.getArea();
			
			this.distanceJoints = new Vector.<b2DistanceJoint>(bodies.length);
			
			for (var i:int = 0; i < this.targetLengths.length; ++i)
			{
				var next:int = (i == this.targetLengths.length - 1) ? 0 : i + 1;
				
				var djd:b2DistanceJointDef = new b2DistanceJointDef();
				djd.frequencyHz = def.frequencyHz; //20.0f;
				djd.dampingRatio = def.dampingRatio; //50.0f;
				djd.Initialize(this.bodies[i], this.bodies[next], this.bodies[i].GetWorldCenter(), this.bodies[next].GetWorldCenter());
				
				this.distanceJoints[i] = this.world.CreateJoint(djd) as b2DistanceJoint;
			}
			
			var normals:Vector.<b2Vec2> = new Vector.<b2Vec2>(bodies.length);
			
			for (var i:int = 0; i < normals.length; ++i)
			{
				normals[i] = new b2Vec2();
			}
			
			this.m_body1 = bodies[0];
			this.m_body2 = bodies[1];
			this.m_collideConnected = false;
		}
		
		//override public function Destroy():void
		//{
			//for (var i:int = 0; i < this.distanceJoints.length; ++i)
			//{
				//this.world.destroyJoint(this.distanceJoints[i]);
			//}
		//}
		
		private function getArea():Number
		{
			var area:Number = 0;
			
			// i'm glad i changed these all to member access
			area += this.bodies[this.bodies.length - 1].GetWorldCenter().x * this.bodies[0].GetWorldCenter().y - this.bodies[0].GetWorldCenter().x * this.bodies[this.bodies.length - 1].GetWorldCenter().y;
			for (var i:int = 0; i < this.bodies.length - 1; ++i)
			{
				area += this.bodies[i].GetWorldCenter().x * this.bodies[i + 1].GetWorldCenter().y - this.bodies[i + 1].GetWorldCenter().x * this.bodies[i].GetWorldCenter().y;
			}
			area *= 0.5;
			return area;
		}
		
		/**
		 * Apply the position correction to the particles.
		 * @param step
		 */
		public function constrainEdges(step:b2TimeStep):Boolean
		{
			var perimeter:Number = 0;
			for (var i:int = 0; i < this.bodies.length; ++i)
			{
				var next:int = (i == this.bodies.length - 1) ? 0 : i + 1;
				var dx:Number = this.bodies[next].GetWorldCenter().x - this.bodies[i].GetWorldCenter().x;
				var dy:Number = this.bodies[next].GetWorldCenter().y - this.bodies[i].GetWorldCenter().y;
				var dist:Number = Math.sqrt(dx * dx + dy * dy);
				
				b2Settings
				
				if (dist < ConstantVolumeJoint.EPSILON)
				{
					dist = 1.0;
				}
				
				this.normals[i] = new b2Vec2();
				this.normals[i].x = dy / dist;
				this.normals[i].y = -dx / dist;
				perimeter += dist;
			}
			
			var deltaArea:Number = this.targetVolume - getArea();
			
			var toExtrude:Number = 0.5 * deltaArea / perimeter; //*relaxationFactor
			
			//float sumdeltax = 0.0f;
			var done:Boolean = true;
			
			for (var i:int = 0; i < this.bodies.length; ++i)
			{
				var next:int = (i == bodies.length - 1) ? 0 : i + 1;
				var delta:b2Vec2 = new b2Vec2(toExtrude * (this.normals[i].x + this.normals[next].x), toExtrude * (this.normals[i].y + this.normals[next].y));
				
				var norm:Number = delta.Length();
				
				if (norm > b2Settings.b2_maxLinearCorrection)
				{
					//delta.mulLocal(Settings.maxLinearCorrection/norm);
					delta.Multiply(b2Settings.b2_maxLinearCorrection / norm);
				}
				if (norm > b2Settings.b2_linearSlop)
				{
					done = false;
				}
				
				this.bodies[next].m_sweep.c.x += delta.x;
				this.bodies[next].m_sweep.c.y += delta.y;
				this.bodies[next].SynchronizeTransform();
			}
			return done;
		}
		
		// djm pooled
		//private static final Vec2Array tlD = new Vec2Array();
		private static var tlD:Vector.<b2Vec2> = new Vector.<b2Vec2>;
		
		override public virtual function InitVelocityConstraints(step:b2TimeStep):void
		{
			this.m_step = step;
			
			//final Vec2[] d = tlD.get(bodies.length);
			//var d:Vector.<b2Vec2> = tlD[this.bodies.length];
			var d:Vector.<b2Vec2> = new Vector.<b2Vec2>(this.bodies.length);
			
			for (var i:int = 0; i < this.bodies.length; ++i)
			{
				var prev:int = (i == 0) ? this.bodies.length - 1 : i - 1;
				var next:int = (i == this.bodies.length - 1) ? 0 : i + 1;
				
				d[i] = new b2Vec2();
				d[i].Set(this.bodies[next].GetWorldCenter().x, this.bodies[next].GetWorldCenter().y);
				
				//d[i].subLocal(bodies[prev].getMemberWorldCenter());
				d[i].Subtract(this.bodies[prev].GetWorldCenter());
			}
			
			if (step.warmStarting)
			{
				
				this.m_impulse *= step.dtRatio;
				
				for (var i:int = 0; i < this.bodies.length; ++i)
				{
					this.bodies[i].m_linearVelocity.x += this.bodies[i].m_invMass * d[i].y * 0.5 * this.m_impulse;
					this.bodies[i].m_linearVelocity.y += this.bodies[i].m_invMass * -d[i].x * 0.5 * this.m_impulse;
				}
			}
			else
			{
				this.m_impulse = 0.0;
			}
		}
		
		override public function SolvePositionConstraints():Boolean
		{
			return this.constrainEdges(this.m_step);
		}
		
		override public function SolveVelocityConstraints(step:b2TimeStep):void
		{
			var crossMassSum:Number = 0.0;
			var dotMassSum:Number = 0.0;
			
			//final Vec2 d[] = tlD.get(bodies.length);
			//var d:Vector.<b2Vec2> = tlD[this.bodies.length];
			var d:Vector.<b2Vec2> = new Vector.<b2Vec2>(this.bodies.length);
			
			for (var i:int = 0; i < this.bodies.length; ++i)
			{
				var prev:int = (i == 0) ? this.bodies.length - 1 : i - 1;
				var next:int = (i == this.bodies.length - 1) ? 0 : i + 1;
				
				d[i] = new b2Vec2();
				d[i].Set(this.bodies[next].GetWorldCenter().x, this.bodies[next].GetWorldCenter().y);
				d[i].Subtract(this.bodies[prev].GetWorldCenter());
				
				dotMassSum += (d[i].LengthSquared()) / this.bodies[i].GetMass();
				
				//crossMassSum += Vec2.cross(bodies[i].getLinearVelocity(),d[i]);
				var a:b2Vec2 = this.bodies[i].GetLinearVelocity();
				var b:b2Vec2 = d[i];
				crossMassSum += a.x * b.y - a.y * b.x;
			}
			
			var lambda:Number = -2.0 * crossMassSum / dotMassSum;
			
			this.m_impulse += lambda;
			
			for (var i:int = 0; i < this.bodies.length; ++i)
			{
				this.bodies[i].m_linearVelocity.x += this.bodies[i].m_invMass * d[i].y * 0.5 * lambda;
				this.bodies[i].m_linearVelocity.y += this.bodies[i].m_invMass * -d[i].x * 0.5 * lambda;
			}
		}
		
		override public function GetAnchor1():b2Vec2
		{
			return new b2Vec2();
		}
		
		override public function GetAnchor2():b2Vec2
		{
			return new b2Vec2();
		}
		
		override public function GetReactionForce():b2Vec2
		{
			return null;
		}
		
		override public function GetReactionTorque():Number
		{
			return 0;
		}
	
	}

}