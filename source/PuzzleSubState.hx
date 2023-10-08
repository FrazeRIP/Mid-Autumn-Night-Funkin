package;

import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.addons.ui.FlxMultiGamepadAnalogStick.XY;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import openfl.display.Sprite;
import flixel.tweens.FlxTween.FlxTweenManager;
import haxe.io.Path;
import flixel.util.FlxColor;
import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.mouse.FlxMouseEventManager;
import flixel.text.FlxText;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxSpriteGroup;
import haxe.Json;
import haxe.format.JsonParser;
import openfl.utils.Assets;
import flixel.util.FlxTimer;


typedef PuzzleDataFile = 
{
    var options:Array<String>;
    var riddle:String;
    var iconName:String;
    var answers:String;
    
}

class PuzzleSubState extends MusicBeatSubstate 
{
    public static var seletedAnswer:Bool=false;
    public var backgroundColor:FlxSprite;
    public var puzzleMain:PuzzleMain;
    public var BG:FlxSprite;
    public var isTweening:Bool=true;

    public function new() {   

        super();
    }

    override function create() {     

        backgroundColor=new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, 0x83000000);
        backgroundColor.alpha=0;
        add(backgroundColor);

        //380 30
        BG=new FlxSprite(-600,30);
        BG.loadGraphic(Paths.image('storystate/puzzle/BackGround','mid-autumn'));
        BG.angle=180;
        BG.antialiasing = ClientPrefs.globalAntialiasing;
        add(BG);

        //430 65
        puzzleMain=new PuzzleMain();
        puzzleMain.setPosition(-600,65);
        puzzleMain.angle=90;
        add(puzzleMain);

        for(member in puzzleMain.puzzleMembers)
        {
            member.alpha=0;
        }

        puzzleMain.icon.alpha=0;
        puzzleMain.titleText.alpha=0;
        puzzleMain.puzzleText.alpha=0;
        FlxTween.tween(BG,{x:380,angle:0},0.5,{ease: FlxEase.backOut});
        FlxTween.tween(backgroundColor,{alpha:1},0.5,{ease: FlxEase.backOut});
        FlxTween.tween(puzzleMain,{x:430,angle:0},0.5,{ease: FlxEase.backOut,onComplete: function(twn:FlxTween) {
            for(member in puzzleMain.puzzleMembers)
                {
                    FlxTween.tween(member,{alpha:1},0.2);
                    FlxTween.tween(member.bgSprite,{alpha:0.1},0.2);
                }
                FlxTween.tween(puzzleMain.icon,{alpha:1},0.2);
                FlxTween.tween(puzzleMain.titleText,{alpha:1},0.2);
                FlxTween.tween(puzzleMain.puzzleText,{alpha:1},0.2,{onComplete: function(twn:FlxTween) {
                    isTweening=false;
                }});
        }});

        super.create();
    }
    public function PuzzleMainOut() {

        if(!isTweening)
        isTweening=true;
        
        for(member in puzzleMain.puzzleMembers)
        {
            member.stopEvnet();
            puzzleMain.tweenManager.cancelTweensOf(member);
            if(member.tokenTween!=null)
            member.tokenTween.cancel();
            FlxTween.tween(member.memberText,{alpha:0},0.2);
            FlxTween.tween(member.bgSprite,{alpha:0},0.2);
        }
        FlxTween.tween(puzzleMain.icon,{alpha:0},0.2);
        FlxTween.tween(puzzleMain.titleText,{alpha:0},0.2);
        FlxTween.tween(puzzleMain.puzzleText,{alpha:0},0.2);
        FlxTween.tween(BG,{x:-600,angle:180},0.5,{ease: FlxEase.backIn});
        FlxTween.tween(backgroundColor,{alpha:0},0.5,{ease: FlxEase.backIn});
        FlxTween.tween(puzzleMain,{x:-600,angle:90},0.5,{ease: FlxEase.backIn,onComplete: function(twn:FlxTween) {
        close();
        }});
    }
    override function update(elapsed:Float) {
        if((controls.BACK||FlxG.mouse.justPressedRight)&&!seletedAnswer&&!isTweening)
        {
            PuzzleMainOut();
        }
        if(seletedAnswer&&!isTweening)
        {   
            isTweening=true;
            new FlxTimer().start(2.0,function(tmr:FlxTimer){  
                    PuzzleMainOut();
            });
        }
        super.update(elapsed);
    }
    override function close() {
        FlxG.sound.play(Paths.sound('storystate/paper','mid-autumn'));
        super.close();
    }
}

class PuzzleMain extends FlxSpriteGroup
{
    public var mainBG:FlxSprite;
    public var icon:HealthIcon;
    public var titleText:FlxText;
    public var puzzleText:FlxText;
    public var puzzleMembers:FlxTypedGroup<PuzzleMember>;
    public var puzzleData:PuzzleDataFile;
    public var tweenManager:FlxTweenManager;
    public var weekNames:Array<String>=
    [    'hua_deng_chu_shang',
        'jin_zun_zhi_li',
        'hua_qian_yue_xia',
        'qing_xi_yin_yue',
        'zhuo_jiu_feng_qing',
        'hua_hao_yue_yuan',
        'ji_yue_tan_ming',
        'xin_qi_chao_ting',
        'zhan_yan_zhou_tong',
        'ru_yuan_xing_ke',
        'yi_zai_bi_xian',
        'qi_yun_ding_dang'];


    public override function new() {
        super();

        mainBG=new FlxSprite(0,0);
        mainBG.loadGraphic(Paths.image('storystate/puzzle/PuzzleMain','mid-autumn'));
        mainBG.antialiasing = ClientPrefs.globalAntialiasing;
        add(mainBG);

        loadDataJson(weekNames[StoryMenuState.curWeek-1]);
        

        puzzleMembers=new FlxTypedGroup<PuzzleMember>();
        MemberCreate();
        
        tweenManager=new FlxTweenManager();

 
         titleText=new FlxText(190,67,0,"字 谜",28);
         titleText.setFormat("assets/fonts/ZhengDaoCuShuTi.ttf",titleText.size);
         titleText.color=0xFF3F3F3F;
         add(titleText);
 
         puzzleText=new FlxText(155,142,0,puzzleData.riddle,34);
         puzzleText.setFormat("assets/fonts/ZhengDaoCuShuTi.ttf",puzzleText.size);
         puzzleText.color=0xFF000000;
         add(puzzleText);
       
         icon=new HealthIcon(puzzleData.iconName);
         icon.setPosition(15,40);
         icon.setGraphicSize(100,100);
         add(icon);
         
    }

    public function MemberCreate() {
        var arrayNum:Int=0;
        for(i in 0...6)
        {
            for(j in 0...5)
            {
                puzzleMembers.members[arrayNum] = new PuzzleMember(puzzleData.options[arrayNum],75+(50)*i,250+(50)*j);
                if(puzzleData.options[arrayNum]==puzzleData.answers)
                {
                    puzzleMembers.members[arrayNum].isAnswer=true;
                    trace(puzzleMembers.members[arrayNum].memberText.text);
                }
                add(puzzleMembers.members[arrayNum]);
                arrayNum++;
            }
        }
    }

    public function loadDataJson(weekName:String) {
		var weekPath:String =weekName;
		var rawJson = null;

		var path:String = Paths.json(weekPath,"mid-autumn");
		rawJson = Assets.getText(path);
		
		puzzleData = cast Json.parse(rawJson);
       
	}
}