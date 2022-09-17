package;

import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.text.FlxText;

class AttachedValueText extends FlxText
{
	public var offsetX:Float = 0;
	public var offsetY:Float = 0;
	public var sprTracker:FlxSprite;
	public var copyVisible:Bool = true;
	public var copyAlpha:Bool = false;
	private var displayText:String = '';

	public function new(x:Float, y:Float, width:Int, rawtext:String, size:Int)
	{	

		switch (rawtext)
		{
			case 'None':
				displayText = '无音乐';
			case 'Breakfast':
				displayText = '早餐';
			case 'Tea Time':
				displayText = '午茶时光';
			case 'Time Left':
				displayText = '剩余时长';
			case 'Time Elapsed':
				displayText = '已游玩时长';
			case 'Song Name':
				displayText = '歌曲名称';
			case 'Disabled':
				displayText = '不显示';
			case 'multiplicative':
				displayText = '默认谱速乘倍率';
			case 'constant':
				displayText = '谱面速度实值';
			default:
				displayText = rawtext;
		}

		super(x, y, width,displayText,size);
	}

	public function changeText(newText:String)
	{
		switch (newText)
		{
			case 'None':
				displayText = '无音乐';
			case 'Breakfast':
				displayText = '早餐';
			case 'Tea Time':
				displayText = '午茶时光';
			case 'Time Left':
				displayText = '剩余时长';
			case 'Time Elapsed':
				displayText = '已游玩时长';
			case 'Song Name':
				displayText = '歌曲名称';
			case 'Disabled':
				displayText = '不显示';
			case 'multiplicative':
				displayText = '默认谱速乘倍率';
			case 'constant':
				displayText = '谱面速度实值';
			default:
				displayText = newText;
		}

		text = displayText;
		fieldWidth = 66 * (text.length + 1);
	}

	override function update(elapsed:Float) 
	{
		if (sprTracker != null) 
		{
			setPosition(sprTracker.x + offsetX, sprTracker.y + offsetY);
			if(copyVisible) 
			{
				visible = sprTracker.visible;
			}
			if(copyAlpha) 
			{
				alpha = sprTracker.alpha;
			}
		}

		super.update(elapsed);
	}
}