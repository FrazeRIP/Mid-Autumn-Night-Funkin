package;

import openfl.sensors.Accelerometer;
import flixel.addons.ui.U;
import flixel.FlxCamera;
#if desktop
import Discord.DiscordClient;
#end
import editors.ChartingState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import lime.utils.Assets;
import flixel.system.FlxSound;
import flixel.util.FlxTimer;
import flixel.tweens.FlxEase;
import openfl.utils.Assets as OpenFlAssets;
import WeekData;
import flixel.input.FlxKeyManager;

#if MODS_ALLOWED
import sys.FileSystem;
#end

using StringTools;

class FreeplayState extends MusicBeatState
{
	var songs:Array<SongMetadata> = [];

	var mainCamera:FlxCamera;
	var rollingCamera:FlxCamera;
	var uiCamera:FlxCamera;
	
	var selector:FlxText;
	private static var curSelected:Int = 0;
	var curDifficulty:Int = -1;
	private static var lastDifficultyName:String = '';

	var scoreBG:FlxSprite;
	var scoreText:FlxText;
	var diffText:FlxText;
	var lerpScore:Int = 0;
	var lerpRating:Float = 0;
	var intendedScore:Int = 0;
	var intendedRating:Float = 0;

	private var grpSongs:FlxTypedGroup<FlxText>;
	private var curPlaying:Bool = false;

	private var iconArray:Array<HealthIcon> = [];

	var bg:FlxSprite;
	var guardrail:FlxSprite;
	var paper:FlxSprite;
	var scroll:FlxSprite;
	var intendedColor:Int;
	
	var colorTween:FlxTween;
	public static var comeFromStage:Bool = false;

	override function create()
	{
		//Paths.clearStoredMemory();
		//Paths.clearUnusedMemory();
		
		persistentUpdate = true;
		PlayState.isStoryMode = false;
		WeekData.reloadWeekFiles(false);

		mainCamera=new FlxCamera();
		rollingCamera=new FlxCamera(105,97,295,548);
		uiCamera=new FlxCamera();

        rollingCamera.bgColor=FlxColor.BLACK;
		uiCamera.bgColor.alpha = 0;

		

		FlxG.cameras.reset(mainCamera);
		FlxG.cameras.add(rollingCamera, false);
		FlxG.cameras.add(uiCamera, false);


		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		for (i in 0...WeekData.weeksList.length) {
			if(SaveData.STORY_UNLOCK_SAVE[i]==1)
			{
				if(weekIsLocked(WeekData.weeksList[i])) continue;

				var leWeek:WeekData = WeekData.weeksLoaded.get(WeekData.weeksList[i]);
				var leSongs:Array<String> = [];
				var leChars:Array<String> = [];

				for (j in 0...leWeek.songs.length)
				{
					leSongs.push(leWeek.songs[j][0]);
					leChars.push(leWeek.songs[j][1]);
				}

				WeekData.setDirectoryFromWeek(leWeek);
				for (song in leWeek.songs)
				{
					var colors:Array<Int> = song[2];
					if(colors == null || colors.length < 3)
					{
						colors = [146, 113, 253];
					}
					addSong(song[0], i, song[1], FlxColor.fromRGB(colors[0], colors[1], colors[2]));
				}
			}
		}
		WeekData.loadTheFirstEnabledMod();

		/*		//KIND OF BROKEN NOW AND ALSO PRETTY USELESS//

		var initSonglist = CoolUtil.coolTextFile(Paths.txt('freeplaySonglist'));
		for (i in 0...initSonglist.length)
		{
			if(initSonglist[i] != null && initSonglist[i].length > 0) {
				var songArray:Array<String> = initSonglist[i].split(":");
				addSong(songArray[0], 0, songArray[1], Std.parseInt(songArray[2]));
			}
		}*/

		bg = new FlxSprite().loadGraphic(Paths.image('freeplay/1','mid-autumn'));
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);
		bg.screenCenter();

		guardrail = new FlxSprite().loadGraphic(Paths.image('freeplay/2','mid-autumn'));
		guardrail.antialiasing = ClientPrefs.globalAntialiasing;
		add(guardrail);
		guardrail.screenCenter();

		paper=new FlxSprite().loadGraphic(Paths.image('freeplay/3','mid-autumn'));
		paper.antialiasing= ClientPrefs.globalAntialiasing;
		add(paper);
		paper.screenCenter();

