package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.input.mouse.FlxMouseEventManager;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.net.curl.CURLCode;
import flixel.graphics.FlxGraphic;
import flixel.tweens.FlxEase;

import WeekData;

using StringTools;

class StoryMenuState extends MusicBeatState
{
	public static var weekCompleted:Map<String, Bool> = new Map<String, Bool>();

	// var scoreText:FlxText;

	private static var lastDifficultyName:String = '';
	var curDifficulty:Int = 1;

	var txtWeekTitle:FlxText;
	var bgSprite:FlxSprite;

	var puzzleButton:PuzzleStartButton;
	var puzzleButtonEnable:Bool=true;

	public static var curWeek:Int = 0;

	var txtTracklist:FlxText;

	var grpWeekText:FlxTypedGroup<MenuItem>;
	var grpWeekCharacters:FlxTypedGroup<MenuCharacter>;

	var grpLocks:FlxTypedGroup<FlxSprite>;

	var difficultySelectors:FlxGroup;
	// var sprDifficulty:FlxSprite;
	// var leftArrow:FlxSprite;
	// var rightArrow:FlxSprite;

	var background:FlxSprite;

	var selectionSprite:FlxSprite;
	var weekIndicators:FlxTypedGroup<FlxSprite>;

	var loadedWeeks:Array<WeekData> = [];
	var mouseSprite:FlxSprite;
	public static var comeFromStage:Bool = false;

	override function create()
	{
		Paths.clearStoredMemory();
		Paths.clearUnusedMemory();

		SaveData.LoadUnLock();

		if(SaveData.STORY_UNLOCK_SAVE[0]==0)
		SaveData.StoryStateUpdate('tutorial',1);

		if(SaveData.STORY_UNLOCK_SAVE[1]==0)
		SaveData.StoryStateUpdate('hua_deng_chu_shang',1);
				
		trace(SaveData.levelName);
		trace(SaveData.STORY_UNLOCK_SAVE);

		var mouseSprite=new FlxSprite().loadGraphic(Paths.image('UI/Mouse0',"mid-autumn"));
		FlxG.mouse.load(mouseSprite.pixels);

		PlayState.isStoryMode = true;
		WeekData.reloadWeekFiles(true);
		if(curWeek >= WeekData.weeksList.length) curWeek = 0;
		persistentUpdate = persistentDraw = true;


		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		background=new FlxSprite().loadGraphic(Paths.image('storystate/StoryBackground','mid-autumn'));
		background.antialiasing=ClientPrefs.globalAntialiasing;
		add(background);

		weekIndicators=new FlxTypedGroup<FlxSprite>();
		var num:Int = 0;
		for (i in 0...WeekData.weeksList.length)
		{
			var weekFile:WeekData = WeekData.weeksLoaded.get(WeekData.weeksList[i]);
			// var isLocked:Bool = weekIsLocked(WeekData.weeksList[i]);
			var isLocked:Bool=false;
			if(SaveData.STORY_UNLOCK_SAVE[i]==0)
				isLocked = true;
			else
				isLocked = false;
			loadedWeeks.push(weekFile);
			WeekData.setDirectoryFromWeek(weekFile);
			num++;
			var weekIndicator:FlxSprite=new FlxSprite(390+i*13,580+(i%2*13)).loadGraphic(Paths.image('storystate/WeekIndicator','mid-autumn'));
			weekIndicator.antialiasing = ClientPrefs.globalAntialiasing;
			if(isLocked)
			{
				weekIndicator.color=0xFFF10000;
			}
			else
			{
				weekIndicator.color=0xFF3F3F3F;
			}
			weekIndicator.setGraphicSize(20,20);
			weekIndicator.updateHitbox();
			weekIndicators.add(weekIndicator);
		}
		add(weekIndicators);

		selectionSprite=new FlxSprite(300,225);
		selectionSprite.loadGraphic(Paths.image("storystate/"+loadedWeeks[curWeek].storyName,"mid-autumn"));
		selectionSprite.setGraphicSize(Std.int(selectionSprite.width*0.5),Std.int(selectionSprite.height*0.5));
		selectionSprite.updateHitbox();
		add(selectionSprite);

		puzzleButton=new PuzzleStartButton(-400,560);
		puzzleButton.loadGraphic(Paths.image("storystate/puzzle/StartButton","mid-autumn"));
		puzzleButton.antialiasing = ClientPrefs.globalAntialiasing;

		puzzleButton.onMouseDownCallback=function () {
			persistentUpdate = false;
			FlxG.sound.play(Paths.sound('storystate/paper','mid-autumn'));
			PuzzleSubStateOpen();
		};
		puzzleButton.onMouseOverCallback=function () {
			FlxTween.tween(puzzleButton,{angle:10},0.2,{type:ONESHOT});
		}

		puzzleButton.onMouseOutCallback=function () {
			FlxTween.tween(puzzleButton,{angle:0},0.2,{type:ONESHOT});
		}
		add(puzzleButton);
		changeWeek();
		changeDifficulty();
		if (comeFromStage)
			{
				//FlxKeyManager.enabled = false;
	
				var white = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, 0xffffffff);
				white.scrollFactor.set();
				add(white);
	
				var left = new FlxSprite(0, 0).loadGraphic(Paths.image('loadingmenu/left','mid-autumn'));
				left.setGraphicSize(Std.int(left.width * 0.67));
				left.updateHitbox();
				left.antialiasing = ClientPrefs.globalAntialiasing;
				left.scrollFactor.set();
		
				var right = new FlxSprite(638, 0).loadGraphic(Paths.image('loadingmenu/right','mid-autumn'));
				right.setGraphicSize(Std.int(right.width * 0.67));
				right.updateHitbox();
				right.antialiasing = ClientPrefs.globalAntialiasing;
				right.scrollFactor.set();
		
				add(right);
				add(left);
		
				FlxTween.linearMotion(left, 0, 0, -644, 0, 1.2, true, {
					ease: FlxEase.quadOut
				});
	
				FlxTween.tween(white, {alpha:0}, 1, {ease: FlxEase.sineInOut, onComplete:function (twn:FlxTween){
					remove(white);
	
				FlxTween.linearMotion(right, 638, 0, 1280, 0, 1.2, true, {
					ease: FlxEase.quadOut,onComplete:
					function(twn:FlxTween) 
					{
						remove(left);
						remove(right);
		
						//	FlxKeyManager.enabled = true;
							comeFromStage = false;
						}});
					}});
			}

