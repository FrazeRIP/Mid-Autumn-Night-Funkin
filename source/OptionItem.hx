package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxMath;
import flixel.util.FlxTimer;
import flixel.text.FlxText;

using StringTools;

class OptionItem extends FlxText
{
	public var xAdd:Float = 0;
	public var yAdd:Float = 0;
	public var targetY:Float = 0;
	public var yMult:Float = 120;
	public var forceX:Float = Math.NEGATIVE_INFINITY;

	public function new(x:Float, y:Float, width:Int, rawtext:String, size:Int)
	{	
		super(x, y, width,rawtext,size);
	}

	override function update(elapsed:Float)
	{		
		var scaledY = FlxMath.remapToRange(targetY, 0, 1, 0, 1.3);

		var lerpVal:Float = CoolUtil.boundTo(elapsed * 9.6, 0, 1);
		y = FlxMath.lerp(y, (scaledY * yMult) + (FlxG.height * 0.48) + yAdd, lerpVal);
		if(forceX != Math.NEGATIVE_INFINITY) {
			x = forceX;
		} 
		else 
		{
			x = FlxMath.lerp(x, (targetY * 20) + 90 + xAdd, lerpVal);
		}

		super.update(elapsed);
	}
}
