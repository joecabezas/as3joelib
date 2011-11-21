package com.as3joelib.utils
{
	//clase no debe ser final, ya que debe ser madre para singletons custom
	//asi este singleton puede ser reutilizado
	public class Singleton
	{
		
		//instancia
		private static var instance:Singleton = new Singleton();
		
		//objeto que mantendra los objetos que queramos
		public var data:Object = new Object();
		
		//no editar
		public function Singleton()
		{
			if (instance)
				throw new Error("Singleton and can only be accessed through Singleton.getInstance()");
		}
		
		//no editar
		public static function getInstance():Singleton
		{
			return instance;
		}
	}
}