		super.create();

	}

	override function closeSubState() {
		persistentUpdate = true;
		FlxTween.tween(puzzleButton,{x:-400},0.5);
		puzzleButton.startEvnet();
		changeWeek();
		super.closeSubState();
	}

	override function openSubState(SubState:FlxSubState) {
		puzzleButton.stopEvnet();
		puzzleButton.setPosition(-600,560);
		super.openSubState(SubState);
	}

	override function update(elapsed:Float)
	{
		lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, CoolUtil.boundTo(elapsed * 30, 0, 1)));
		if(Math.abs(intendedScore - lerpScore) < 10) lerpScore = intendedScore;

		if (!movedBack && !selectedWeek)
		{
			var upP = controls.UI_UP_P;
			var downP = controls.UI_DOWN_P;
			if (controls.UI_LEFT_P)
			{
				changeWeek(-1);
				FlxG.sound.play(Paths.sound('scrollMenu'));
			}

			if (controls.UI_RIGHT_P)
			{
				changeWeek(1);
				FlxG.sound.play(Paths.sound('scrollMenu'));
			}

			if(FlxG.mouse.wheel != 0)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
				changeWeek(-FlxG.mouse.wheel);
				changeDifficulty();
			}

			if(FlxG.keys.justPressed.F2)
			{
				persistentUpdate = false;
				openSubState(new GameplayChangersSubstate());
			}
			if(FlxG.keys.justPressed.F1)
			{
				persistentUpdate = false;
				PuzzleSubStateOpen();
			}
			else if(controls.RESET)
			{
				persistentUpdate = false;
				openSubState(new ResetScoreSubState('', curDifficulty, '', curWeek));
				//FlxG.sound.play(Paths.sound('scrollMenu'));
			}
			else if (controls.ACCEPT)
			{
				selectWeek();
			}

		}

		if (controls.BACK && !movedBack && !selectedWeek)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));
			movedBack = true;
			MusicBeatState.switchState(new MainMenuState());
		}

		if(curWeek==0||curWeek==13)
		{
			puzzleButton.color=0x75272727;
			puzzleButton.stopEvnet();
		}
		else
		{
			puzzleButton.color=0x00FFFFFF;
			puzzleButton.startEvnet();
		}
		super.update(elapsed);

	}

	var movedBack:Bool = false;
	var selectedWeek:Bool = false;
	var stopspamming:Bool = false;

	function PuzzleSubStateOpen() {

		FlxG.sound.play(Paths.sound('storystate/paper','mid-autumn'));
		FlxTween.tween(puzzleButton,{x:-600,y:520},0.5,{type: ONESHOT,onComplete: function(twn:FlxTween) {
			openSubState(new PuzzleSubState());
		}});
	}

	function selectWeek()
	{
		if (!weekIsLocked(loadedWeeks[curWeek].fileName))
		{
			if (stopspamming == false)
			{
				FlxG.sound.play(Paths.sound('confirmMenu'));

			}

			var songArray:Array<String> = [];
			var leWeek:Array<Dynamic> = loadedWeeks[curWeek].songs;
			for (i in 0...leWeek.length) {
				songArray.push(leWeek[i][0]);
			}

			PlayState.storyPlaylist = songArray;
			PlayState.isStoryMode = true;
			selectedWeek = true;

			var diffic = CoolUtil.getDifficultyFilePath(curDifficulty);
			if(diffic == null) diffic = '';

			PlayState.storyDifficulty = curDifficulty;

			PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + diffic, PlayState.storyPlaylist[0].toLowerCase());
			PlayState.campaignScore = 0;
			PlayState.campaignMisses = 0;

			new FlxTimer().start(0.5, function(tmr:FlxTimer)
			{
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
	
				startLoading();

				new FlxTimer().start(1.22, function(tmr:FlxTimer)
				{
					LoadingState.loadAndSwitchState(new PlayState(), true);
					FreeplayState.destroyFreeplayVocals();
				});	
				
			});
		} else {
			FlxG.sound.play(Paths.sound('cancelMenu'));
		}
	}

	var tweenDifficulty:FlxTween;
	function changeDifficulty(change:Int = 0):Void
	{
		curDifficulty += change;

		if (curDifficulty < 0)
			curDifficulty = CoolUtil.difficulties.length-1;
		if (curDifficulty >= CoolUtil.difficulties.length)
			curDifficulty = 0;

		WeekData.setDirectoryFromWeek(loadedWeeks[curWeek]);

		var diff:String = CoolUtil.difficulties[curDifficulty];
		var newImage:FlxGraphic = Paths.image('menudifficulties/' + Paths.formatToSongPath(diff));

		#if !switch
		intendedScore = Highscore.getWeekScore(loadedWeeks[curWeek].fileName, curDifficulty);
		#end
	}

	var lerpScore:Int = 0;
	var intendedScore:Int = 0;
	var tween:FlxTween;
	function changeWeek(change:Int = 0):Void
	{
		curWeek += change;

		if (curWeek >= loadedWeeks.length)
			curWeek = 0;
		if (curWeek < 0)
			curWeek = loadedWeeks.length - 1;

		if(tween!=null)
		tween.cancel();
		selectionSprite.alpha=0;
		selectionSprite.loadGraphic(Paths.image("storystate/"+loadedWeeks[curWeek].storyName,"mid-autumn"));
		tween=FlxTween.tween(selectionSprite,{alpha:1},0.5);

		for (i in 0...WeekData.weeksList.length)
		{
			// var isLocked:Bool = weekIsLocked(WeekData.weeksList[i]);
			var isLocked:Bool=false;
			if(SaveData.STORY_UNLOCK_SAVE[i]==0)
				isLocked = true;
			else
				isLocked = false;

			if(isLocked)
			{
				weekIndicators.members[i].color=0xFFFF0000;
			}
			else
			{
				weekIndicators.members[i].color=0xFF3F3F3F;
			}
		}
		trace(curWeek);
		trace(SaveData.STORY_UNLOCK_SAVE[curWeek]==1);
		if(SaveData.STORY_UNLOCK_SAVE[curWeek]==0)
		weekIndicators.members[curWeek].color = 0xFFB1B1B1;
		else
		weekIndicators.members[curWeek].color =0xFFFFFFFF;

		var leWeek:WeekData = loadedWeeks[curWeek];
		WeekData.setDirectoryFromWeek(leWeek);

		var leName:String = leWeek.storyName;

		var bullShit:Int = 0;

		var unlocked:Bool = !weekIsLocked(leWeek.fileName);

		PlayState.storyWeek = curWeek;

		CoolUtil.difficulties = CoolUtil.defaultDifficulties.copy();
		var diffStr:String = WeekData.getCurrentWeek().difficulties;


		if(diffStr != null && diffStr.length > 0)
		{
			var diffs:Array<String> = diffStr.split(',');
			var i:Int = diffs.length - 1;
			while (i > 0)
			{
				if(diffs[i] != null)
				{
					diffs[i] = diffs[i].trim();
					if(diffs[i].length < 1) diffs.remove(diffs[i]);
				}
				--i;
			}

			if(diffs.length > 0 && diffs[0].length > 0)
			{
				CoolUtil.difficulties = diffs;
			}
		}

		if(CoolUtil.difficulties.contains(CoolUtil.defaultDifficulty))
		{
			curDifficulty = Math.round(Math.max(0, CoolUtil.defaultDifficulties.indexOf(CoolUtil.defaultDifficulty)));
		}
		else
		{
			curDifficulty = 0;
		}

		var newPos:Int = CoolUtil.difficulties.indexOf(lastDifficultyName);
		//trace('Pos of ' + lastDifficultyName + ' is ' + newPos);
		if(newPos > -1)
		{
			curDifficulty = newPos;
		}
		updateText();
	}

	function weekIsLocked(name:String):Bool {
		var leWeek:WeekData = WeekData.weeksLoaded.get(name);
		return (!leWeek.startUnlocked && leWeek.weekBefore.length > 0 && (!weekCompleted.exists(leWeek.weekBefore) || !weekCompleted.get(leWeek.weekBefore)));
	}

	function updateText()
	{
		var weekArray:Array<String> = loadedWeeks[curWeek].weekCharacters;

		var leWeek:WeekData = loadedWeeks[curWeek];
		var stringThing:Array<String> = [];
		for (i in 0...leWeek.songs.length) {
			stringThing.push(leWeek.songs[i][0]);
		}

		#if !switch
		intendedScore = Highscore.getWeekScore(loadedWeeks[curWeek].fileName, curDifficulty);
		#end
	}

	function startLoading()
	{
		var left = new FlxSprite(0, 0).loadGraphic(Paths.image('loadingmenu/left','mid-autumn'));
		left.setGraphicSize(Std.int(left.width * 0.67));
		left.updateHitbox();
		left.x = -644;
		left.antialiasing = ClientPrefs.globalAntialiasing;
		left.scrollFactor.set();
	
		var right = new FlxSprite(0, 0).loadGraphic(Paths.image('loadingmenu/right','mid-autumn'));
		right.setGraphicSize(Std.int(right.width * 0.67));
		right.updateHitbox();
		right.x = 1280;
		right.antialiasing = ClientPrefs.globalAntialiasing;
		add(right);
		add(left);
		right.scrollFactor.set();
	
		FlxTween.linearMotion(left, -644, 0, 0, 0, 1.2, true, {
			ease: FlxEase.quadOut
		});
	
		FlxTween.linearMotion(right, 1280, 0, 638, 0, 1.2, true, {
			ease: FlxEase.quadOut
			});
	}
}
class PuzzleStartButton extends FlxSprite
{
	public var onMouseDownCallback:Void->Void;
	public var onMouseOverCallback:Void->Void;
	public var onMouseOutCallback:Void->Void;

	public override function new(x:Int,y:Int)
	{
		super(x,y);
		FlxMouseEventManager.add(this, onMouseDown, null, onMouseOver, onMouseOut);
	}

	public function stopEvnet()
	{
		FlxMouseEventManager.setObjectMouseEnabled(this,false);
	}

	public function startEvnet()
	{
		FlxMouseEventManager.setObjectMouseEnabled(this,true);
	}
	function onMouseDown(_)
	{
		if(onMouseDownCallback != null)
		{
			onMouseDownCallback();
		}
	}

	function onMouseOver(_)
	{
		if(onMouseOverCallback != null)
			{
				onMouseOverCallback();
				updateHitbox();
			}
	}
	function onMouseOut(_)
	{
		if(onMouseOutCallback != null)
			{
				onMouseOutCallback();
				updateHitbox();
			}
	}

	
}
