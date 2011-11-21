package com.as3joelib.box2d.dynamics.joints
{
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.Joints.b2Joint;
	import Box2D.Dynamics.Joints.b2JointDef;
	
	/**
	 * ...
	 * @author Joe Cabezas
	 */
	public class ConstantVolumeJointDef extends b2JointDef
	{
		public var bodies:Vector.<b2Body>;
		
		public var frequencyHz:Number;
		public var dampingRatio:Number;
		
		public function ConstantVolumeJointDef()
		{
			this.type = b2Joint.e_constantVolumeJoint;
			
			//bodies = new Body[0];
			this.bodies = new Vector.<b2Body>(0);
			
			this.collideConnected = false;
			this.frequencyHz = 0;
			this.dampingRatio = 0;
		}
		
		public function addBody(b:b2Body):void
		{
			//Body[] tmp = new Body[bodies.length + 1];
			var tmp:Vector.<b2Body> = new Vector.<b2Body>(this.bodies.length + 1);
			
			//System.arraycopy(bodies, 0, tmp, 0, bodies.length);
			tmp = this.bodies.slice();
			
			tmp[this.bodies.length] = b;
			
			this.bodies = tmp;
			
			if (tmp.length == 1)
				this.body1 = b;
			if (tmp.length == 2)
				this.body2 = b;
		}
	
	}

}