package ;
import openfl.display.Sprite;
import openfl.geom.Point;
import openfl.display.BlendMode;

/**
 * ...
 * @author musou1500
 */
class FallenApple extends Sprite
{
	public var springs:Array<Spring>;
	public var points:Array<SpringPoint>;
	// 0x526ed7 or 0xff3a7d
	public var color:UInt;
	public function new(color:UInt, initPoints:Array<Point>)
	{
		super();
		this.blendMode = BlendMode.MULTIPLY;
		this.color = color;
		this.points = new Array<SpringPoint>();
		var centerPoint:SpringPoint = new SpringPoint(0, 0, 900);
		for (point in initPoints)
		{
			this.points.push(new SpringPoint(point.x, point.y, 120));
			centerPoint.x += point.x;
			centerPoint.y += point.y;
		}
		centerPoint.x = centerPoint.x / 5;
		centerPoint.y = centerPoint.y / 5;
		
		this.springs = new Array<Spring>();
		for (i in 0...5) {
			var distinationIdx = i + 1;
			if (i == 4) {
				distinationIdx = 0;
			}
			var spring = new Spring(0.5, this.points[i], this.points[distinationIdx]);
			this.springs.push(spring);
			
			var spring2 = new Spring(0.5, centerPoint, points[i]);
			this.springs.push(spring2);
		}
	}
	public function update()
	{
		this.y += 1.5;
		this.graphics.clear();
		for (spring in this.springs)
		{
			spring.update();
		}
		for (spring in this.springs)
		{
			spring.updateSpeed();
		}
		// 0x526ed7
		this.graphics.beginFill(this.color, 1.0);
		this.graphics.moveTo(
			(this.points[0].x + this.points[1].x) / 2,
			(this.points[0].y + this.points[1].y) / 2
		);
		
		// 最後のセットに新しい中間点を追加する必要はないので2つ分の点を引いておく
		//for (var i:int = 1; i < POINT_NUM - 2; i++)
		for (i in 1...5)
		{
			var cp:Point;
			if (i == 4)
			{
				cp = new Point((this.points[i].x + this.points[0].x) / 2, (this.points[i].y + this.points[0].y) / 2);
			}
			else
			{
				cp = new Point((this.points[i].x + this.points[i + 1].x) / 2, (this.points[i].y + this.points[i + 1].y) / 2);
			}
			this.graphics.curveTo(this.points[i].x, this.points[i].y, cp.x, cp.y);
		}
		// 最後のセットを描画
		this.graphics.curveTo(this.points[0].x, this.points[0].y,
			(this.points[0].x + this.points[1].x) / 2,
			(this.points[0].y + this.points[1].y) / 2
		);
		this.graphics.endFill();
	}
	/*
	 * @r 半径
	 * @circlenum 円っぽさ
	 * */
	public static function genRandomPoints(r:Int, circleNum:Float)
	{
		// 五角形の各頂点を生成
		var points = new Array<Point>();
		for (i in 0...5)
		{
			var degree = i * 360 / 5;
			var tx:Float = (Math.random() * circleNum + 1) * Math.cos(degree * Math.PI / 180) * r;
			var ty:Float = (Math.random() * circleNum + 1) * Math.sin(degree * Math.PI / 180) * r;
			points.push(new Point(tx, ty));
		}
		return points;
	}
	public function applyForce(springId:Int)
	{
		
	}
}