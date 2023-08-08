package;

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


typedef PuzzleDataFile = 
{
    var options:Array<String>;
    var riddle:String;
    var iconName:String;
    var answers:String;
}

class PuzzleSubState extends MusicBeatSubstate 
{
    public var puzzleMembers:FlxTypedGroup<PuzzleMember>;
    public var puzzleData:PuzzleDataFile;
    public var icon:HealthIcon;
    public var testSpirte:FlxSprite;
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
        puzzleMembers=new FlxTypedGroup<PuzzleMember>();
        add(puzzleMembers);
        
        MemberCreate();
        
        icon=new HealthIcon(puzzleData.iconName);
        add(icon);
        super.create();
    }

    override function update(elapsed:Float) {
        if(controls.BACK)
        {
            close();
        }
        super.update(elapsed);
    }
    public function MemberCreate() {
        var arrayNum:Int=0;
        loadDataJson('hua_deng_chu_shang');
        for(i in 0...6)
        {
            for(j in 0...5)
            {
                puzzleMembers.members[arrayNum] = new PuzzleMember(puzzleData.options[arrayNum],100+(30+5)*i,100+(30+5)*j);
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
