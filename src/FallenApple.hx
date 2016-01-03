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
	public var speedX:Float;
	public var speedY:Float;
	// 0x526ed7 or 0xff3a7d
	public var color:UInt;
	public var numOfVertices:Int;
	
	// y座標が最小のポイント
	public var topPoint:Point = new Point(0, 0);
	
	public function new(color:UInt, initPoints:Array<Point>)
	{
		super();
		this.blendMode = BlendMode.MULTIPLY;
		this.color = color;
		this.points = new Array<SpringPoint>();
		var centerPoint:SpringPoint = new SpringPoint(0, 0, 99999);
		for (point in initPoints)
		{
			this.points.push(new SpringPoint(point.x, point.y, 120));
			centerPoint.x += point.x;
			centerPoint.y += point.y;
		}
		this.numOfVertices = initPoints.length;
		centerPoint.x = centerPoint.x / this.numOfVertices;
		centerPoint.y = centerPoint.y / this.numOfVertices;
		
		this.springs = new Array<Spring>();
		for (i in 0...this.numOfVertices) {
			var distinationIdx = i + 1;
			if (i == this.numOfVertices - 1) {
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
		this.graphics.clear();
		for (spring in this.springs)
		{
			spring.update();
		}
		
		this.topPoint = new Point(this.springs[0].source.x, this.springs[0].source.y); 
		for (spring in this.springs)
		{
			spring.updateSpeed();
			

			// topPointの更新
			if (spring.source.y < this.topPoint.y) {
				this.topPoint.setTo(spring.source.x, spring.source.y);
			}
			if (spring.distination.y < this.topPoint.y) {
				this.topPoint.setTo(spring.distination.x, spring.distination.y);
			}
		}
		this.x += this.speedX;
		this.y += this.speedY;
		// 0x526ed7
		this.graphics.beginFill(this.color, 1.0);
		this.graphics.moveTo(
			(this.points[0].x + this.points[1].x) / 2,
			(this.points[0].y + this.points[1].y) / 2
		);
		
		// 最後のセットに新しい中間点を追加する必要はないので2つ分の点を引いておく
		//for (var i:int = 1; i < POINT_NUM - 2; i++)
		for (i in 1...this.numOfVertices)
		{
			var cp:Point;
			if (i == this.numOfVertices - 1)
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
		
		/*
		this.graphics.lineStyle(0.3, 0x000000);
		for (spring in this.springs)
		{
			this.graphics.moveTo(spring.source.x, spring.source.y);
			this.graphics.lineTo(spring.distination.x, spring.distination.y);
		}*/
	}
	/*
	 * @param numOfVertices 頂点の数
	 * @param r 半径
	 * @param circlenum 円っぽさ
	 * */
	public static function genRandomPoints(numOfVertices:Int, r:Int)
	{
		// 五角形の各頂点を生成
		var points = new Array<Point>();
		for (i in 0...numOfVertices)
		{
			var degree = i * 360 / numOfVertices;
			var scale = 1 - Math.random() / 3;
			var tx:Float = Math.cos(degree * Math.PI / 180) * r;
			var ty:Float = Math.sin(degree * Math.PI / 180) * r;
			points.push(new Point(scale * tx, scale * ty));
		}
		return points;
	}
	public function applyForce(springId:Int)
	{
		
	}
}
