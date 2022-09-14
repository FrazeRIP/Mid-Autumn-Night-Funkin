package options;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.FlxSubState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSave;
import haxe.Json;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import Controls;

using StringTools;

class GameplaySettingsSubState extends BaseOptionsMenu
{
	public function new()
	{
		title = '游玩效果设置';
		rpcTitle = 'Gameplay Settings Menu'; //for Discord Rich Presence

		var option:Option = new Option('控制器模式',
			'如果想使用手柄而不是键盘游玩游戏，请选中该项。',
			'controllerMode',
			'bool',
			false);
		addOption(option);

		//I'd suggest using "Downscroll" as an example for making your own option since it is the simplest here
		var option:Option = new Option('下落式', //Name
			'选中时，游戏模式由上升式切换为下落式。', //Description
			'downScroll', //Save data variable name
			'bool', //Variable type
			false); //Default value
		addOption(option);

		var option:Option = new Option('音符居中',
			'选中时，音符将会居中显示。',
			'middleScroll',
			'bool',
			false);
		addOption(option);

		var option:Option = new Option('对手音符',
			'未选中时，对手的音符将会被隐藏。',
			'opponentStrums',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('允许空按',
			"选中时，当轨道上没有可击打音符，\n按下对应方向键不会导致miss。",
			'ghostTapping',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('屏蔽重开键',
			"选中时，重开键会被屏蔽，避免误触。",
			'noReset',
			'bool',
			false);
		addOption(option);

		var option:Option = new Option('打击音效',
			'命中音符时会发出“嗒!”的音效。',
			'hitsoundVolume',
			'percent',
			0);
		addOption(option);
		option.scrollSpeed = 1.6;
		option.minValue = 0.0;
		option.maxValue = 1;
		option.changeValue = 0.1;
		option.decimals = 1;
		option.onChange = onChangeHitsoundVolume;

		var option:Option = new Option('判定延迟',
			'调整“Sick!”判定的延迟值，\n数值越高代表完美命中的时机越往后。',
			'ratingOffset',
			'int',
			0);
		option.displayFormat = '%vms';
		option.scrollSpeed = 20;
		option.minValue = -30;
		option.maxValue = 30;
		addOption(option);

		var option:Option = new Option('完美判定区间',
			'以毫秒为单位调整“Sick!”判定的前后可误差范围。',
			'sickWindow',
			'int',
			45);
		option.displayFormat = '%vms';
		option.scrollSpeed = 15;
		option.minValue = 15;
		option.maxValue = 45;
		addOption(option);

		var option:Option = new Option('良好判定区间',
			'以毫秒为单位调整“Good”判定的前后可误差范围。',
			'goodWindow',
			'int',
			90);
		option.displayFormat = '%vms';
		option.scrollSpeed = 30;
		option.minValue = 15;
		option.maxValue = 90;
		addOption(option);

		var option:Option = new Option('差判定区间',
			'以毫秒为单位调整“Bad”判定的前后可误差范围。',
			'badWindow',
			'int',
			135);
		option.displayFormat = '%vms';
		option.scrollSpeed = 60;
		option.minValue = 15;
		option.maxValue = 135;
		addOption(option);

		var option:Option = new Option('安全帧',
			'调整安全帧范围，在安全帧之外按下按键，\n将会被判定为按得过早或过晚。',
			'safeFrames',
			'float',
			10);
		option.scrollSpeed = 5;
		option.minValue = 2;
		option.maxValue = 10;
		option.changeValue = 0.1;
		addOption(option);

		super();
	}

	function onChangeHitsoundVolume()
	{
		FlxG.sound.play(Paths.sound('hitsound'), ClientPrefs.hitsoundVolume);
	}
}