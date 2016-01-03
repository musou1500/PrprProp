package;
import openfl.Lib;
import openfl.events.EventDispatcher;
import openfl.events.TimerEvent;
import openfl.utils.Timer;
import openfl.geom.Point;

/**
 * 指定した時間ごとに指定した色のものを、いい感じの大きさで生成する。
 * @author musou1500
 */
class AppleGenerator extends EventDispatcher
{
	public var color:Int;
	public var interval:Int;
	public var point:Point;
	private var timer:Timer;
	public function new(point:Point, color:Int, interval:Int)
	{
		super(Lib.current);
		this.interval = interval;
		this.color = color;
		this.point = point;
		this.timer = null;
	}

	public function start()
	{
		this.generate();
		this.timer = new Timer(this.interval + Math.random() * 3000, 0);
		timer.addEventListener(TimerEvent.TIMER, function(e:TimerEvent) {
			this.generate();
		});
		this.timer.start();
	}
	
	public function stop()
	{
		if (this.timer == null) {
			return;
		}
		this.timer.stop();
		this.timer = null;
	}
	
	public function generate()
	{
		var radius = 250 - Std.random(50);
		var apple = new FallenApple(color, FallenApple.genRandomPoints(5, radius));
		apple.x = this.point.x;
		apple.y = this.point.y;

		var event = new AppleGeneratorEvent(AppleGeneratorEvent.APPLE_GENERATE, apple, radius);
		this.dispatchEvent(event);
	}
	
}
