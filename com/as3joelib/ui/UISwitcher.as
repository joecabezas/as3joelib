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
				this.disableMouseEvents(i);
				TweenLite.to(i, 0, this.animation_out_object);
			}
		}
		
		public function addItem(d:DisplayObjectContainer):void
		{
			this.items.push(d);
			this.actual_item = d;
		}
		
		//cambiar a una vista pero ocultando las otras, dependiendo del segundo parámetro
		public function switchTo(d:DisplayObjectContainer, hide_others:Boolean = true):void
		{
			trace('UISwitcher.switchTo');
			
			if(hide_others) {
				//esconder el actual
				this.hideItem(this.actual_item);
			}
			
			trace(this.actual_item);
			
			//quitar respuesta a eventos de mouse del elemento actual
			this.disableMouseEvents(this.actual_item);
			
			trace(this.actual_item.mouseChildren);
			
			//mostrar el solicitado
			TweenLite.to(this.items[this.items.indexOf(d)], this.duration_in, this.animation_in_object);
			
			//marcar el solicitado como el actual
			this.actual_item = d;
			
			//hacer que el actual responda a eventos de mouse
			this.enableMouseEvents(this.actual_item);
			trace(this.actual_item);
		}
		
		private function hideItem(d:DisplayObjectContainer):void
		{
			//animacion de esconder
			TweenLite.to(this.items[this.items.indexOf(d)], this.duration_out, this._animation_out_object);
		}
		
		public function next():void {
			this.switchTo(this.items[(this.items.indexOf(this.actual_item) + 1) % this.items.length]);
			//trace((this.items.indexOf(this.actual_item) + 1) % this.items.length);
			//this.showItem(this.items[0]);
		}
		
		private function disableMouseEvents(d:DisplayObjectContainer):void {
			d.mouseEnabled = false;
			d.mouseChildren = false;
		}
		
		private function enableMouseEvents(d:DisplayObjectContainer):void {
			d.mouseEnabled = true;
			d.mouseChildren = true;
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