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
		'StoryMode',
		'Freeplay',
		'Collection',
		'Credits',
		'Options'
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
			var menuItem:MainMenuItem = new MainMenuItem(380 + (i * 360) + (i > 0 ? 80 : 0), 120, optionShit[i]);
			menuItem.ID = i;
			menuItem.targetX = i;
			menuItem.alpha=0;
		
		//	menuItem.visible = false;
			menuItems.add(menuItem);
			add(menuItem.enterShadow);
			var scr:Float = (optionShit.length - 4) * 0.135;
			menuItem.antialiasing = ClientPrefs.globalAntialiasing;
			menuItem.cameras = [camFront];
			menuItem.enterShadow.cameras=[camFront];
			//menuItem.setGraphicSize(Std.int(menuItem.width * 0.58));
			menuItem.updateHitbox();

			if (firstStart)
			{
				if(i==curSelected){
					menuItem.scale.x = scale*0.65;
					menuItem.scale.y = scale*0.65;
					FlxTween.tween(menuItem,{x: 380 + (i * 360) + (i > 0 ? 80 : 0),y: 120,alpha:1},0.8 + (i * 0.25) ,{ease: FlxEase.sineInOut, onComplete: function(flxTween:FlxTween) 
						{
							menuItem.finishedFunnyMove = true; 
						}});
				}
				else{
					menuItem.scale.x = scale*0.5;
					menuItem.scale.y = scale*0.5;
					FlxTween.tween(menuItem,{x: 380 + (i * 360) + (i > 0 ? 80 : 0),y: 120,alpha:0.8},0.8 + (i * 0.25) ,{ease: FlxEase.sineInOut, onComplete: function(flxTween:FlxTween) 
						{
							menuItem.finishedFunnyMove = true; 
						}});
				}

			}
			else
			{
				if(i==curSelected)
				{
					menuItem.x = 380 + (i * 360) + (i > 0 ? 80 : 0);
					menuItem.y = 120;
					menuItem.alpha=1;
					menuItem.scale.x=0.65;
					menuItem.scale.y=0.65;
					menuItem.finishedFunnyMove = true; 
				}
				else
				{
					menuItem.x = 380 + (i * 360) + (i > 0 ? 80 : 0);
					menuItem.y = 120;
					menuItem.alpha=0.8;
					menuItem.scale.x=0.5;
					menuItem.scale.y=0.5;
					menuItem.finishedFunnyMove = true; 
				}
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

					menuItems.forEach(function(spr:MainMenuItem)
					{
						var enterTimer=new FlxTimer();
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
							spr.MainMenuItemEnter();
							enterTimer.start(1.5, function(tmr:FlxTimer)
								{
									var daChoice:String = optionShit[curSelected];
		
										switch (daChoice)
										{
											case 'StoryMode':
												MusicBeatState.switchState(new StoryMenuState());
											case 'Freeplay':
												MusicBeatState.switchState(new FreeplayState());
											#if MODS_ALLOWED
											case 'mods':
												MusicBeatState.switchState(new ModsMenuState());
											#end
											case 'Collection':
												MusicBeatState.switchState(new CollectionState());
											case 'Credits':
												MusicBeatState.switchState(new CreditsState());
											case 'Options':
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

		FlxG.watch.addQuick('FlxG.mouse.visible',FlxG.mouse.visible);

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
			item.scale.x = 0.5;
			item.scale.y = 0.5;
			item.alpha = 0.8;
			item.color=0x4F3F3F3F;
			item.y=120;
			item.selectedTween.active=false;
			root++;
		}

		menuItems.forEach(function(spr:MainMenuItem)
		{
			spr.updateHitbox();

			if (spr.ID == curSelected)
			{				
				spr.scale.x = 0.65;
				spr.scale.y = 0.65;
				spr.color=0x00FFFFFF;

				FlxTween.tween(spr,{alpha:1},0.3 ,{ease: FlxEase.sineInOut});

				spr.selectedTween.start();

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
	public var selectedTween:FlxTween;
	public var enterShadow:FlxSprite;
	public var enterTween:FlxTween;
	
	public function new(x:Float, y:Float, optionName:String = '')
	{
		super(x, y);
		loadGraphic(Paths.image('mainmenu/'+optionName,'mid-autumn'));
		enterShadow=new FlxSprite().loadGraphic(Paths.image('mainmenu/'+optionName,'mid-autumn'));
		enterShadow.alpha=0;
		enterShadow.scale.x=0.65;
		enterShadow.scale.y=0.65;
		enterShadow.updateHitbox();
		enterShadow.setPosition(300,50);
		// animation.addByPrefix('idle', optionName + " basic", 24);
		// animation.addByPrefix('selected', optionName + " white", 24);
		selectedTween=FlxTween.tween(this,{y:130},1,{type:PINGPONG,ease:FlxEase.quadInOut});
		selectedTween.active=false;
		antialiasing = ClientPrefs.globalAntialiasing;
	}
	
	var fakeFramerate:Int = Math.round((1 / FlxG.elapsed) / 10);

	public function MainMenuItemEnter() {
		enterShadow.alpha=0.5;
		selectedTween.active=false;
		enterShadow.setPosition(300,50);
		enterShadow.updateHitbox();
		enterTween=FlxTween.tween(enterShadow.scale,{x:1.2,y:1.2},1,{type: ONESHOT,ease: FlxEase.expoInOut,onComplete: function (flxTween:FlxTween) {
			FlxTween.tween(enterShadow,{alpha:0},0.5);
			trace('Enter'+enterShadow.getPosition()+this.getPosition());
		}});
		enterTween.start();
	}

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
	
			x = FlxMath.lerp(x, 380 + (targetX * 360) + offsets, CoolUtil.boundTo(elapsed * 10.2, 0, 1));
		}	
	}
}
