package com.as3joelib.ui.windows
{
	import com.as3joelib.ui.UISwitcher;
	import com.greensock.TweenLite;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Joe Cabezas
	 */
	public class ModalWindow extends Sprite
	{
		//eventos
		public static const MODAL_WINDOW_CLICK_BACKGROUND:String = 'modalWindowClickBackground';
		public static const MODAL_WINDOW_ANIMATION_IN_START:String = 'modalWindowClickBackground';
		public static const MODAL_WINDOW_ANIMATION_IN_END:String = 'modalWindowClickBackground';
		public static const MODAL_WINDOW_ANIMATION_OUT_START:String = 'modalWindowClickBackground';
		public static const MODAL_WINDOW_ANIMATION_OUT_END:String = 'modalWindowClickBackground';
		
		//conatantes de animaciones
		private static const DEFAULT_DURATION_ANIMS:Number = 1;
		
		//ui
		private var fondo:Sprite;
		private var fondo_color:uint;
		private var fondo_alpha:Number;
		
		private var window:Sprite;
		
		//animations
		public var animation_background_in:Object;
		public var animation_background_out:Object;
		public var animation_background_duration:Number;
		
		public var animation_window_in:Object;
		public var animation_window_out:Object;
		public var animation_window_duration:Number;
		
		public function ModalWindow(window:Sprite, background_color:uint = 0x000000, alpha:Number = 0.7)
		{
			this.window = window;
			this.fondo_color = background_color;
			this.fondo_alpha = alpha;
			
			this.animation_background_in = {alpha: 1};
			this.animation_background_out = {alpha: 0};
			this.animation_background_duration = DEFAULT_DURATION_ANIMS;
			
			this.animation_window_in = {alpha: 1};
			this.animation_window_out = {alpha: 0};
			this.animation_window_duration = DEFAULT_DURATION_ANIMS;			
			
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			this.setup();
			this.agregarListeners();
			this.dibujar();
		}
		
		private function setup():void
		{
			this.fondo = new Sprite();
			this.fondo.graphics.beginFill(this.fondo_color, this.fondo_alpha);
			this.fondo.graphics.drawRect(0, 0, this.stage.stageWidth, this.stage.stageHeight);
			this.fondo.graphics.endFill();
		}
		
		private function agregarListeners():void
		{
			this.fondo.addEventListener(MouseEvent.CLICK, eventHandler);
		}
		
		private function eventHandler(e:MouseEvent):void
		{
			switch(e.target) {
				
				case this.fondo:
					
					switch(e.type) {
						case MouseEvent.CLICK:
							this.dispatchEvent(new Event(MODAL_WINDOW_CLICK_BACKGROUND, true));
							break;
					}
					break;
			}
		}
		
		private function dibujar():void
		{
			this.addChild(this.fondo);
			
			this.addChild(this.window);
			this.window.x = this.stage.stageWidth / 2 - this.window.width / 2;
			this.window.y = this.stage.stageHeight / 2 - this.window.height / 2;
			
			//initial state
			this.setItemsVisibility(false);
			
			//this.fadeIn();
		}
		
		private function setItemsVisibility(b:Boolean):void
		{
			this.fondo.visible = b;
			this.window.visible = b;
		}
		
		//es solo la interface en ingles
		public function draw():void
		{
			this.dibujar();
		}
		
		public function fadeIn():void
		{
			//restaurar visibilidad
			this.setItemsVisibility(true);
			
			TweenLite.from(this.fondo, this.animation_background_duration, this.animation_background_out);
			TweenLite.to(this.fondo, this.animation_background_duration, this.animation_background_in);
			
			TweenLite.from(this.window, this.animation_window_duration, this.animation_window_out);
			TweenLite.to(this.window, this.animation_window_duration, this.animation_window_in);
		}
		
		public function fadeOut():void
		{
			//restaurar visibilidad
			//this.setItemsVisibility(true);
			
			//TweenLite.from(this.fondo, this.animation_background_duration, this.animation_background_in);
			TweenLite.to(this.fondo, this.animation_background_duration, this.animation_background_out);
			
			//TweenLite.from(this.window, this.animation_window_duration, this.animation_window_in);
			TweenLite.to(this.window, this.animation_window_duration, this.animation_window_out);
		}
	}

}