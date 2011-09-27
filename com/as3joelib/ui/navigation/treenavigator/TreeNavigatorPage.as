package com.as3joelib.ui.navigation.treenavigator
{
	import com.somerandomdude.coordy.layouts.twodee.ILayout2d;
	import com.somerandomdude.coordy.layouts.twodee.VerticalLine;
	import config.ApplicationConfiguration;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Joe Cabezas
	 */
	public class TreeNavigatorPage extends Sprite
	{
		private var data:Object;
		private var items:Vector.<TreeNavigatorNode>;
		
		private var layout:ILayout2d;
		
		private var desired_width:Number;
		private var desired_height:Number;
		
		public function TreeNavigatorPage(data:Object, width:Number, height:Number)
		{
			this.data = data;
			this.desired_width = width;
			this.desired_height = height;
			
			this.setup();
			this.setupItems();
			this.agregarListeners();
			this.dibujar();
		}
		
		private function setup():void
		{
			this.items = new Vector.<TreeNavigatorNode>;
			this.layout = new VerticalLine();
		}
		
		private function setupItems():void
		{
			for each (var c:Object in this.data.categories)
			{
				this.items.push(new TreeNavigatorNode(c, ApplicationConfiguration.COLOR_BACKGROUND_APPLICATION, 0x555555, this.desired_width, 30));
			}
		}
		
		private function agregarListeners():void
		{
		}
		
		private function dibujar():void
		{
			for each (var t:TreeNavigatorNode in this.items)
			{
				this.addChild(t);
				this.layout.addNode(t);
			}
		}
	
	}

}