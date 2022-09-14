package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import lime.app.Application;
import Achievements;
import editors.MasterEditorMenu;
import flixel.input.keyboard.FlxKey;
import flixel.util.FlxTimer;
import flixel.math.FlxRandom;
import openfl.filters.BitmapFilter;
import openfl.filters.BlurFilter;

using StringTools;

class MainMenuState extends MusicBeatState
{
	public static var psychEngineVersion:String = '0.6.2'; //This is also used for Discord RPC
	public static var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<MainMenuItem>;
	private var camGame:FlxCamera;
	private var camFirewrok:FlxCamera;
	private var camAchievement:FlxCamera;
	public var camFront:FlxCamera;
	
	var optionShit:Array<String> = [
		'story_mode',
		'freeplay',
		#if ACHIEVEMENTS_ALLOWED 'awards', #end
		'credits',
		'options'
	];

	var fireworkColor:Array<FlxColor> = [0xFFEE82EE,0xFFFACF80,0xFFFFFF00,0xFFFF4500,0xFF00FF00,0xFFF5F5F5,0xFF87CEFA];

	var desText:FlxText;

//	var camFollow:FlxObject;
//	var camFollowPos:FlxObject;
	var debugKeys:Array<FlxKey>;

	var blurEff:Array<BitmapFilter> = [];
	public static var firstStart:Bool = true;

	override function create()
	{
		#if MODS_ALLOWED
		Paths.pushGlobalMods();
		#end
		WeekData.loadTheFirstEnabledMod();

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end
		debugKeys = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('debug_1'));

		blurEff[0] = new BlurFilter(6, 6, openfl.filters.BitmapFilterQuality.LOW);

