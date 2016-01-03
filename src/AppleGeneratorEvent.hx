package;
import openfl.events.Event;

/**
 * ...
 * @author ...
 */
class AppleGeneratorEvent extends Event
{
	public static var APPLE_GENERATE = "APPLE_GENERATE";
	public var apple:FallenApple;
	public var radius:Int;
	public function new(type:String, apple:FallenApple, radius:Int) 
	{
		super(type);
		this.apple = apple;
		this.radius = radius;
	}
	
}
