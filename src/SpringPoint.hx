package ;
import openfl.geom.Point;
import openfl.geom.Vector3D;

/**
 * ...
 * @author musou1500
 */
class SpringPoint extends Vector3D
{
	public var weight:Float;
	public var strength:Vector3D;
	public var speed:Vector3D;
	public var acceleration:Vector3D;
	public function new(x:Float, y:Float, weight:Float) 
	{
		super(x, y, 0, 0);
		this.weight = weight;
		this.speed = new Vector3D(0, 0, 0, 0);
		this.strength = new Vector3D(0, 0, 0, 0);
		this.acceleration = new Vector3D(0, 0, 0, 0);
	}
	public function applyForce(strength:Vector3D)
	{
		this.strength = this.strength.add(strength);
	}
	
	public static function create(v:Vector3D, weight:Int)
	{
		return new SpringPoint(v.x, v.y, weight);
	}
	
	public function updateSpeed()
	{
		
		this.acceleration = this.strength.clone();
		this.acceleration.scaleBy(1 / this.weight);
		
		// sourceのスピードを更新
		//this.source.speed = this.source.speed.add(this.source.acceleration);
		this.speed = this.speed.add(this.acceleration);
		
		var tmp = this.add(this.speed);
		this.x = tmp.x;
		this.y = tmp.y;
		this.acceleration.setTo(0, 0, 0);
		this.strength.setTo(0, 0, 0);
	}
	
}