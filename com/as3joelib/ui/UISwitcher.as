package com.as3joelib.ui
{
	
	import com.greensock.data.TweenLiteVars;
	import com.greensock.TweenLite;
	import flash.display.DisplayObjectContainer;
	
	/**
	 * ...
	 * @author Joe Cabezas
	 */
	public class UISwitcher
	{
		private static const DEFAULT_DURATION:Number = 1;
		
		private var items:Vector.<DisplayObjectContainer>;
		private var actual_item:DisplayObjectContainer;
		
		private var _animation_in_object:Object;
		private var _animation_out_object:Object;
		
		private var duration_in:Number;
		private var duration_out:Number;
		
		public function UISwitcher()
		{
			this.setup();
		}
		
		private function setup():void
		{
			this.items = new Vector.<DisplayObjectContainer>;
			
			this._animation_in_object = {alpha: 1};
			this._animation_out_object = { alpha: 0 };
			
			this.duration_in = 1;
			this.duration_out = 1;
		}
		
		public function hideAllItems():void
		{
			for each (var i:DisplayObjectContainer in this.items)
			{
				i.mouseEnabled = false;
				i.mouseChildren = false;
				TweenLite.to(i, 0, this.animation_out_object);
			}
		}
		
		public function addItem(d:DisplayObjectContainer):void
		{
			this.items.push(d);
			this.actual_item = d;
		}
		
		public function showItem(d:DisplayObjectContainer):void
		{
			//esconder el actual
			this.hideItem(this.actual_item);
			
			//mostrar el solicitado
			TweenLite.to(this.items[this.items.indexOf(d)], this.duration_in, this.animation_in_object);
			
			//marcar el solicitado como el actual
			this.actual_item = d;
			
			//hacer que el actual responda a eventos de mouse
			this.actual_item.mouseEnabled = true;
			this.actual_item.mouseChildren = true;
		}
		
		private function hideItem(d:DisplayObjectContainer):void
		{
			//quitar respuesta a eventos de mouse
			DisplayObjectContainer(this.items[this.items.indexOf(d)]).mouseEnabled = false;
			DisplayObjectContainer(this.items[this.items.indexOf(d)]).mouseChildren = false;
			
			//animacion de esconder
			TweenLite.to(this.items[this.items.indexOf(d)], this.duration_out, this._animation_out_object);
		}
		
		public function next():void {
			this.showItem(this.items[(this.items.indexOf(this.actual_item) + 1) % this.items.length]);
			//trace((this.items.indexOf(this.actual_item) + 1) % this.items.length);
			//this.showItem(this.items[0]);
		}
		
		public function get animation_in_object():Object
		{
			return _animation_in_object;
		}
		
		public function set animation_in_object(value:Object):void
		{
			if (value.duration)
			{
				this.duration_in = value.duration
				trace(value.duration);
				delete value.duration
				trace(value.duration);
				_animation_in_object = value;
			}
			else
			{
				_animation_in_object = value;
				this.duration_in = DEFAULT_DURATION;
			}
		}
		
		public function get animation_out_object():Object
		{
			return _animation_out_object;
		}
		
		public function set animation_out_object(value:Object):void
		{
			if (value.duration)
			{
				this.duration_out = value.duration
				trace(value.duration);
				delete value.duration
				trace(value.duration);
				_animation_out_object = value;
			}
			else
			{
				_animation_out_object = value;
				this.duration_out = DEFAULT_DURATION;
			}
		
		}
	
	}
}