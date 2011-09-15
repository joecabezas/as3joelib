package com.as3joelib.utils
{
	import flash.display.BitmapData;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author Joe Cabezas
	 */
	public class BitmapDataUtil
	{
		public static function setGreyScale(obj:BitmapData):BitmapData
		{
			var rLum:Number = 0.2225;
			var gLum:Number = 0.7169;
			var bLum:Number = 0.0606;
			
			var matrix:Array = [rLum, gLum, bLum, 0, 0, rLum, gLum, bLum, 0, 0, rLum, gLum, bLum, 0, 0, 0, 0, 0, 1, 0];
			
			var filter:ColorMatrixFilter = new ColorMatrixFilter(matrix);
			obj.applyFilter(obj, new Rectangle(0, 0, obj.width, obj.height), new Point(0, 0), filter);
			
			return obj;
		}
		
		public static function setBlackWhite(obj:BitmapData, threshold:int = 128):BitmapData
		{
			var rLum:Number = 0.2225;
			var gLum:Number = 0.7169;
			var bLum:Number = 0.0606;
			
			var matrix:Array = [rLum * 256, gLum * 256, bLum * 256, 0, -256 * threshold, rLum * 256, gLum * 256, bLum * 256, 0, -256 * threshold, rLum * 256, gLum * 256, bLum * 256, 0, -256 * threshold, 0, 0, 0, 1, 0];
			
			var filter:ColorMatrixFilter = new ColorMatrixFilter(matrix);
			obj.applyFilter(obj, new Rectangle(0, 0, obj.width, obj.height), new Point(0, 0), filter);
			
			return obj;
		}
	
	}

}