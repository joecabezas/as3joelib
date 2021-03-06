package com.as3joelib.utils
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class AppBlocker extends EventDispatcher
	{
		//constantes
		private static const BASE_URL:String = 'http://www.polerones.com/joe/appblocker/';
		public static var FILE_NAME:String = '';

		//eventos
		public static const APP_BLOCKER_ON:String = 'AppBlokerOn';
		
		//variables
		private static var file:URLLoader = new URLLoader();
		
		//instancia
		private static var instance:AppBlocker = new AppBlocker();
		
		public var eventDispatcher:EventDispatcher = new EventDispatcher();
		
		public function AppBlocker()
		{
			if( instance ) throw new Error('AppBlocker no debe ser instanciado, solo tiene métodos estáticos');
		}
		
		//no editar
		public static function getInstance():AppBlocker {
			return instance;
		}
		
		public static function check():void{
			AppBlocker.file.addEventListener(Event.COMPLETE, onLoaded);
			AppBlocker.file.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			
			//trace('getting file: ' + BASE_URL + FILE_NAME);
			AppBlocker.file.load(new URLRequest(BASE_URL + FILE_NAME));
		}
		
		private static function onLoaded(e:Event):void{
			//trace('AppBlocker ON');
			
			//disparar evento
			AppBlocker.getInstance().dispatchEvent(new Event(AppBlocker.APP_BLOCKER_ON,true));
		}
		
		private static function onIOError(e:IOErrorEvent):void{
			//trace('AppBlocker OFF');
		}
	}
}
