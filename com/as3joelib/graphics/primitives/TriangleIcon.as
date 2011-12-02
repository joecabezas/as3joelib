package com.as3joelib.graphics.primitives
{
	import com.as3joelib.graphics.VectorIcon;
	
	/**
	 * ...
	 * @author Joe Cabezas
	 */
	public class TriangleIcon extends VectorIcon
	{
		private static const SIDE:Number = 100;
		
		private var altitude:Number;
		
		public function TriangleIcon(params:Object = null)
		{
			//calculate altitude for a equilateral triangle of size SIDE
			this.altitude = Math.sqrt((SIDE * SIDE) - ((SIDE * SIDE) / (4)));

			super(params);
		}
		
		override protected function draw():void
		{
			this.graphics.lineStyle(this._line_tick, this._line_color, this._line_alpha);
			this.graphics.beginFill(this._fill_color, this._fill_alpha);
			
			trace(this.altitude / 2);
			this.graphics.moveTo(0, -this.altitude / 2);
			this.graphics.lineTo(SIDE / 2, this.altitude/2);
			this.graphics.lineTo(-SIDE / 2, this.altitude/2);
			this.graphics.lineTo(0, -this.altitude / 2);
			
			this.graphics.endFill();
		}
	}

}