		scroll=new FlxSprite().loadGraphic(Paths.image('freeplay/4','mid-autumn'));
		scroll.antialiasing = ClientPrefs.globalAntialiasing;
		add(scroll);
		scroll.screenCenter();

		grpSongs = new FlxTypedGroup<FlxText>();
		grpSongs.cameras=[rollingCamera];
		add(grpSongs);

		SaveData.LoadUnLock();

		for (i in 0...songs.length)

		{
			var titleSong:String;
			switch(songs[i].songName)
			{
				case "jiao_yue_dang_kong":
					titleSong="皎月当空";
				case "hua_deng_chu_shang":
					titleSong="华灯初上";
				case "jin_zun_zhi_li":
					titleSong="金樽之礼";
				case "hua_qian_yue_xia":
					titleSong="花前月下";
				case "qing_xi_yin_yue":
					titleSong="清溪吟月";
				case "zhuo_jiu_feng_qing":
					titleSong="酌酒风清";
				case "hua_hao_yue_yuan":
					titleSong="花好月圆";
				case "ji_yue_tan_ming":
					titleSong="祭月坛眀";
				case "xin_qi_chao_ting":
					titleSong="信起潮听";
				case "zhan_yan_zhou_tong":
					titleSong="绽焰昼同";
				case "ru_yuan_xing_ke":
					titleSong="如远行客";
				case "yi_zai_bi_xian":
					titleSong="意在笔先";
				case "qi_yun_ding_dang":
					titleSong="棋韵叮当";
				case "yue_luo_xing_shen":
					titleSong="月落星沈";																						
				default:
					titleSong=songs[i].songName;
			}
			var songText:FlxText = new FlxText(0, (70 * i) + 30,0, titleSong, 40);
			songText.setFormat("assets/fonts/ZhengDaoCuShuTi.ttf",songText.size);
			
			grpSongs.add(songText);

			if (songText.width > 980)
			{
				var textScale:Float = 980 / songText.width;
				songText.scale.x = textScale;
				//songText.updateHitbox();
				//trace(songs[i].songName + ' new scale: ' + textScale);
			}

			Paths.currentModDirectory = songs[i].folder;
			var icon:HealthIcon = new HealthIcon(songs[i].songCharacter);
			icon.sprTracker = songText;
			icon.setGraphicSize(50,50);
			icon.updateHitbox();
			icon.cameras=[rollingCamera];

			// using a FlxGroup is too much fuss!
			iconArray.push(icon);
			add(icon);

			// songText.x += 40;
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
			// songText.screenCenter(X);
		}
		WeekData.setDirectoryFromWeek();