		camGame = new FlxCamera();
		camFirewrok = new FlxCamera();
		camFirewrok.bgColor.alpha = 0;
		camFront = new FlxCamera();
		camFront.bgColor.alpha = 0;
		camAchievement = new FlxCamera();
		camAchievement.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camFirewrok, false);
		FlxG.cameras.add(camFront, false);
		FlxG.cameras.add(camAchievement, false);

		camFirewrok.setFilters(blurEff);

		FlxG.cameras.setDefaultDrawTarget(camGame, true);
		CustomFadeTransition.nextCamera = camFront;

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = persistentDraw = true;

		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('mainmenu/background','mid-autumn'));
		bg.scrollFactor.set(0, 0);
		bg.setGraphicSize(Std.int(bg.width * 0.67));
		bg.updateHitbox();
		bg.screenCenter(Y);
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);

		var cloud_left:FlxSprite = new FlxSprite(-750, 0).loadGraphic(Paths.image('mainmenu/cloud_left','mid-autumn'));
		cloud_left.scrollFactor.set(0, 0);
		cloud_left.antialiasing = ClientPrefs.globalAntialiasing;
		add(cloud_left);
		FlxTween.tween(cloud_left, {x: 0}, 1.8, {ease: FlxEase.sineOut});

		var cloud_right:FlxSprite = new FlxSprite(1350,-360).loadGraphic(Paths.image('mainmenu/cloud_right','mid-autumn'));
		cloud_right.scrollFactor.set(0, 0);
		cloud_right.antialiasing = ClientPrefs.globalAntialiasing;
		add(cloud_right);
		FlxTween.tween(cloud_right, {x: 389}, 1.8, {ease: FlxEase.sineOut});

		var frame:FlxSprite = new FlxSprite().loadGraphic(Paths.image('mainmenu/frame','mid-autumn'));
		frame.setGraphicSize(Std.int(frame.width * 0.65));
		frame.updateHitbox();
		frame.screenCenter(X);
		frame.antialiasing = ClientPrefs.globalAntialiasing;
		frame.cameras = [camFront];
		add(frame);

		var bar:FlxSprite = new FlxSprite().loadGraphic(Paths.image('mainmenu/description_bar','mid-autumn'));
		bar.setGraphicSize(Std.int(bar.width * 0.67));
		bar.updateHitbox();
		bar.screenCenter(X);
		bar.antialiasing = ClientPrefs.globalAntialiasing;
		bar.cameras = [camFront];
		add(bar);

		desText = new FlxText(0, FlxG.height - 70, 720, " ", 46);
		desText.setFormat(Paths.font("ZhengDaoCuShuTi.ttf"), 46, FlxColor.WHITE, CENTER);
		desText.screenCenter(X);
		desText.cameras = [camFront];
		add(desText);

		// camFollow = new FlxObject(0, 0, 1, 1);
		// camFollowPos = new FlxObject(0, 0, 1, 1);
		// add(camFollow);
		// add(camFollowPos);

		menuItems = new FlxTypedGroup<MainMenuItem>();
		add(menuItems);

		var scale:Float = 1;
		/*if(optionShit.length > 6) {
			scale = 6 / optionShit.length;
		}*/

		for (i in 0...optionShit.length)
		{
			var menuItem:MainMenuItem = new MainMenuItem(FlxG.width * 1.2, 0, optionShit[i]);
			menuItem.scale.x = scale;
			menuItem.scale.y = scale;
			menuItem.animation.play('idle');
			menuItem.ID = i;
			menuItem.targetX = i;
			menuItem.screenCenter(Y);
		//	menuItem.visible = false;
			menuItems.add(menuItem);
			var scr:Float = (optionShit.length - 4) * 0.135;
			menuItem.antialiasing = ClientPrefs.globalAntialiasing;
			menuItem.cameras = [camFront];
			//menuItem.setGraphicSize(Std.int(menuItem.width * 0.58));
			menuItem.updateHitbox();

			if (firstStart)
			{
				FlxTween.tween(menuItem,{x: 563 + (i * 160) + (i > 0 ? 80 : 0) },0.8 + (i * 0.25) ,{ease: FlxEase.sineInOut, onComplete: function(flxTween:FlxTween) 
				{ 
					menuItem.finishedFunnyMove = true; 
				}});
			}
			else
			{
				menuItem.x = 563 + (i * 160) + (i > 0 ? 80 : 0);
				menuItem.finishedFunnyMove = true;			
			}			
		}

		firstStart = false;
		changeItem();

		// FlxG.camera.follow(camFollowPos, null, 1);

		// changeItem();

		#if ACHIEVEMENTS_ALLOWED
		Achievements.loadAchievements();
		var leDate = Date.now();
		if (leDate.getDay() == 5 && leDate.getHours() >= 18) {
			var achieveID:Int = Achievements.getAchievementIndex('friday_night_play');
			if(!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveID][2])) { //It's a friday night. WEEEEEEEEEEEEEEEEEE
				Achievements.achievementsMap.set(Achievements.achievementsStuff[achieveID][2], true);
				giveAchievement();
				ClientPrefs.saveSettings();
			}
		}
		#end

		super.create();
	}

	#if ACHIEVEMENTS_ALLOWED
	// Unlocks "Freaky on a Friday Night" achievement
	function giveAchievement() {
		add(new AchievementObject('friday_night_play', camAchievement));
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
		trace('Giving achievement "friday_night_play"');
	}
	#end

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
			if(FreeplayState.vocals != null) FreeplayState.vocals.volume += 0.5 * elapsed;
		}

		// var lerpVal:Float = CoolUtil.boundTo(elapsed * 7.5, 0, 1);
		// camFollowPos.setPosition(FlxMath.lerp(camFollowPos.x, camFollow.x, lerpVal), FlxMath.lerp(camFollowPos.y, camFollow.y, lerpVal));

		if (!selectedSomethin)
		{
			if (controls.UI_LEFT_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
			}

			if (controls.UI_RIGHT_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
			}

			if (controls.BACK)
			{
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new TitleState());
			}

			if (controls.ACCEPT)
			{
				CustomFadeTransition.nextCamera = camFront;

				if (optionShit[curSelected] == 'donate')
				{
					CoolUtil.browserLoad('https://ninja-muffin24.itch.io/funkin');
				}
				else
				{
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('confirmMenu'));

					menuItems.forEach(function(spr:FlxSprite)
					{
						if (curSelected != spr.ID)
						{
							FlxTween.tween(spr, {alpha: 0}, 0.4, {
								ease: FlxEase.quadOut,
								onComplete: function(twn:FlxTween)
								{
									spr.kill();
								}
							});
						}
						else
						{
							FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
							{
								var daChoice:String = optionShit[curSelected];

								switch (daChoice)
								{
									case 'story_mode':
										MusicBeatState.switchState(new StoryMenuState());
									case 'freeplay':
										MusicBeatState.switchState(new FreeplayState());
									#if MODS_ALLOWED
									case 'mods':
										MusicBeatState.switchState(new ModsMenuState());
									#end
									case 'awards':
										MusicBeatState.switchState(new AchievementsMenuState());
									case 'credits':
										MusicBeatState.switchState(new CreditsState());
									case 'options':
										LoadingState.loadAndSwitchState(new options.OptionsState());
								}
							});
						}
					});
				}
			}
			#if desktop
			else if (FlxG.keys.anyJustPressed(debugKeys))
			{
				selectedSomethin = true;
				CustomFadeTransition.nextCamera = camFront;
				MusicBeatState.switchState(new MasterEditorMenu());
			}
			#end
		}

		if (FlxG.random.bool(1))
		{
			fireworkBoom();
		}

		super.update(elapsed);

		// menuItems.forEach(function(spr:FlxSprite)
		// {
		// 	spr.screenCenter(Y);
		// });
	}

	function changeItem(huh:Int = 0)
	{
		curSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;

		var root:Int = 0;

		for (item in menuItems.members)
		{
			item.targetX = root - curSelected;
			root++;
		}

		menuItems.forEach(function(spr:MainMenuItem)
		{
			spr.animation.play('idle');
			spr.updateHitbox();

			if (spr.ID == curSelected)
			{
				spr.animation.play('selected');
				
				// camFollow.setPosition(spr.getGraphicMidpoint().x + curSelected * 80, spr.getGraphicMidpoint().y);
				spr.centerOffsets();

				switch (spr.ID)
				{
					case 0:
						desText.text = "~开始游戏~";
					case 1:
						desText.text = "~自由模式~";
					case 2:
						desText.text = "~成就系统~";
					case 3:
						desText.text = "~制作名单~";
					case 4:
						desText.text = "~游戏设置~";
				}
			}
		});
	}

	function fireworkBoom():Void
	{
		var firework:FlxSprite = new FlxSprite(FlxG.random.int(200, 600), FlxG.random.int(0, 400));
		firework.frames = Paths.getSparrowAtlas('mainmenu/firework','mid-autumn');
		firework.animation.addByPrefix('idle', "Firework", 24, false);
		firework.setGraphicSize(Std.int(firework.width * 0.67));
		firework.updateHitbox();
		firework.cameras = [camFirewrok];
		firework.color = fireworkColor[FlxG.random.int(0,fireworkColor.length - 1)];
		add(firework);
		firework.animation.play('idle',true);

		new FlxTimer().start(0.8, function(tmr:FlxTimer)
		{
			firework.destroy();		
		});
	}
}

class MainMenuItem extends FlxSprite
{
	public var targetX:Float = 0;
	var offsets:Int = 0;
	public var finishedFunnyMove:Bool = false;

	public function new(x:Float, y:Float, optionName:String = '')
	{
		super(x, y);
		frames = Paths.getSparrowAtlas('mainmenu/menu_' + optionName);
		animation.addByPrefix('idle', optionName + " basic", 24);
		animation.addByPrefix('selected', optionName + " white", 24);

		antialiasing = ClientPrefs.globalAntialiasing;
	}
	
	var fakeFramerate:Int = Math.round((1 / FlxG.elapsed) / 10);

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (finishedFunnyMove)
		{
			if (targetX > 0)
				offsets = 80;
			else if (targetX < 0)
				offsets = -80;
			else
				offsets = 0;
	
			x = FlxMath.lerp(x, 563 + (targetX * 160) + offsets, CoolUtil.boundTo(elapsed * 10.2, 0, 1));
		}	
	}
}
