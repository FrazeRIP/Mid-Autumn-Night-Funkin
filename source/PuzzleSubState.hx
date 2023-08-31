package;

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
    public var puzzleMembers:FlxTypedGroup<PuzzleMember>;
    public var puzzleData:PuzzleDataFile;
    public var backgroundColor:FlxSprite;
    public var BG:FlxSprite;
    public var mainBG:FlxSprite;
    public var icon:HealthIcon;
    public var testSpirte:FlxSprite;
    public var titleText:FlxText;
    public var puzzleText:FlxText;
    public var weekNames:Array<String>=
    [ 'hua_deng_chu_shang',
        'jin_zun_zhi_li',
        'hua_qian_yue_xia',
        'qing_xi_yin_yue',
        'zhuo_jiu_feng_qing',
        'ji_yue_tan_ming',
        'ru_yuan_xing_ke',
        'yi_zai_bi_xian',
        'qi_yun_ding_dang'];
    
    public function new() {       
        super();
    }

    override function create() {

        loadDataJson('hua_deng_chu_shang');
        
        backgroundColor=new FlxSprite(0, 56).makeGraphic(FlxG.width, FlxG.height, 0x83000000);
        add(backgroundColor);

        puzzleMembers=new FlxTypedGroup<PuzzleMember>();
        add(puzzleMembers);
        
        
        BG=new FlxSprite();
        BG.loadGraphic(Paths.image('storystate/puzzle/BackGround','mid-autumn'));
        BG.screenCenter(XY);
        add(BG);

        mainBG=new FlxSprite();
        mainBG.loadGraphic(Paths.image('storystate/puzzle/PuzzleMain','mid-autumn'));
        mainBG.screenCenter(XY);
        add(mainBG);

        titleText=new FlxText(615,120,0,"字 谜",28);
        titleText.setFormat("assets/fonts/ZhengDaoCuShuTi.ttf",titleText.size);
        titleText.color=0xFF3F3F3F;
        add(titleText);

        puzzleText=new FlxText(585,190,0,puzzleData.riddle,34);
        puzzleText.setFormat("assets/fonts/ZhengDaoCuShuTi.ttf",puzzleText.size);
        puzzleText.color=0xFF000000;
        add(puzzleText);
        MemberCreate();

        icon=new HealthIcon(puzzleData.iconName);
        icon.setPosition(435,100);
        icon.setGraphicSize(100,100);
        add(icon);
        super.create();
    }

    override function update(elapsed:Float) {
        if(controls.BACK||FlxG.mouse.justPressedRight)
        {
            close();
        }
        if(seletedAnswer)
        {
            new FlxTimer().start(2.0,function(tmr:FlxTimer){close();});
        }
        super.update(elapsed);
    }
    override function close() {
        FlxG.sound.play(Paths.sound('storystate/paper','mid-autumn'));
        super.close();
    }
    public function MemberCreate() {
        var arrayNum:Int=0;
        for(i in 0...6)
        {
            for(j in 0...5)
            {
                puzzleMembers.members[arrayNum] = new PuzzleMember(puzzleData.options[arrayNum],500+(50)*i,305+(50)*j);
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
