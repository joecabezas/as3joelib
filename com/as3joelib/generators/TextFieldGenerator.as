package com.as3joelib.generators
{
	import com.as3joelib.utils.ArrayUtil;
	import flash.text.AntiAliasType;
	import flash.text.Font;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class TextFieldGenerator
	{
		public static const AUTOSIZE_CENTER:String = TextFieldAutoSize.CENTER;
		public static const AUTOSIZE_LEFT:String = TextFieldAutoSize.LEFT;
		public static const AUTOSIZE_RIGHT:String = TextFieldAutoSize.RIGHT;
		public static const AUTOSIZE_NONE:String = TextFieldAutoSize.NONE;
		
		public static const TEXTFORMAT_ALIGN_CENTER:String = TextFormatAlign.CENTER;
		public static const TEXTFORMAT_ALIGN_LEFT:String = TextFormatAlign.LEFT;
		public static const TEXTFORMAT_ALIGN_RIGHT:String = TextFormatAlign.RIGHT;
		public static const TEXTFORMAT_ALIGN_JUSTIFY:String = TextFormatAlign.JUSTIFY;
		
		public static const TEXTFIELD_TYPE_DYNAMIC:String = TextFieldType.DYNAMIC;
		public static const TEXTFIELD_TYPE_INPUT:String = TextFieldType.INPUT;
		
		/*
		[Embed(source="lib/fonts/TrajanPro-Bold.otf", fontWeight="bold", fontFamily="TrajanPro")]
		public var TrajanPro_Bold:Class;
		
		[Embed(source="lib/fonts/TrajanPro-Regular.otf", fontFamily="TrajanPro")]
		public var TrajanPro_Regular:Class;
		
		
		[Embed(source="../lib/fonts/arialbd.ttf", fontWeight="bold", fontFamily="Arial", mimeType="application/x-font-truetype")]
		public static const ArialBold:String;
		
		[Embed(source="../lib/fonts/ariali.ttf", fontStyle="italic", fontFamily="Arial", mimeType="application/x-font-truetype")]
		public static const ArialItalic:String;
		
		[Embed(source="../lib/fonts/arialbi.ttf", fontWeight="bold", fontStyle="italic", fontFamily="Arial", mimeType="application/x-font-truetype")]
		public static const ArialBoldItalic:String;
		*/
		
		public static function crearTextField(_txt:String,_opciones_usuario:Object = null):TextField{
			
			var opciones:Object = new Object();
			
			//defaults
			opciones = {
				//html config
				html:false,
				
				//textfield
				type:TextFieldType.DYNAMIC,
				autosize:TextFieldAutoSize.LEFT,
				embedfonts:false,
				selectable:false,
				multiline:false,
				wordwrap:false,
				border:false,
				width:300,
				//height:20,
				
				//textformat
				size:20,
				color:0x000000,
				bold:true,
				font:'Arial',
				leading:0,
				kerning:0,
				letterSpacing:0,
				align:TextFormatAlign.LEFT
			};
			
			//mezclar con las opciones del usuario y sobreescribir las por defecto
			opciones = ArrayUtil.mergeObjects(opciones,_opciones_usuario);
			
			//Creo una variable de tipo MiFuente (es el nombre con el que he vinculado la fuente
			//en la biblioteca
			//var fuente:Font=new Calibri();

			//Creo una variable de tipo textFormat en la que pondré los parametros de la caja de texto
			var formato:TextFormat = new TextFormat();
			
			//Indico que el tipo de fuente asociado a mi formato es el de "fuente"
			formato.font = opciones.font;
			
			formato.size = opciones.size;
			formato.color = opciones.color;
			formato.bold = opciones.bold;
			formato.leading = opciones.leading;
			formato.kerning = opciones.kerning;
			formato.letterSpacing = opciones.letterSpacing;
			
			formato.align = opciones.align;
			
			//Creo el campo de texto, aplicándole el formato de texto que he creado e indicando que se
			//tiene que embeber la fuente
			var txt:TextField = new TextField();
			txt.autoSize = opciones.autosize;
			txt.width = opciones.width;
			txt.height = opciones.height;
			
			txt.defaultTextFormat = formato;
			txt.embedFonts = opciones.embedfonts;
			txt.antiAliasType = AntiAliasType.NORMAL;
			txt.selectable = opciones.selectable;
			
			txt.multiline = opciones.multiline;
			txt.wordWrap = opciones.wordwrap;
			
			txt.type = opciones.type;
			
			//debug
			txt.border = opciones.border;
			
			//txt.text = _txt;
			//txt.htmlText = _txt;

			//Añado el campo a la caja de texto, y añado la caja al stage			
			if(opciones.html == true){
				txt.htmlText = _txt;
			} else {
				txt.text = _txt;
			}
			
			return txt;
		}
	}
}