		scoreText = new FlxText(436, 80, 0, "", 32);
		scoreText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, RIGHT);

		scoreBG = new FlxSprite(scoreText.x - 6, 80).makeGraphic(150, 150, 0xFF000000);
		scoreBG.alpha = 0.6;
		add(scoreBG);

		diffText = new FlxText(scoreText.x, scoreText.y + 36, 0, "", 24);
		diffText.font = scoreText.font;
		add(diffText);

		add(scoreText);

		if(curSelected >= songs.length) curSelected = 0;
		bg.color = songs[curSelected].color;
		intendedColor = bg.color;
		
		if(lastDifficultyName == '')
		{
			lastDifficultyName = CoolUtil.defaultDifficulty;
		}
		curDifficulty = Math.round(Math.max(0, CoolUtil.defaultDifficulties.indexOf(lastDifficultyName)));
		
		changeSelection();
		changeDiff();

		var swag:Alphabet = new Alphabet(1, 0, "swag");

		// JUST DOIN THIS SHIT FOR TESTING!!!
		/* 
			var md:String = Markdown.markdownToHtml(Assets.getText('CHANGELOG.md'));

			var texFel:TextField = new TextField();
			texFel.width = FlxG.width;
			texFel.height = FlxG.height;
			// texFel.
			texFel.htmlText = md;

			FlxG.stage.addChild(texFel);

			// scoreText.textField.htmlText = md;

			trace(md);
		 */

		var textBG:FlxSprite = new FlxSprite(0, FlxG.height - 26).makeGraphic(FlxG.width, 26, 0xFF000000);
		textBG.alpha = 0.6;
		add(textBG);

		#if PRELOAD_ALL
		var leText:String = "Press SPACE to listen to the Song / Press CTRL to open the Gameplay Changers Menu / Press RESET to Reset your Score and Accuracy.";
		var size:Int = 16;
		#else
		var leText:String = "Press CTRL to open the Gameplay Changers Menu / Press RESET to Reset your Score and Accuracy.";
		var size:Int = 18;
		#end
		var text:FlxText = new FlxText(textBG.x, textBG.y + 4, FlxG.width, leText, size);
		text.setFormat(Paths.font("vcr.ttf"), size, FlxColor.WHITE, RIGHT);
		text.scrollFactor.set();
		add(text);
		if (comeFromStage)
			{
				//FlxKeyManager.enabled = false;
	
				var white = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, 0xffffffff);
				white.scrollFactor.set();
				white.cameras=[uiCamera];
				add(white);
	
				var left = new FlxSprite(0, 0).loadGraphic(Paths.image('loadingmenu/left','mid-autumn'));
				left.setGraphicSize(Std.int(left.width * 0.67));
				left.updateHitbox();
				left.antialiasing = ClientPrefs.globalAntialiasing;
				left.scrollFactor.set();
				left.cameras=[uiCamera];
		
				var right = new FlxSprite(638, 0).loadGraphic(Paths.image('loadingmenu/right','mid-autumn'));
				right.setGraphicSize(Std.int(right.width * 0.67));
				right.updateHitbox();
				right.antialiasing = ClientPrefs.globalAntialiasing;
				right.scrollFactor.set();
				right.cameras=[uiCamera];
		
				add(right);
				add(left);
		
				FlxTween.linearMotion(left, 0, 0, -644, 0, 1.2, true, {
					ease: FlxEase.quadOut
				});
	
				FlxTween.tween(white, {alpha:0}, 1, {ease: FlxEase.sineInOut, onComplete:function (twn:FlxTween){
					remove(white);
				}});

				FlxTween.linearMotion(right, 638, 0, 1280, 0, 1.2, true, {
					ease: FlxEase.quadOut,onComplete:
					function(twn:FlxTween) 
					{
						remove(left);
						remove(right);

						//	FlxKeyManager.enabled = true;
							comeFromStage = false;
						}});
			}
		super.create();
	}

	override function closeSubState() {
		changeSelection(0, false);
		persistentUpdate = true;
		super.closeSubState();
	}

	public function addSong(songName:String, weekNum:Int, songCharacter:String, color:Int)
	{
		songs.push(new SongMetadata(songName, weekNum, songCharacter, color));
	}

	function weekIsLocked(name:String):Bool {
		var leWeek:WeekData = WeekData.weeksLoaded.get(name);
		return (!leWeek.startUnlocked && leWeek.weekBefore.length > 0 && (!StoryMenuState.weekCompleted.exists(leWeek.weekBefore) || !StoryMenuState.weekCompleted.get(leWeek.weekBefore)));
	}

	/*public function addWeek(songs:Array<String>, weekNum:Int, weekColor:Int, ?songCharacters:Array<String>)
	{
		if (songCharacters == null)
			songCharacters = ['bf'];

		var num:Int = 0;
		for (song in songs)
		{
			addSong(song, weekNum, songCharacters[num]);
			this.songs[this.songs.length-1].color = weekColor;

			if (songCharacters.length != 1)
				num++;
		}
	}*/

	var instPlaying:Int = -1;
	public static var vocals:FlxSound = null;
	var holdTime:Float = 0;
	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, CoolUtil.boundTo(elapsed * 24, 0, 1)));
		lerpRating = FlxMath.lerp(lerpRating, intendedRating, CoolUtil.boundTo(elapsed * 12, 0, 1));

		if (Math.abs(lerpScore - intendedScore) <= 10)
			lerpScore = intendedScore;
		if (Math.abs(lerpRating - intendedRating) <= 0.01)
			lerpRating = intendedRating;

		var ratingSplit:Array<String> = Std.string(Highscore.floorDecimal(lerpRating * 100, 2)).split('.');
		if(ratingSplit.length < 2) { //No decimals, add an empty space
			ratingSplit.push('');
		}
		
		while(ratingSplit[1].length < 2) { //Less than 2 decimals in it, add decimals then
			ratingSplit[1] += '0';
		}

		scoreText.text = 'PERSONAL BEST: ' + lerpScore + ' (' + ratingSplit.join('.') + '%)';
		// positionHighscore();

		var upP = controls.UI_UP_P;
		var downP = controls.UI_DOWN_P;
		var accepted = controls.ACCEPT;
		var space = FlxG.keys.justPressed.SPACE;
		var ctrl = FlxG.keys.justPressed.CONTROL;

		var shiftMult:Int = 1;
		if(FlxG.keys.pressed.SHIFT) shiftMult = 3;

		if(songs.length > 1)
		{
			if (upP)
			{
				changeSelection(-shiftMult);
				holdTime = 0;
			}
			if (downP)
			{
				changeSelection(shiftMult);
				holdTime = 0;
			}

			if(controls.UI_DOWN || controls.UI_UP)
			{
				var checkLastHold:Int = Math.floor((holdTime - 0.5) * 10);
				holdTime += elapsed;
				var checkNewHold:Int = Math.floor((holdTime - 0.5) * 10);

				if(holdTime > 0.5 && checkNewHold - checkLastHold > 0)
				{
					changeSelection((checkNewHold - checkLastHold) * (controls.UI_UP ? -shiftMult : shiftMult));
					changeDiff();
				}
			}

			if(FlxG.mouse.wheel != 0)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
				changeSelection(-shiftMult * FlxG.mouse.wheel, false);
				changeDiff();
			}
		}

		if (controls.UI_LEFT_P)
			changeDiff(-1);
		else if (controls.UI_RIGHT_P)
			changeDiff(1);
		else if (upP || downP) changeDiff();

		if (controls.BACK)
		{
			persistentUpdate = false;
			if(colorTween != null) {
				colorTween.cancel();
			}
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new MainMenuState());
		}

		if(ctrl)
		{
			persistentUpdate = false;
			openSubState(new GameplayChangersSubstate());
		}
		else if(space)
		{
			if(instPlaying != curSelected)
			{
				#if PRELOAD_ALL
				destroyFreeplayVocals();
				FlxG.sound.music.volume = 0;
				Paths.currentModDirectory = songs[curSelected].folder;
				var poop:String = Highscore.formatSong(songs[curSelected].songName.toLowerCase(), curDifficulty);
				PlayState.SONG = Song.loadFromJson(poop, songs[curSelected].songName.toLowerCase());
				if (PlayState.SONG.needsVoices)
					vocals = new FlxSound().loadEmbedded(Paths.voices(PlayState.SONG.song));
				else
					vocals = new FlxSound();

				FlxG.sound.list.add(vocals);
				FlxG.sound.playMusic(Paths.inst(PlayState.SONG.song), 0.7);
				vocals.play();
				vocals.persist = true;
				vocals.looped = true;
				vocals.volume = 0.7;
				instPlaying = curSelected;
				#end
			}
		}

		else if (accepted)
		{
			persistentUpdate = false;
			var songLowercase:String = Paths.formatToSongPath(songs[curSelected].songName);
			var poop:String = Highscore.formatSong(songLowercase, curDifficulty);
			/*#if MODS_ALLOWED
			if(!sys.FileSystem.exists(Paths.modsJson(songLowercase + '/' + poop)) && !sys.FileSystem.exists(Paths.json(songLowercase + '/' + poop))) {
			#else
			if(!OpenFlAssets.exists(Paths.json(songLowercase + '/' + poop))) {
			#end
				poop = songLowercase;
				curDifficulty = 1;
				trace('Couldnt find file');
			}*/
			trace(poop);

			PlayState.SONG = Song.loadFromJson(poop, songLowercase);
			PlayState.isStoryMode = false;
			PlayState.storyDifficulty = curDifficulty;

			trace('CURRENT WEEK: ' + WeekData.getWeekFileName());
			if(colorTween != null) {
				colorTween.cancel();
			}
			
			if (FlxG.keys.pressed.SHIFT)
				{
					LoadingState.loadAndSwitchState(new ChartingState());
				}
				else
				{
					FlxTransitionableState.skipNextTransIn = true;
					FlxTransitionableState.skipNextTransOut = true;
	
					startLoading();
	
					new FlxTimer().start(1.22, function(tmr:FlxTimer)
					{
						LoadingState.loadAndSwitchState(new PlayState());
					});		
				}
			FlxG.sound.music.volume = 0;
					
			destroyFreeplayVocals();
		}
		else if(controls.RESET)
		{
			persistentUpdate = false;
			openSubState(new ResetScoreSubState(songs[curSelected].songName, curDifficulty, songs[curSelected].songCharacter));
			FlxG.sound.play(Paths.sound('scrollMenu'));
		}
		super.update(elapsed);
	}

	public static function destroyFreeplayVocals() {
		if(vocals != null) {
			vocals.stop();
			vocals.destroy();
		}
		vocals = null;
	}

	function changeDiff(change:Int = 0)
	{
		curDifficulty += change;

		if (curDifficulty < 0)
			curDifficulty = CoolUtil.difficulties.length-1;
		if (curDifficulty >= CoolUtil.difficulties.length)
			curDifficulty = 0;

		lastDifficultyName = CoolUtil.difficulties[curDifficulty];

		#if !switch
		intendedScore = Highscore.getScore(songs[curSelected].songName, curDifficulty);
		intendedRating = Highscore.getRating(songs[curSelected].songName, curDifficulty);
		#end

		PlayState.storyDifficulty = curDifficulty;
		diffText.text = '< ' + CoolUtil.difficultyString() + ' >';
		// positionHighscore();
	}

	function changeSelection(change:Int = 0, playSound:Bool = true)
	{
		if(playSound) FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = songs.length - 1;
		if (curSelected >= songs.length)
			curSelected = 0;
			
		var newColor:Int = songs[curSelected].color;
		if(newColor != intendedColor) {
			if(colorTween != null) {
				colorTween.cancel();
			}
			intendedColor = newColor;
			colorTween = FlxTween.color(bg, 1, bg.color, intendedColor, {
				onComplete: function(twn:FlxTween) {
					colorTween = null;
				}
			});
		}

		// selector.y = (70 * curSelected) + 30;

		#if !switch
		intendedScore = Highscore.getScore(songs[curSelected].songName, curDifficulty);
		intendedRating = Highscore.getRating(songs[curSelected].songName, curDifficulty);
		#end

		var bullShit:Int = 0;

		for (i in 0...iconArray.length)
		{
			iconArray[i].alpha = 0.6;
		}

		iconArray[curSelected].alpha = 1;

		// for (item in grpSongs.members)
		// {
		// 	item.targetY = bullShit - curSelected;
		// 	bullShit++;

		// 	item.alpha = 0.6;
		// 	// item.setGraphicSize(Std.int(item.width * 0.8));

		// 	if (item.targetY == 0)
		// 	{
		// 		item.alpha = 1;
		// 		// item.setGraphicSize(Std.int(item.width));
		// 	}
		// }
		
		Paths.currentModDirectory = songs[curSelected].folder;
		PlayState.storyWeek = songs[curSelected].week;

		CoolUtil.difficulties = CoolUtil.defaultDifficulties.copy();
		var diffStr:String = WeekData.getCurrentWeek().difficulties;
		if(diffStr != null) diffStr = diffStr.trim(); //Fuck you HTML5

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
	}

	// private function positionHighscore() {
	// 	scoreText.x = FlxG.width - scoreText.width - 6;

	// 	scoreBG.scale.x = FlxG.width - scoreText.x + 6;
	// 	scoreBG.x = FlxG.width - (scoreBG.scale.x / 2);
	// 	diffText.x = Std.int(scoreBG.x + (scoreBG.width / 2));
	// 	diffText.x -= diffText.width / 2;
	// }
	function startLoading()
		{
			var left = new FlxSprite(0, 0).loadGraphic(Paths.image('loadingmenu/left','mid-autumn'));
			left.setGraphicSize(Std.int(left.width * 0.67));
			left.updateHitbox();
			left.x = -644;
			left.antialiasing = ClientPrefs.globalAntialiasing;
			left.scrollFactor.set();
			left.cameras=[uiCamera];
	
			var right = new FlxSprite(0, 0).loadGraphic(Paths.image('loadingmenu/right','mid-autumn'));
			right.setGraphicSize(Std.int(right.width * 0.67));
			right.updateHitbox();
			right.x = 1280;
			right.antialiasing = ClientPrefs.globalAntialiasing;
			add(right);
			add(left);
			right.scrollFactor.set();
			right.cameras=[uiCamera];
	
			FlxTween.linearMotion(left, -644, 0, 0, 0, 1.2, true, {
				ease: FlxEase.quadOut
			});
	
			FlxTween.linearMotion(right, 1280, 0, 638, 0, 1.2, true, {
				ease: FlxEase.quadOut
				});
		}
}

class SongMetadata
{
	public var songName:String = "";
	public var week:Int = 0;
	public var songCharacter:String = "";
	public var color:Int = -7179779;
	public var folder:String = "";

	public function new(song:String, week:Int, songCharacter:String, color:Int)
	{
		this.songName = song;
		this.week = week;
		this.songCharacter = songCharacter;
		this.color = color;
		this.folder = Paths.currentModDirectory;
		if(this.folder == null) this.folder = '';
	}
}