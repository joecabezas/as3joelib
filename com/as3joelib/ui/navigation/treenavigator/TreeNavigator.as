package com.as3joelib.ui.navigation.treenavigator
{
	import com.as3joelib.ui.UISwitcher;
	import com.greensock.events.TweenEvent;
	import com.greensock.TweenMax;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Joe Cabezas
	 */
	public class TreeNavigator extends Sprite
	{
		//events
		public static const TREE_NAVIGATOR_CHANGE_PAGE:String = 'treeNavigatorChangePage';
		
		//vars
		private var data:Object;
		private var desired_width:Number;
		private var desired_height:Number;
		
		//pages
		private var pagina_anterior:TreeNavigatorPage;
		private var pagina_actual:TreeNavigatorPage;
		//private var pagina_siguiente:TreeNavigatorPage;
		
		//ds
		private var stack:Vector.<Object>;
		
		//ui
		private var switcher:UISwitcher;
		private var mascara:Sprite;
		
		public function TreeNavigator(complete_data:Object, desired_width:Number, desired_height:Number)
		{
			trace('TreeNavigator.TreeNavigator');
			
			this.data = complete_data;
			this.desired_width = desired_width;
			this.desired_height = desired_height;
			
			this.setup();
			this.agregarListeners();
			this.dibujar();
		}
		
		private function setup():void
		{
			this.stack = new Vector.<Object>;
			
			//agregar el elemento raiz
			this.stack.push(this.data);
			
			this.mascara = new Sprite();
			this.mascara.graphics.beginFill(0x00ff00, 0.5);
			this.mascara.graphics.drawRect(0, 0, this.desired_width, this.desired_height);
			this.mascara.graphics.endFill();
		}
		
		private function agregarListeners():void
		{
			this.addEventListener(TreeNavigatorNode.CLICK_TREE_NAVIGATOR_NODE, onClickTreeNavigatorNode);
		}
		
		private function onClickTreeNavigatorNode(e:Event):void
		{
			//verificar que este nodo tenga mas categorias, sino, es un nodo hoja
			//y debe prevenir cualquier animacion
			var is_leaf_node:Boolean = true;
			for each (var c:Object in TreeNavigatorNode(e.target).data.categories)
			{
				is_leaf_node = false;
			}
			
			if (is_leaf_node)
				return;
			
			//agregar al stack el objeto del nodo seleccionado
			this.stack.push(TreeNavigatorNode(e.target).data);
			
			//continuar con el cambio de página
			this.changePage();
			
			//animar
			this.animate();
		}
		
		private function changePage():void
		{			
			//avisar que hay un cambio de pagina
			this.dispatchEvent(new Event(TREE_NAVIGATOR_CHANGE_PAGE, true));
			
			//hacer que la pagina actual ahora sea a anterior
			this.pagina_anterior = this.pagina_actual;
			
			//crear la pagina nueva
			this.createPage();
			
			//ya creadas las nuevas paginas, agregarlas
			//this.addChild(this.pagina_anterior);
			this.addChild(this.pagina_actual);
			this.pagina_actual.x = this.desired_width;
		}
		
		private function onPageInComplete(e:TweenEvent):void
		{
			//remover la pagina anterior
			this.removePages();
		}
		
		private function dibujar():void
		{
			this.createPage();
			this.addChild(this.pagina_actual);
			
			//mascara
			this.addChild(this.mascara);
			this.mask = this.mascara;
		}
		
		private function createPage():void
		{
			//toma el ultimo elemento
			var data_actual:Object = this.stack[this.stack.length - 1];
			
			this.pagina_actual = new TreeNavigatorPage(data_actual, this.desired_width, this.desired_height);
		}
		
		private function removePages():void
		{
			if (this.pagina_anterior && this.contains(this.pagina_anterior))
			{
				this.removeChild(this.pagina_anterior);
			}
			
			if (this.pagina_actual && this.contains(this.pagina_actual))
			{
				//this.removeChild(this.pagina_actual);
			}
		}
		
		private function animate(backwards:Boolean = false):void
		{
			//re-crear el switcher encargado de la animacion
			this.switcher = new UISwitcher();
			this.switcher.addItem(this.pagina_actual);
			this.switcher.addItem(this.pagina_anterior);
			
			this.switcher.animation_in_object = {duration: 0.3, x: 0, onCompleteListener: onPageInComplete};
			this.switcher.animation_out_object = {duration: 0.3, x: -this.desired_width};
			
			if (backwards)
			{
				this.pagina_actual.x = -this.desired_width;
				
				this.switcher.animation_in_object.x = 0;
				this.switcher.animation_out_object.x = this.desired_width;
			}
			
			this.switcher.switchTo(this.pagina_actual);
		}
		
		public function back():void
		{
			//primero remover el ultimo elemento del stack
			this.stack.pop();
			
			//cambiar pagina
			this.changePage();
			
			//animar
			this.animate(true);
		}
		
		public function get page_number():uint {
			return this.stack.length;
		}
	}

}