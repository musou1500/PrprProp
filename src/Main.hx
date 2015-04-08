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
	var springs:Array<Spring>;
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
		// 正五角形の頂点を生成
		//45D5FE
		var colors = [0x45D5FE, 0xff3a7d];
		this.apples = new Array<FallenApple>();
		
		
		this.generateApple(0x45D5FE);
		// 10秒を基準に2秒前後
		var timer = new Timer(7500, 1);
		timer.addEventListener(TimerEvent.TIMER, function(e:Event) {
			this.generateApple(0xff3a7d);
		});
		timer.start();
		
		this.stage.addChild(new FPS());
		this.stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		// Stage:
		// stage.stageWidth x stage.stageHeight @ stage.dpiScale
		
		// Assets:
		// nme.Assets.getBitmapData("img/assetname.jpg");
	}
	

	public function generateApple(color:Int)
	{
		// 最大300 最低80
		var r = 220 - Std.random(140);
		var apple = new FallenApple(color, FallenApple.genRandomPoints(5, r, 0.7));
		this.stage.addChild(apple);
		apple.x = this.stage.stageWidth / 2;
		apple.y = 0 - r - 80;
		apple.speedY = 1.5;
		apple.springs[0].source.applyForce(new Vector3D(500*Math.random() - 250, 20*Math.random() - 10, 0));
		this.apples.push(apple);
		
		var next:Float = 15000 + Math.random() * 4000 - 2000;
		var timer = new Timer(next, 1);
		timer.addEventListener(TimerEvent.TIMER, function(e:Event) {
			this.generateApple(color);
		});
		timer.start();
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
			trace("removedNum:"+this.removedNum);
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
