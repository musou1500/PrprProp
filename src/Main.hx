package ;

import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import openfl.display.FPS;
import openfl.events.MouseEvent;
import openfl.events.TimerEvent;
import openfl.geom.Point;
import openfl.geom.Vector3D;
import openfl.display.BlendMode;
import openfl.utils.Timer;
/**
 * ...
 * @author musou1500
 */

class Main extends Sprite 
{
	var inited:Bool;
	var apples:Array<FallenApple>;
	var generators:Array<AppleGenerator>;
	var points:Array<SpringPoint>;

	/* ENTRY POINT */
	
	function resize(e) 
	{
		if (!inited) init();
		// else (resize or orientation change)
	}
	
	function init() 
	{
		if (inited) return;
		inited = true;
		this.stage.blendMode = BlendMode.LAYER;
		this.generators = new Array<AppleGenerator>();
		this.apples = new Array<FallenApple>();
		/*
		 * 各モードでのカラーコード
		 * Normal          : 0x45D5FE, 0xff3a7d
		 * AREANA MODE     : 0x73FFE4, 0xFFED00
		 * COURCE MODE     : 0xFF31AD, 0x7400BD
		 * UNLOCK Challenge: 0xFF4900
		 **/
		var colors = [0x45D5FE, 0xff3A7D];
		for( i in 0...colors.length ){
			var color = colors[i];
			// 上から落とすタイプのジェネレータ
			var topCenter = new Point(this.stage.stageWidth / 2, 0);
			var generator = new AppleGenerator(topCenter, color, 13000);
			generator.addEventListener(AppleGeneratorEvent.APPLE_GENERATE, function(e:AppleGeneratorEvent) {
				var apple = e.apple;
				apple.x = this.stage.stageWidth / 2;
				apple.y = 0 - e.radius;
				apple.speedX = 0.8 - (i % 2 * 1.2);
				apple.speedY = 1.5;
				apple.springs[0].source.applyForce(new Vector3D(20 * Math.random() +80, 20 * Math.random()+80, 0));
				this.apples.push(apple);
				this.stage.addChild(apple);
			});
			generator.start();
			this.generators.push(generator);

		}

		this.stage.addChild(new FPS());
		this.stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		// Stage:
		// stage.stageWidth x stage.stageHeight @ stage.dpiScale
		
		// Assets:
		// nme.Assets.getBitmapData("img/assetname.jpg");
	}
	
	var removedNum:Int = 0;
	public function onEnterFrame(e:Event)
	{
		var removedApples = new Array<FallenApple>();
		for (apple in this.apples)
		{
			// もしも画面外なら削除する
			if (apple.topPoint.y + apple.y > this.stage.stageHeight) {
				//this.stage.removeChild(apple);
				removedApples.push(apple);
			}
			apple.update();
		}
		if(removedApples.length > 0) {
			this.removedNum += removedApples.length;
		}
		for (apple in removedApples) {
			this.apples.remove(apple);
			this.stage.removeChild(apple);
		}
	}
	/* SETUP */

	public function new() 
	{
		super();	
		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	function added(e) 
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		stage.addEventListener(Event.RESIZE, resize);
		#if ios
		haxe.Timer.delay(init, 100); // iOS 6
		#else
		init();
		#end
	}
	
	public static function main() 
	{
		// static entry point
		Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		Lib.current.addChild(new Main());
	}
}
