package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.system.FlxSound;

enum LevelName{
    hua_deng_chu_shang;
    jin_zun_zhi_li;
    hua_qian_yue_xia;
    qing_xi_yin_yue;
    zhuo_jiu_feng_qing;
    ji_yue_tan_ming;
    ru_yuan_xing_ke;
    yi_zai_bi_xian;
    qi_yun_ding_dang;
    unknownStage1;
    unknownStage2;
    unknownStage3;
}

class SaveData
{
    public static var PROJECT_IS_FINISH:Bool=false;//unknown完成后直接把这里改成true
    //关卡、角色及其对应在array数组中位置
    //关卡名：华灯初上  金樽之礼  花前月下  清溪吟月  酌酒风清  祭月坛眀 如远行客 意在笔先 棋韵叮当   未知1     未知2    未知3
    //角色名： paola    ropry     nico     heidi   whitecat  rincy     is    sprout  pinkghost unknown1 unknown2 unknown3
    //数组号：  0         1        2         3        4        5       6       7        8         9        10      11
    public static var STORYMODE_PUZZLE_SAVE:Array<Int>=
    [0,0,0,0,0,0,0,0,0,0,0,0];//字谜
    public static var STORY_UNLOCK_SAVE:Array<Int>=
    [0,0,0,0,0,0,0,0,0,0,0,0];//关卡
    //0=未解锁 1=已解锁 2=已通过
    public static var HIGH_SCORE:Array<Int>=
    [0,0,0,0,0,0,0,0,0,0,0,0];//最高分【看情况要不要，不要直接删了也行
    public static var COLLECTIONS_UNLOCK:Array<Bool>=
    [false,false,false,false,false,false,false,false,false,false,false,false];//信物解锁情况
    public static var COLLECTIONS_SPECIAL:Bool=false;//特殊信物解锁情况

    /**
	 * Storys State Update
	 *
	 * @param	storyName			Level name
	 * @param	state				0:Locked, 1:Unlocked ,2:Finished
	 */
    public static function StoryStateUpdate(storyName:LevelName,state:Int) {
        STORY_UNLOCK_SAVE[storyName.getIndex()]=state;
        SaveStory();
    }
    /**
	 * Storys Puzzle State Update
	 *
	 * @param	storyName			Level name
	 * @param	state				0:Locked, 1:Unlocked ,2:Finished
	 */
    public static function StoryPuzzleStateUpdate(storyName:LevelName,state:Int){
        STORYMODE_PUZZLE_SAVE[storyName.getIndex()]=state;
        SavePuzzle();
    }
    public static function CollectionsUnlocked(storyName:LevelName){
        COLLECTIONS_UNLOCK[storyName.getIndex()]=true;
        SaveCollectionUnlock();
    }
    public static function SpecialCollectionUnlocked()
    {
        COLLECTIONS_SPECIAL=true;
        SaveCollectionUnlock();
    }
    public static function SavePuzzle() {
        FlxG.save.data.puzzleSave=STORYMODE_PUZZLE_SAVE;
    }
    
    public static function SaveStory() {
        FlxG.save.data.storySave=STORY_UNLOCK_SAVE;
    }

    public static function SaveCollectionUnlock() {
        FlxG.save.data.collectionUnlock=COLLECTIONS_UNLOCK;
        FlxG.save.data.collectionSpecial=COLLECTIONS_SPECIAL;
    }

    public static function SaveHighScore(){
        FlxG.save.data.HighScore=HIGH_SCORE;
    }

    public static function SaveAll(){
        SavePuzzle();
        SaveStory();
        SaveCollectionUnlock();
        SaveHighScore();
    }

    public static function LoadAll(){
        STORYMODE_PUZZLE_SAVE = FlxG.save.data.puzzleSave;
        STORY_UNLOCK_SAVE=FlxG.save.data.storySave=STORY_UNLOCK_SAVE;
        COLLECTIONS_UNLOCK=FlxG.save.data.collectionUnlock;
        COLLECTIONS_SPECIAL=FlxG.save.data.collectionSpecial;
        HIGH_SCORE=FlxG.save.data.HighScore;
    }
}