package 
{
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.FileFilter;
	import flash.display.MovieClip;

	public class EnCodeSwf extends MovieClip
	{
		private var file:FileReference = new FileReference();//加密文件
		private var file2:FileReference = new FileReference();//解密文件
		private var fileByteArray:ByteArray;
		private var saveSwf:String;//保存文件名称
		public function EnCodeSwf()
		{
			// constructor code
			init();
		}


		//初始化
		private function init():void
		{
			file.addEventListener(Event.SELECT , function (e:Event):void{;
				file.load();
			});
			file.addEventListener(Event.COMPLETE , fileComplete);
			
			browseBtn.addEventListener(MouseEvent.CLICK,onBrowse);
			decodeBtn.addEventListener(MouseEvent.CLICK,onDecode);
			
			encodeBtn.addEventListener(MouseEvent.CLICK,encodeHandler);
		}
		//点击加密
		protected function onBrowse(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			var filter:FileFilter = new FileFilter("*.swf","*.swf");
			file.browse([filter]);
		}
		//点击解密
		protected function onDecode(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			if (password.text.length <= 0)
			{
				error.text = "请输入密文";
				return;
			}
			else
			{
				error.text = "";
			}
			uncompress(file.data);
			var saveFile:FileReference = new FileReference();
			saveFile.save(fileByteArray,saveSwf);
		}
		//加密加载完成
		protected function fileComplete(e:Event):void
		{
			path.text=file.name;
			saveSwf=file.name;
			
		}
		//解密加载完成
		//加密函数
		private function compress(byte:ByteArray):ByteArray
		{
			var key:String = password.text;//得到密文
			var flag:int = 0;

			var newByte:ByteArray = new ByteArray();
			/* */
			for (var i:int = 0; i<byte.length; i++ ,flag++)
			{
				if (flag >= key.length)
				{
					flag = 0;
				}
				newByte.writeByte(byte[i] + key.charCodeAt(flag));
				//newByte.writeByte(byte[i] + 256);
			}
			//输出
			fileByteArray = newByte;
			encodeBtn.visible = true;
			return newByte;
		}

		//解密函数
		private function uncompress(byte:ByteArray):ByteArray
		{
			var key:String = password.text;//得到密文
			var flag:int = 0;

			var newByte:ByteArray = new ByteArray();
			/* */
			for (var i:int = 0; i<byte.length; i++ ,flag++)
			{
				if (flag >= key.length)
				{
					flag = 0;
				}
				newByte.writeByte(byte[i] - key.charCodeAt(flag));
				//newByte.writeByte(byte[i] + 256);
			}
			//trace(newByte);
			fileByteArray = newByte;
			encodeBtn.visible = true;
			return newByte;
		}

		protected function encodeHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			
			if (password.text.length <= 0)
			{
				error.text = "请输入密文";
				return;
			}
			else
			{
				error.text = "";
			}
			compress(file.data);
			var saveFile:FileReference = new FileReference();
			saveFile.save(fileByteArray , saveSwf);
		}

	}

}