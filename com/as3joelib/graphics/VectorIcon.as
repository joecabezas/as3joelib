package com.as3joelib.graphics
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Joe Cabezas
	 */
	public class VectorIcon extends Sprite
	{
		protected var _fill_color:uint;
		protected var _line_color:uint;
		
		protected var _fill_alpha:Number;
		protected var _line_alpha:Number;
		
		protected var _line_tick:int;
		
		public function VectorIcon(params:Object = null)
		{
			this.setDefaults();
			this.overrideDefaults(params);
			this.draw();
		}
		
		private function setDefaults():void
		{
			this._fill_color = 0xff0000;
			this._line_color = 0x000000;
			
			this._fill_alpha = 1;
			this._line_alpha = 1;
			
			this._line_tick = 1;
		}
		
		private function overrideDefaults(params:Object):void
		{
			if (!params)
				return;
			
			if (params.fillColor is uint)
				this._fill_color = params.fillColor;
			
			if (params.lineColor is uint)
				this._line_color = params.lineColor;
			
			if (params.fillAlpha is Number)
				this._fill_alpha = params.fillAlpha;
			
			if (params.lineAlpha is Number)
				this._line_alpha = params.lineAlpha;
			
			if (params.lineTick is int)
				this._line_tick = params.lineTick;
		}
		
		//must be overriden
		protected function draw():void
		{
		
		}
	
	}

}