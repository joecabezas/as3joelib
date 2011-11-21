package com.as3joelib.utils 
{
	/**
	 * ...
	 * @author Joe Cabezas
	 */
	public class StringUtil 
	{
		
		public static function firstToUpper(s:String, toLowerCaseRest:Boolean = true): String
		{
			if(toLowerCaseRest)
				s = s.toLowerCase();
			return s.charAt(0).toUpperCase() + s.substr(1);
		}
		
	}

}