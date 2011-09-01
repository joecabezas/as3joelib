package com.as3joelib.ppv3d
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.papervision3d.events.FileLoadEvent;
	import org.papervision3d.materials.utils.MaterialsList;
	import org.papervision3d.materials.WireframeMaterial;
	import org.papervision3d.objects.parsers.DAE;
	import org.papervision3d.view.BasicView;
	
	/**
	 * ...
	 * @author Joe Cabezas
	 */
	public class SimpleDAELoader extends BasicView
	{
		private var dae:DAE;
		private var dae_url:String;
		
		private var posInicialMouseX:Number;
		private var posInicialMouseY:Number;
		
		private var desired_rotationX:Number = 0;
		private var desired_rotationY:Number = 0;
		
		public function SimpleDAELoader(dae_url:String)
		{
			this.dae_url = dae_url;
			
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			this.setup();
			this.agregarListeners();
			this.load();
		}
		
		private function load():void
		{
			this.dae.load(this.dae_url);
		}
		
		private function setup():void
		{
			this.dae = new DAE();
			
			//this.viewport.viewportWidth = 400;
			//this.viewport.viewportHeight = 400;
			
			this.viewport.x = 0;
			this.viewport.y = 0;
			
			this.camera.zoom = 1000 / this.camera.focus + 1;
			this.camera.y = 200;
		}
		
		private function agregarListeners():void
		{
			this.dae.addEventListener(FileLoadEvent.LOAD_COMPLETE, onComplete);
			
			this.stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			this.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		private function onMouseUp(e:MouseEvent):void
		{
			trace('SimpleDAELoader.onMouseUp');
			this.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		
		private function onMouseDown(e:MouseEvent):void
		{
			trace('SimpleDAELoader.onMouseDown');
			this.stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			this.posInicialMouseX = this.mouseX;
			this.posInicialMouseY = this.mouseY;
		}
		
		private function onMouseMove(e:MouseEvent):void
		{
			trace('SimpleDAELoader.onMouseMove');
			var deltaX:Number = this.posInicialMouseX - this.mouseX;
			var deltaY:Number = this.posInicialMouseY - this.mouseY;
			
			this.updateRotationX(deltaY * 0.5);
			this.updateRotationY(deltaX * 0.5);
			
			this.posInicialMouseX = this.mouseX;
			this.posInicialMouseY = this.mouseY;
			//trace('Auto.onMouseMove');
		}
		
		public function updateRotationX(r:Number):void
		{
			this.desired_rotationX += r;
			
			//que no sobrepase 360
			this.desired_rotationX = this.desired_rotationX % 360;
			
			this.dae.rotationX = this.desired_rotationX;
		}
		
		public function updateRotationY(r:Number):void
		{
			this.desired_rotationY += r;
			trace(this.desired_rotationY);
			
			//que no sobrepase 360
			this.desired_rotationY = this.desired_rotationY % 360;
			
			this.dae.rotationY = this.desired_rotationY;
		}
		
		private function onComplete(e:FileLoadEvent):void
		{
			trace('SimpleDAELoader.onComplete');
			trace(this.dae.materials);
			
			//trace('+' + this.dae.materials.getMaterialByName('ID35').toString());
			
			//ID5 = superior
			//ID35 = ruedas
			//ID45 = inferior
			//ID15 = izquierda
			//ID25 = derecha
			
			this.dae.replaceMaterialByName(new WireframeMaterial(0x000000, 1, 1), 'auto_1_lateral_izq-material');
			
			this.dibujar();
			this.startRendering();
		}
		
		private function dibujar():void
		{
			this.scene.addChild(this.dae);
		}
	}

}