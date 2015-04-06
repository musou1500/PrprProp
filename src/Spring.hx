package ;
import haxe.ds.StringMap;
import haxe.ds.Vector;
import openfl.display.Sprite;
import openfl.geom.Vector3D;
import openfl.geom.Point;

/**
 * ...
 * @author musou1500
 */
class Spring extends Sprite
{
	// 初期の長さ
	private var initLength:Float;
	
	// バネ定数
	private var k:Float;
	
	// ぶら下がってる物体
	public var source:SpringPoint;
	public var distination:SpringPoint;
	
	private var powOfSpring:Vector3D;
	
	public function new(k:Float, source:SpringPoint, distination:SpringPoint)
	{
		super();
		// 始点と終点のポイントを登録
		this.source = source;
		this.distination = distination;
		
		// 始点と終点との距離を計算
		this.initLength = Vector3D.distance(this.source, this.distination);
		
		this.k = k;
		this.powOfSpring = new Vector3D(0, 0, 0, 0);
	}
	
	/*
	 * 現在の各ポイントにかかっている力に合わせてパラメータを更新
	 * */
	public function update() {
		// 変位量ベクトルを計算
		var length = Vector3D.distance(this.source, this.distination);
		var ratio = this.initLength / length;
		
		// difference of position vector between source and d"e"stination
		var diffVector = this.distination.subtract(this.source);
		var changeVector = diffVector.clone();
		
		diffVector.scaleBy(ratio);
		changeVector = changeVector.subtract(diffVector);
		
		// バネの反発力を計算
		this.powOfSpring = changeVector.clone();
		this.powOfSpring.scaleBy(0 - this.k);
		
		var powOfSourceSpring = this.powOfSpring.clone();
		powOfSourceSpring.scaleBy( -1);
		this.source.strength = this.source.strength.add(powOfSourceSpring);
		this.distination.strength = this.distination.strength.add(this.powOfSpring);
	}
	public function updateSpeed()
	{
		this.source.updateSpeed();
		this.distination.updateSpeed();
	}
	
}