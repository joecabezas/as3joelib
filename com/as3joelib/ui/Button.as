package com.as3joelib.ui 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Joe Cabezas
	 */
	public class Button extends Sprite
	{
		private var _toggle:Boolean;
		protected var _selected:Boolean;
		
		public function Button() 
		{
			this._toggle = false;
			this._selected = false;

			this.agregarListeners();
		}
		
		private function agregarListeners():void 
		{
			this.addEventListener(MouseEvent.CLICK, onClick);
			this.addEventListener(MouseEvent.ROLL_OVER, onRollOver);
			this.addEventListener(MouseEvent.ROLL_OUT, onRollOut);
		}
		
		/* INTERFACE botones.IButton */
		
		private function onClick(e:MouseEvent):void
		{
			if (this.toggle) {
				this._selected = !this._selected;
			}
			
			this.customOnClick(e);
		}
		
		protected function customOnClick(e:MouseEvent):void 
		{
			
		}
		
		protected function onRollOver(e:MouseEvent) :void
		{
			
		}
		
		protected function onRollOut(e:MouseEvent):void
		{
			
		}
		
		public function get selected():Boolean 
		{
			return _selected;
		}
		
		public function set selected(value:Boolean):void 
		{
			_selected = value;
		}
		
		public function get toggle():Boolean 
		{
			return _toggle;
		}
		
		public function set toggle(value:Boolean):void 
		{
			_toggle = value;
			this._selected = false;
		}
	}

}