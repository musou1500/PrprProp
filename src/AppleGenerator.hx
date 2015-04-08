package;
import openfl.events.EventDispatcher;
import openfl.events.TimerEvent;
import openfl.utils.Timer;

/**
 * 指定した時間ごとに指定した色のものを、いい感じの大きさで生成する。
 * @author musou1500
 */
class AppleGenerator/* extends EventDispatcher*/
{
	public var color:Int;
	public var interval:Int;
	private var timer:Timer;
	public function new(color:Int, interval:Int) 
	{
		this.interval = interval;
		this.color = color;
		
	}
	
	public function startGenerate()
	{
		this.generate();
	}
	
	public function stopGenerate()
	{
		this.timer.stop();
	}
	
	public function generate()
	{
		/*
		// とりあえず固定値
		var r = 220 - Std.random(140);
		
		// 経験則で5角形が割と安定する
		var apple = new FallenApple(this.color, FallenApple.genRandomPoints(5, r, 0.7));
		var event = new AppleGeneratorEvent(AppleGeneratorEvent.APPLE_GENERATE, apple);
		//this.dispatchEvent(event);
		
		// 次の生成スケジュール
		// デフォルトでインターバルに3秒の振れ幅を持たせる
		var next:Float = this.interval + Math.random() * 6000 - 3000;
		this.timer = new Timer(next, 1);
		
		this.timer.addEventListener(TimerEvent.TIMER, function(e:Event) {
			this.generate();
		});
		this.timer.start();*/
	}
	
}