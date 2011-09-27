package com.as3joelib.ui.navigation.treenavigator
{
	import com.as3joelib.generators.TextFieldGenerator;
	import com.as3joelib.ui.Button;
	import com.as3joelib.ui.UISwitcher;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Joe Cabezas
	 */
	public class TreeNavigatorNode extends Button
	{
		//eventos
		public static const CLICK_TREE_NAVIGATOR_NODE:String = 'clickTreeNavigatorNode';
		
		//TODO: borrar si no sirve esto
		//private var childrens:Vector.<TreeNavigatorNode>;
		
		//ui
		private var fondo_normal:Sprite;
		private var fondo_hover:Sprite;
		
		private var color_normal:uint;
		private var color_hover:uint;
		
		private var tf_label:TextField;
		private var str_label:String;
		
		private var desired_width:Number;
		private var desired_height:Number;
		
		//data
		private var _data:Object;
		
		//switcher
		private var switcher:UISwitcher;
		
		public function TreeNavigatorNode(data:Object, background_color:uint, hover_color:uint, width:Number, height:Number)
		{
			this._data = data;
			this.color_normal = background_color;
			this.color_hover = hover_color;
			
			this.desired_width = width;
			this.desired_height = height;
			
			this.setup();
			this.agregarListeners();
			this.dibujar();
		}
		
		private function setup():void
		{
			this.fondo_normal = new Sprite();
			this.fondo_normal.graphics.beginFill(this.color_normal);
			this.fondo_normal.graphics.drawRect(0, 0, this.desired_width, this.desired_height);
			this.fondo_normal.graphics.endFill();
			
			this.fondo_hover = new Sprite();
			this.fondo_hover.graphics.beginFill(this.color_hover);
			this.fondo_hover.graphics.drawRect(0, 0, this.desired_width, this.desired_height);
			this.fondo_hover.graphics.endFill();
			
			this.tf_label = TextFieldGenerator.crearTextField(this.data.name, {size: 12, color: 0xffffff, align: TextFieldGenerator.TEXTFORMAT_ALIGN_RIGHT, autosize: TextFieldGenerator.AUTOSIZE_NONE, width:this.desired_width, height:this.desired_height-5});
			
			this.switcher = new UISwitcher();
			this.switcher.addItem(this.fondo_normal);
			this.switcher.addItem(this.fondo_hover);
			
			this.switcher.hideAllItems();
			this.switcher.switchTo(this.fondo_normal);
		}
		
		private function agregarListeners():void
		{
		}
		
		private function dibujar():void
		{
			this.addChild(this.fondo_normal);
			this.addChild(this.fondo_hover);
			this.addChild(this.tf_label);
			this.tf_label.y = 5;
		}
		
		override protected function onClick(e:MouseEvent):void
		{
			this.dispatchEvent(new Event(CLICK_TREE_NAVIGATOR_NODE, true));
		}
		
		override protected function onRollOver(e:MouseEvent):void
		{
			this.switcher.switchTo(this.fondo_hover, false);
		}
		
		override protected function onRollOut(e:MouseEvent):void
		{
			this.switcher.switchTo(this.fondo_normal);
		}
		
		public function get data():Object
		{
			return _data;
		}
	
	}

}