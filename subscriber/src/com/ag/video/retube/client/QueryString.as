package com.ag.video.retube.client
{
	import flash.external.ExternalInterface;
	
	public class QueryString
	{
		private var _queryString:String;
		private var _all:String;
		private var _params:Object;
		
		public function QueryString(url:String='')
		{
			readQueryString(url);
		}
		public function get getQueryString():String
		{
			return _queryString;
		}
		public function get url():String
		{
			return _all;
		}
		public function get parameters():Object
		{
			return _params;
		}       
		
		private function readQueryString(url:String=''):void
		{
			_params = new Object();
			try
			{
				_all = (url.length > 0) ? url : ExternalInterface.call("window.location.href.toString");
				_queryString = (url.length > 0) ? url.split("?")[1] : ExternalInterface.call("window.location.search.substring", 1);
				if(_queryString)
				{
					var allParams:Array = _queryString.split('&');
					//var length:uint = params.length;
					
					for(var i:int=0, index:int=-1; i < allParams.length; i++)
					{
						var keyValuePair:String = allParams[i];
						if((index = keyValuePair.indexOf("=")) > 0)
						{
							var paramKey:String = keyValuePair.substring(0,index);
							var paramValue:String = keyValuePair.substring(index+1);
							_params[paramKey] = paramValue;
						}
					}
				}
			}
			catch(e:Error)
			{
				trace("Some error occured. ExternalInterface doesn't work in Standalone player.");
			}
		}
	}
}