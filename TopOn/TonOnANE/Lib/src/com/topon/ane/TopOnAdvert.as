package com.topon.ane
{
	
	import com.topon.utils.TopOnFunctions;
	import com.topon.utils.TopOnPrivateConst;
	import flash.display.MovieClip;
	import flash.events.IEventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	import flash.system.Capabilities;


	public class TopOnAdvert extends MovieClip implements IEventDispatcher
	{
		internal   static   var  EXTENSION_ID:String = "com.topon.ane";
		internal var extContext:ExtensionContext = null;
		internal static var instance:TopOnAdvert;
		// interstitial
		private var interstitialCloseListener:Function;
		private var interstitialShowListener:Function;
		private var interstitialShowFailListener:Function;
		private var interstitialDidLoadListener:Function;
		private var interstitialLoadFailListener:Function;
		private var interstitialClickListener:Function;
		// video
		private var videoCloseListener:Function;
		private var videoClickListener:Function;
		private var videoShowListener:Function;
		private var videoShowFailListener:Function;
		private var videoDidLoadListener:Function;
		private var videoLoadFailListener:Function;
		private var videoRewardedListener:Function;
		
		// banner
		private var bannerDidShowListener:Function;
		private var bannerCloseListener:Function;
		private var bannerDidLoadListener:Function;
		private var bannerLoadFailListener:Function;
		private var bannerClickListener:Function;
		
		//native
		private var nativeDidShowListener:Function;
		private var nativeLoadFailListener:Function;
		private var nativeClickListener:Function;
		private var nativeStartPlayListener:Function;
		private var nativeEndPlayListener:Function;
		
		///splash
		private var splashDidShowListener:Function;

		//xcode
		private var xCodeDidSendSixtyListener:Function;
		private var xCodeDidSendZeroListener:Function;

		///native banner
		private  var nativeBannerDidShowListener:Function;
		private  var nativeBannerCloseListener:Function;
		private  var nativeBannerDidLoadListener:Function;
		private  var nativeBannerLoadFailListener:Function;
		private  var nativeBannerClickListener:Function;

		private var _main:MovieClip = null;


		private static function _isIOS():Boolean {
			return Capabilities.manufacturer.indexOf("iOS") > -1 && Capabilities.os.indexOf("x86_64") < 0 && Capabilities.os.indexOf("i386") < 0;
		}

		private static function _isAndroid():Boolean {

			return Capabilities.manufacturer.indexOf("Android") > -1;
		}


		public function setInterstitialCloseListener(listener:Function):void {
			this.interstitialCloseListener = listener;
		}
		
		public function setInterstitialShowListener(listener:Function):void {
			this.interstitialShowListener = listener;
		}
		
		public function setInterstitialShowFailListener(listener:Function):void {
			this.interstitialShowFailListener = listener;
		}
		
		public function setInterstitialDidLoadListener(listener:Function):void {
			this.interstitialDidLoadListener = listener;
		}
		
		public function setInterstitialLoadFailListener(listener:Function):void {
			this.interstitialLoadFailListener = listener;
		}
		
		public function setInterstitialClickListener(listener:Function):void {
			this.interstitialClickListener = listener;
		}
		
		//video
		public function setVideoCloseListener(listener:Function):void {
			this.videoCloseListener = listener;
		}
		
		public function setVideoClickListener(listener:Function):void {
			this.videoClickListener = listener;
		}
		public function setVideoShowListener(listener:Function):void {
			this.videoShowListener = listener;
		}
		
		public function setVideoShowFailListener(listener:Function):void {
			this.videoShowFailListener = listener;
		}
		
		public function setVideoDidLoadListener(listener:Function):void {
			this.videoDidLoadListener = listener;
		}
		public function setVideoLoadFailListener(listener:Function):void {
			this.videoLoadFailListener = listener;
		}
		public function setVideoRewardedListener(listener:Function):void {
			this.videoRewardedListener = listener;
		}
		
		// banner
		public function setBannerDidShowListener(listener:Function):void {
			this.bannerDidShowListener = listener;
		}
		
		public function setBannerCloseListener(listener:Function):void {
			this.bannerCloseListener = listener;
		}
		public function setBannerDidLoadListener(listener:Function):void {
			this.bannerDidLoadListener = listener;
		}
		public function setBannerLoadFailListener(listener:Function):void {
			this.bannerLoadFailListener = listener;
		}
		public function setBannerClickListener(listener:Function):void{
			this.bannerClickListener = listener;
		}

		//native
		public function setNativeDidShowListener(listener:Function):void{
			this.nativeDidShowListener = listener;
		}
		
		public function setNativeLoadFailListener(listener:Function):void{
			this.nativeLoadFailListener = listener;
		}
		
		public function setNativeClickListener(listener:Function):void{
			this.nativeClickListener = listener;
		}
		
		public function setNativeStartPlayListener(listener:Function):void{
			this.nativeStartPlayListener = listener;
		}
		
		public function setNativeEndPlayListener(listener:Function):void{
			this.nativeEndPlayListener = listener;
		}

		///native banner
		public function setNativeBannerDidShowListener(listener:Function):void {
			this.nativeBannerDidShowListener = listener;
		}

		public function setNativeBannerCloseListener(listener:Function):void {
			this.nativeBannerCloseListener = listener;
		}

		public function setNativeBannerDidLoadListener(listener:Function):void {
			this.nativeBannerDidLoadListener = listener;
		}

		public function setNativeBannerLoadFailListener(listener:Function):void {
			this.nativeBannerLoadFailListener = listener;
		}

		public function setNativeBannerClickListener(listener:Function):void {
			this.nativeBannerClickListener = listener;
		}

		//============== init sdk ==============
		public static function sdkInitWithAppId(appId:String,appKey:String):Boolean{

			if (_isIOS()){

				return TopOnAdvert.getInstance().extContext.call(TopOnFunctions.SDK_INIT,appId,appKey);

			}else if (_isAndroid()){

				return false;
			}else{

				trace("TopOn-Function-sdkInitWithAppId-Not a Android/iOS module");
				return false;
			}
		}

		public static function sdkVersion():String{
			if (_isIOS()){

				var sdkVersion:String = String(TopOnAdvert.getInstance().extContext.call(TopOnFunctions.SDK_VERSION));
				return sdkVersion;

			}else if (_isAndroid()){

				return "1.0";

			}else{

				return "TopOn-Function-sdkVersion-Not a Android/iOS module";

			}
		}

		//============== rewardVideo ==============
		public static function startVideoWithUnitId(unitId:String):void{

			if (_isIOS()){

				trace("yangwu load reward");
				TopOnAdvert.getInstance().extContext.call(TopOnFunctions.TO_VIDEO_START,unitId);

			}else if (_isAndroid()){


			}else{

				trace("TopOn-Function-startVideoWithUnitId-Not a Android/iOS module");

			}
		}

		public static function isReadyVideo(unitId:String):Boolean{

			if (_isIOS()){

				return TopOnAdvert.getInstance().extContext.call(TopOnFunctions.TO_VIDEO_IS_READY,unitId);

			}else if (_isAndroid()){

				return false;

			}else{

				trace("TopOn-Function-isReadyVideo-Not a Android/iOS module");
				return false;
			}

		}

		public static function showVideoWithUnitId(unitId:String):void{

			if (_isIOS()){

				TopOnAdvert.getInstance().extContext.call(TopOnFunctions.TO_VIDEO_SHOW,unitId);

			}else if (_isAndroid()){

			}else{

				trace("TopOn-Function-showVideoWithUnitId-Not a Android/iOS module");
			}
		}

		//============== interstitial ==============
		public static function startInterstitialWithUnitId(unitId:String):void{

			if (_isIOS()){

				TopOnAdvert.getInstance().extContext.call(TopOnFunctions.TO_INTERSTITIAL_START,unitId);

			}else if (_isAndroid()){

			}else{

				trace("TopOn-Function-startInterstitialWithUnitId-Not a Android/iOS module");
			}
		}

		public static function isReadyInterstitial(unitId:String):Boolean{

			if (_isIOS()){

				return TopOnAdvert.getInstance().extContext.call(TopOnFunctions.TO_INTERSTITIAL_IS_READY,unitId);

			}else if (_isAndroid()){

				return false;

			}else{

				trace("TopOn-Function-isReadyInterstitial-Not a Android/iOS module");
				return false;
			}
		}

		public static function showInterstitialWithUnitId(unitId:String):void{

			if (_isIOS()){

				TopOnAdvert.getInstance().extContext.call(TopOnFunctions.TO_INTERSTITIAL_SHOW,unitId);

			}else if (_isAndroid()){

			}else{

				trace("TopOn-Function-showInterstitialWithUnitId-Not a Android/iOS module");
			}
		}

		//============== banner ==============
		public static function startBannerWithUnitId(unitId:String):void{

			if (_isIOS()){

				TopOnAdvert.getInstance().extContext.call(TopOnFunctions.TO_BANNER_START,unitId);

			}else if (_isAndroid()){

			}else{

				trace("TopOn-Function-startBannerWithUnitId-Not a Android/iOS module");
			}
		}

		public static function setBannerAlign(align:String):void{

			if (_isIOS()){

				TopOnAdvert.getInstance().extContext.call(TopOnFunctions.TO_SET_BANNER_ALIGN,align);

			}else if (_isAndroid()){

			}else{

				trace("TopOn-Function-setBannerAlign-Not a Android/iOS module");
			}
		}

		public static function showBannerWithUnitId(unitId:String):void{

			if (_isIOS()){

				TopOnAdvert.getInstance().extContext.call(TopOnFunctions.TO_BANNER_SHOW,unitId);

			}else if (_isAndroid()){

			}else{

				trace("TopOn-Function-showBannerWithUnitId-Not a Android/iOS module");
			}
		}

		public static function hideBanner():void{

			if (_isIOS()){

				TopOnAdvert.getInstance().extContext.call(TopOnFunctions.TO_BANNER_HIDE);

			}else if (_isAndroid()){

			}else{

				trace("TopOn-Function-hideBanner-Not a Android/iOS module");
			}
		}

		public static function removeBanner():void{

			if (_isIOS()){

				TopOnAdvert.getInstance().extContext.call(TopOnFunctions.TO_BANNER_REMOVE);

			}else if (_isAndroid()){

			}else{

				trace("TopOn-Function-removeBanner-Not a Android/iOS module");
			}
		}
		

		public static function isReadyBanner(unitId:String):Boolean{

			if (_isIOS()){

				return TopOnAdvert.getInstance().extContext.call(TopOnFunctions.TO_BANNER_IS_READY,unitId);

			}else if (_isAndroid()){

				return false;
			}else{

				trace("TopOn-Function-isReadyBanner-Not a Android/iOS module");
				return false;
			}
		}


		//============== native ==============
		public static function startNativeWithUnitId(w:Number,h:Number,unitId:String):void{

			if (_isIOS()){

				TopOnAdvert.getInstance().extContext.call(TopOnFunctions.TO_NATIVE_START,w,h,unitId);

			}else if (_isAndroid()){

			}else{

				trace("TopOn-Function-startNativeWithUnitId-Not a Android/iOS module");
			}
		}

		public static function isReadyNativeWithUnitId(unitId:String):Boolean{

			if (_isIOS()){

				return TopOnAdvert.getInstance().extContext.call(TopOnFunctions.TO_NATIVE_IS_READY,unitId);

			}else if (_isAndroid()){

				return false;

			}else{

				trace("TopOn-Function-isReadyNative-Not a Android/iOS module");
				return false;
			}
		}

		public static function showNativeWithUnitId(unitId:String):void{

			if (_isIOS()){

				TopOnAdvert.getInstance().extContext.call(TopOnFunctions.TO_NATIVE_SHOW,unitId);

			}else if (_isAndroid()){

			}else{

				trace("TopOn-Function-showNativeWithUnidId-Not a Android/iOS module");
			}
		}

		public static function layoutNativeWithFrame(x:Number,y:Number,w:Number,h:Number):void{

			if (_isIOS()){

				TopOnAdvert.getInstance().extContext.call(TopOnFunctions.TO_NATIVE_LAYOUT,x,y,w,h);

			}else if (_isAndroid()){

			}else{

				trace("TopOn-Function-layoutNativeWithFrame-Not a Android/iOS module");
			}
		}

		public static function removeNative():void{

			if (_isIOS()){

				TopOnAdvert.getInstance().extContext.call(TopOnFunctions.TO_NATIVE_REMOVE);

			}else if (_isAndroid()){

			}else{

				trace("TopOn-Function-removeNative-Not a Android/iOS module");
			}
		}

		public static function setUserPurchased(isIAP:String):void{

			if (_isIOS()){

				TopOnAdvert.getInstance().extContext.call(TopOnFunctions.TO_USER_PURCHASE,isIAP);

			}else if (_isAndroid()){

			}else{

				trace("TopOn-Function-showSplash-Not a Android/iOS module");
			}
		}
		

		public static function isPrepareInterstitial():Boolean{

			if (_isIOS()){

				return TopOnAdvert.getInstance().extContext.call(TopOnFunctions.TO_IS_READY_IV);

			}else if (_isAndroid()){

				return false;
			}else{

				trace("TopOn-Function-isPrepareInterstitial-Not a Android/iOS module");
				return false;
			}
		}

		public static function setLogEnable():void{

			if (_isIOS()){

				TopOnAdvert.getInstance().extContext.call(TopOnFunctions.TO_SET_LOG_ENABLE);

			}else if (_isAndroid()){

			}else{

				trace("TopOn-Function-setLogEnable-Not a Android/iOS module");
			}
		}


		//============== native banner ==============
		public static function startNativeBannerWithUnitId(unitId:String):void{

			if (_isIOS()){

				TopOnAdvert.getInstance().extContext.call(TopOnFunctions.TO_NATIVE_BANNER_START,unitId);

			}else if (_isAndroid()){

			}else{

			}
		}

		public static function setNativeBannerAlign(align:String):void{

			if (_isIOS()){

				TopOnAdvert.getInstance().extContext.call(TopOnFunctions.TO_SET_NATIVE_BANNER_ALIGN,align);

			}else if (_isAndroid()){

			}else{
			}
		}

		public static function showNativeBannerWithUnitId(unitId:String):void{

			if (_isIOS()){

				TopOnAdvert.getInstance().extContext.call(TopOnFunctions.TO_NATIVE_BANNER_SHOW,unitId);

			}else if (_isAndroid()){

			}else{
			}
		}

		public static function hideNativeBanner():void{

			if (_isIOS()){

				TopOnAdvert.getInstance().extContext.call(TopOnFunctions.TO_NATIVE_BANNER_HIDE);

			}else if (_isAndroid()){

			}else{
			}
		}

		public static function removeNativeBanner():void{

			if (_isIOS()){

				TopOnAdvert.getInstance().extContext.call(TopOnFunctions.TO_NATIVE_BANNER_REMOVE);

			}else if (_isAndroid()){

			}else{
			}
		}

		public static function isReadyNativeBanner(unitId:String):Boolean{

			if (_isIOS()){

				return TopOnAdvert.getInstance().extContext.call(TopOnFunctions.TO_NATIVE_BANNER_IS_READY,unitId);

			}else if (_isAndroid()){

				return false;
			}else{

				return false;
			}
		}

		private static var sFunctionTicker:int;
		private static var sFunctionMap:Object = new Object();
		public static function functionToString(name:String,f:Function,singleInstance:Boolean):String{
			if(singleInstance){
				sFunctionMap[name] = f;
				return f == null ? null : name;
			}else{
				var key:String = sFunctionTicker + "";
				sFunctionMap[key] = f;
				sFunctionTicker ++;
				return  f == null ? null : key; 
			}
		}
	

		public function nativeCallBack(e:StatusEvent):void {

			trace("TopOn SDK code :" + e.code + "  level:"+  e.level);

			var version:String = TopOnAdvert.sdkVersion();
			if(version != null){

				trace("TopOn_SDK_Version : "+ version);
			}

			var json:String = e.level;

			var resp:Object = JSON.parse(json);
			
			var action:int = resp.what; 

			var rewardStatus:String=resp.reward_status;
			
			switch(action){

				///interstitial
				case TopOnPrivateConst.TopOnInterstitialClose:
				{
					if(this.interstitialCloseListener != null){
						this.interstitialCloseListener();
					}
				}
					break;

				case TopOnPrivateConst.TopOnInterstitialShow:
				{
					if(this.interstitialShowListener != null){
						this.interstitialShowListener();
					}
				}
					break;

				case TopOnPrivateConst.TopOnInterstitialShowFail:
				{
					if(this.interstitialShowFailListener != null){
						this.interstitialShowFailListener();
					}
				}
					break;

				case TopOnPrivateConst.TopOnInterstitialDidLoad:
				{
					if(this.interstitialDidLoadListener != null){
						this.interstitialDidLoadListener();
					}
				}
					break;

				case TopOnPrivateConst.TopOnInterstitialLoadFail:
				{
					if(this.interstitialLoadFailListener != null){
						this.interstitialLoadFailListener();
					}
				}
					break;

				case TopOnPrivateConst.TopOnInterstitialClick:
				{
					if(this.interstitialClickListener != null){
						this.interstitialClickListener();
					}
				}
					break;

				/// rewardVideo
				case TopOnPrivateConst.TopOnVideoClose:
				{
					if(this.videoCloseListener != null){
						this.videoCloseListener(rewardStatus);
					}
				}
					break;

				case TopOnPrivateConst.TopOnVideoClick:
				{
					if(this.videoClickListener != null){
						this.videoClickListener();
					}
				}
					break;

				case TopOnPrivateConst.TopOnVideoShow:
				{
					if(this.videoShowListener != null){
						this.videoShowListener();
					}
				}
					break;

				case TopOnPrivateConst.TopOnVideoShowFail:
				{
					if(this.videoShowFailListener != null){
						this.videoShowFailListener();
					}
				}
					break;

				case TopOnPrivateConst.TopOnVideoDidLoad:
				{
					if(this.videoDidLoadListener != null){
						this.videoDidLoadListener();
					}
				}
					break;

				case TopOnPrivateConst.TopOnVideoLoadFail:
				{
					if(this.videoLoadFailListener != null){
						this.videoLoadFailListener();
					}
				}
					break;

				///banner
				case TopOnPrivateConst.TopOnBannerDidShow:
				{
					if(this.bannerDidShowListener != null){
						this.bannerDidShowListener();
					}
				}
					break;

				case TopOnPrivateConst.TopOnBannerClose:
				{
					if(this.bannerCloseListener != null){
						this.bannerCloseListener();
					}
				}
					break;

				case TopOnPrivateConst.TopOnBannerDidLoad:
				{
					if(this.bannerDidLoadListener != null){
						this.bannerDidLoadListener();
					}
				}
					break;

				case TopOnPrivateConst.TopOnBannerLoadFail:
				{
					if(this.bannerLoadFailListener != null){
						this.bannerLoadFailListener();
					}
				}
					break;

				case TopOnPrivateConst.TopOnBannerClick:{
					if(this.bannerClickListener != null){
						this.bannerClickListener();
					}
				}
					break;

				///native
				case TopOnPrivateConst.TopOnNativeDidShow:
				{
					if(this.nativeDidShowListener != null){
						this.nativeDidShowListener();
					}
				}
					break;
				case TopOnPrivateConst.TopOnNativeLoadFail:
				{
					if(this.nativeLoadFailListener != null){
						this.nativeLoadFailListener();
					}
				}				
					break;
				case TopOnPrivateConst.TopOnNativeClick:
				{
					if(this.nativeClickListener != null){
						this.nativeClickListener();
					}
				}
					break;
				
				case TopOnPrivateConst.TopOnNativeStartPlay:
				{
					if(this.nativeStartPlayListener != null){
						this.nativeStartPlayListener();
					}
				}
					break;
				
				case TopOnPrivateConst.TopOnNativeEndPlay:
				{
					if(this.nativeEndPlayListener != null){
						this.nativeEndPlayListener();
					}
				}
					break;

				///splash
				case TopOnPrivateConst.TopOnSplashDidShow:
				{
					if(this.splashDidShowListener != null){
						this.splashDidShowListener();
					}
				}
					break;

				///native banner
				case TopOnPrivateConst.TopOnNativeBannerDidShow:
				{
					if(this.nativeBannerDidShowListener != null){
						this.nativeBannerDidShowListener();
					}
				}
					break;

				case TopOnPrivateConst.TopOnNativeBannerClose:
				{
					if(this.nativeBannerCloseListener != null){
						this.nativeBannerCloseListener();
					}
				}
					break;

				case TopOnPrivateConst.TopOnNativeBannerDidLoad:
				{
					if(this.nativeBannerDidLoadListener != null){
						this.nativeBannerDidLoadListener();
					}
				}
					break;

				case TopOnPrivateConst.TopOnNativeBannerLoadFail:
				{
					if(this.nativeBannerLoadFailListener != null){
						this.nativeBannerLoadFailListener();
					}
				}
					break;

				case TopOnPrivateConst.TopOnNativeBannerClick:
				{
					if(this.nativeBannerClickListener != null){
						this.nativeBannerClickListener();
					}
				}
					break;

				///xCode
				case TopOnPrivateConst.XCodeSendSixty:
				{
					if(!this._main){
						return;
					}				
					this._main["ActiveGame"]();
					if(this.xCodeDidSendSixtyListener !=null){
						this.xCodeDidSendSixtyListener();
					}
				}
					break;

				case TopOnPrivateConst.XCodeSendZero:
				{
					if (!this._main) {
						return
					}
					this._main["StopGame"]();
					TopOnAdvert.getInstance().extContext.call(TopOnFunctions.TO_STOP_DISPLAYLINK);
					if(this.xCodeDidSendZeroListener !=null){
						this.xCodeDidSendZeroListener();
					}
				}
					break;
			}
		} 
		public function TopOnAdvert(){
			if (!extContext) {
				extContext = ExtensionContext.createExtensionContext(EXTENSION_ID, null);
				if(extContext == null){
					trace("TopOn createExtensionContext error");
				}
				extContext.addEventListener( StatusEvent.STATUS, nativeCallBack);
			}   
		}
		
		public static function getInstance():TopOnAdvert {
			if(instance == null)
				instance = new TopOnAdvert();
			return instance;
		}
		
		public  function setMain(main:MovieClip):void {
		 	this._main = main;
		}
	}
}