package com.as3joelib.generators
{
	import caurina.transitions.Tweener;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;

	public class TooltipGenerator extends Sprite
	{
		private var container:Sprite;
		
		private var tooltip:Sprite;
		private var offset:Point;
		private var sx:Number;
		private var sy:Number;
		
		public function Tooltip(_xoffset:Number=20,_yoffset:Number=-55,_sx:Number=100,_sy:Number=30)
		{
			this.offset = new Point(_xoffset,_yoffset);
			
			this.sx = _sx;
			this.sy = _sy;
			
			this.dibujar();
		}
		
		private function dibujar():void{
			this.container = new Sprite();
			this.addChild(this.container);
			
			this.tooltip = new TooltipAsset();
			this.container.addChild(this.tooltip);
			
			this.tooltip.x = this.offset.x;
			this.tooltip.y = this.offset.y;
			
			this.tooltip.width = this.sx;
			this.tooltip.height = this.sy;
			
			this.container.scaleX = 0;
			this.container.scaleY = 0;
			//this.tooltip.visible = false;
		}
		
		public function addTooltipContent(s:String):void{
			//this.tooltip.scaleX = 1;
			//this.tooltip.scaleY = 1;
			
			var t:TextField = TextFieldHelper.crearTextField(s,{size:14,color:0xFFFFFF,align:'left'});
			
			//trace(t.textWidth);
			
			this.sx = t.textWidth + 20;
			this.sy = t.textHeight + 10;
			
			this.tooltip.width = this.sx;
			this.tooltip.height = this.sy;
			
			t.x = this.offset.x - t.textWidth/2 - 1;
			t.y = this.offset.y - t.textHeight/2 - 1;
			this.container.addChild(t);
			
			//this.tooltip.scaleX = 0;
			//this.tooltip.scaleY = 0;
		}
		
		public function on():void{
			
			var efecto:Object = {
				scaleX:1,
				scaleY:1,
				rotation:0,
				time:0.36,
				transition:"easeOutBack"
			};
			Tweener.addTween(this.container, efecto);
		}
		
		public function off():void{
			
			var efecto:Object = {
				scaleX:0,
				scaleY:0,
				rotation:-10,
				time:0.3,
				transition:"linear"
			};
			Tweener.addTween(this.container, efecto);
		}
	}
}